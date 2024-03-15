extends Control

@onready var viewport1 = $Viewport1
@onready var viewport2 = $Viewport2
@onready var viewport_mask = $Viewport3
@onready var view = $Background
@onready var black_screen = $BlackFade
@onready var game_display = preload("res://scenes/levels/game_display.tscn")

func _ready():
	view.material.set_shader_parameter("viewport_a", viewport2.get_texture())
	view.material.set_shader_parameter("viewport_b", viewport1.get_texture())
	view.material.set_shader_parameter("viewport_mask", viewport_mask.get_texture())

func _on_exit_pressed():
	black_screen.visible = true
	var tween = create_tween()
	tween.tween_property(black_screen, "modulate:a", 1, 1)
	tween.tween_callback(get_tree().quit)

func _on_play_pressed():
	black_screen.visible = true
	var tween = create_tween()
	tween.tween_property(black_screen, "modulate:a", 1, 1)
	tween.tween_callback(get_tree().change_scene_to_packed.bind(game_display))
