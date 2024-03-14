extends Node2D

var move_range = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	_tween_up()


func _tween_up():
	var tween = create_tween()
	tween.tween_property(self, "position:y", self.position.y-move_range, 0.5)
	tween.tween_property(self, "position:y", self.position.y+move_range, 0.5)
	tween.tween_callback(_tween_down)

func _tween_down():
	var tween = create_tween()
	tween.tween_property(self, "position:y", self.position.y+move_range, 0.5)
	tween.tween_property(self, "position:y", self.position.y-move_range, 0.5)
	tween.tween_callback(_tween_up)
