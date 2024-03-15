extends Control

@onready var view = $View
@onready var viewport_a = $ViewportA
@onready var viewport_b = $ViewportB
@onready var viewport_mask = $ViewportMask
@onready var viewport_mask_2 = $ViewportMask2
@onready var level_a = $ViewportA/main_level_a
@onready var level_b = $ViewportB/main_level_a
@onready var boss_mask = $ViewportMask2/BossPhase2Mask
@onready var circle_transition = $ViewportMask/circle_transition
@onready var player = $ViewportA/main_level_a/Player/AnimatedSprite2D
@onready var switch_cooldown_timer = $SwitchCooldownTimer
@onready var hit_label = $HitLabel
@onready var black_fade = $BlackFade
var num_hit = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var seed = rng.randi()
	level_a.boss_seed = seed
	level_a.init_seed()
	level_b.boss_seed = seed
	level_b.init_seed()
	view.material.set_shader_parameter("viewport_a", viewport_a.get_texture())
	view.material.set_shader_parameter("viewport_b", viewport_b.get_texture())
	view.material.set_shader_parameter("viewport_mask", viewport_mask.get_texture())
	_open_screen()

func _open_screen():
	var tween = create_tween()
	tween.tween_property(black_fade, "modulate:a", 0, 0.5)
	
func _close_screen():
	var tween = create_tween()
	tween.tween_property(black_fade, "modulate:a", 1, 0.5)

func _switch_is_on_cooldown():
	return switch_cooldown_timer.time_left > 0.0
	
func _on_hit():
	num_hit += 1
	hit_label.text = "Deaths: " + str(num_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Switch") and not _switch_is_on_cooldown():
		switch_cooldown_timer.start()
		$SwitchIndicator/CooldownIndicator.visible = true
		var view_pos = player.get_global_transform_with_canvas() * player.position
		# print("Player Position: " + str(view_pos))
		circle_transition.flip_perspective(view_pos)


func _on_main_level_a_phase_2_started():
	view.material.set_shader_parameter("viewport_mask", viewport_mask_2.get_texture())
	$SwitchIndicator/Glitch.visible = true

func _on_main_level_a_phase_2_toggle_base():
	boss_mask.toggle_base_mask()


func _on_main_level_a_phase_2_toggle_laser():
	boss_mask.toggle_laser_mask()


func _on_main_level_a_phase_2_toggle_spiral():
	boss_mask.toggle_spiral_mask()


func _on_switch_cooldown_timer_timeout():
	$SwitchIndicator/CooldownIndicator.visible = false


func _on_fight_finished():
	_close_screen()
