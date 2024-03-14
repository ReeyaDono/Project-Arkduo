extends Node2D

@export var type_toggle: bool = false
var left_start_pos = Vector2(-672, -360)
var right_start_pos = Vector2(672, -360)

const laser_pillar_scene = preload("res://scenes/levels/bossfight/projectiles/laser_pillar.tscn")
	
func _random_choice():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if rng.randi_range(0, 1) == 0:
		return "A"
	return "B"
	
func spawn_pillar_right():
	var type = _random_choice()
	var laser_pillar = _create_pillar(type)
	laser_pillar.position = right_start_pos
	add_child(laser_pillar)
	var tween = get_tree().create_tween()
	tween.tween_property(laser_pillar, "position", left_start_pos, 2)
	tween.tween_callback(laser_pillar.queue_free)
	
func spawn_pillar_left():
	var type = _random_choice()
	var laser_pillar = _create_pillar(type)
	laser_pillar.position = left_start_pos
	add_child(laser_pillar)
	var tween = get_tree().create_tween()
	tween.tween_property(laser_pillar, "position", right_start_pos, 2)
	tween.tween_callback(laser_pillar.queue_free)

func _create_pillar(type: String):
	var laser_pillar = laser_pillar_scene.instantiate()
	if type == "A":
		laser_pillar.type_toggle = false
		laser_pillar.a_side_collision_toggle = true
		laser_pillar.b_side_collision_toggle = false
		if type_toggle == true:
			laser_pillar.laser_progress = 0.03
	else:
		laser_pillar.type_toggle = true
		laser_pillar.a_side_collision_toggle = false
		laser_pillar.b_side_collision_toggle = true
		if type_toggle == false:
			laser_pillar.laser_progress = 0.03
			
	return laser_pillar
	
