extends Node2D

var pos1 = Vector2(-96, -16)
var pos2 = Vector2(0, 32)
var pos3 = Vector2(96, -16)

var angle1 = 100.0
var angle2 = 90.0
var angle3 = 80.0

var angle_range = 2.5

const fireball_scene = preload("res://scenes/levels/bossfight/projectiles/fireball.tscn")

func _create_fireball(pos: Vector2, angle: float):
	#print("Spawn angle: " + str(angle))
	var fireball = fireball_scene.instantiate()
	add_child(fireball)
	fireball.position = pos
	fireball.rotation = angle
	fireball.start_moving()

func spawn_fireball():
	var rng = RandomNumberGenerator.new()
	_create_fireball(pos1, rng.randf_range(90, 91))
	_create_fireball(pos2, rng.randf_range(89, 90))
	_create_fireball(pos3, rng.randf_range(69, 70))