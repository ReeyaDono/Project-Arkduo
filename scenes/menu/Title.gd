extends ColorRect

@export var move_range: float = 2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	_tween_up()


func _tween_up():
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y-move_range, 0.25)
	tween.tween_property(self, "position:y", position.y+move_range, 0.25)
	tween.tween_callback(_tween_down)

func _tween_down():
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y+move_range, 0.25)
	tween.tween_property(self, "position:y", position.y-move_range, 0.25)
	tween.tween_callback(_tween_up)
