extends Control

@onready var circle = [$WhiteCircle, $BlackCircle]
var current = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	circle[0].move_to_front()

func flip_perspective(origin_pos: Vector2):
	current = 1 - current
	circle[current].set_scale(Vector2(1, 1))
	circle[current].set_position(origin_pos)
	circle[current].move_to_front()
	var tween = create_tween()
	tween.tween_property(circle[current], "scale", Vector2(200, 200), 1)
