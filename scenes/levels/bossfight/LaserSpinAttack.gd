extends Node2D

signal hit

@onready var lasers = [$LaserPillar, $LaserPillar2, $LaserPillar3]
@export var activate_hit_scanner: bool = true
var max_angle = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	_tween_left(0)
	_tween_left(1)
	_tween_left(2)
	
func toggle_laser_all():
	toggle_laser(0)
	toggle_laser(1)
	toggle_laser(2)
		
func toggle_laser(idx: int):
	var tween = get_tree().create_tween()
	tween.tween_property(lasers[idx], "laser_progress", 1-lasers[idx].laser_progress, 0.5)

func _tween_left(idx: int):
	var tween = get_tree().create_tween()
	tween.tween_property(lasers[idx], "rotation", lasers[idx].rotation-max_angle, 2)
	tween.tween_property(lasers[idx], "rotation", lasers[idx].rotation+max_angle, 2)
	tween.tween_callback(_tween_right.bind(idx))

func _tween_right(idx: int):
	var tween = get_tree().create_tween()
	tween.tween_property(lasers[idx], "rotation", lasers[idx].rotation+max_angle, 2)
	tween.tween_property(lasers[idx], "rotation", lasers[idx].rotation-max_angle, 2)
	tween.tween_callback(_tween_left.bind(idx))

func _on_laser_hit():
	if activate_hit_scanner:
		hit.emit()
