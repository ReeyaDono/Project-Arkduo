extends Control

@onready var view = $View
@onready var viewport_a = $ViewportA
@onready var viewport_b = $ViewportB
@onready var viewport_mask = $ViewportMask
@onready var circle_transition = $ViewportMask/circle_transition
@onready var player = $ViewportA/main_level_a/Player/AnimatedSprite2D
@onready var switch_cooldown_timer = $SwitchCooldownTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	view.material.set_shader_parameter("viewport_a", viewport_a.get_texture())
	view.material.set_shader_parameter("viewport_b", viewport_b.get_texture())
	view.material.set_shader_parameter("viewport_mask", viewport_mask.get_texture())

func _switch_is_on_cooldown():
	return switch_cooldown_timer.time_left > 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Switch") and not _switch_is_on_cooldown():
		switch_cooldown_timer.start()
		var view_pos = player.get_global_transform_with_canvas() * player.position
		# print("Player Position: " + str(view_pos))
		circle_transition.flip_perspective(view_pos)
