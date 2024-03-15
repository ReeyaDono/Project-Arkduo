extends Control

@onready var base_mask = $BaseMask
@onready var spiral_mask = $SpiralMask
@onready var laser_mask = $LaserMask
@onready var cur_base_col = 0
@onready var cur_spiral_mask = false
@export_range(0.0, 1.0, 0.01) var laser_progress: float = 0.0

func _process(_delta):
	laser_mask.material.set_shader_parameter("progress", laser_progress)

func toggle_laser_mask():
	var tween = create_tween()
	tween.tween_property(self, "laser_progress", 1-laser_progress, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)

func toggle_base_mask():
	if cur_base_col == 0:
		print("To black")
		base_mask.set_color(Color.BLACK)
		cur_base_col = 1
	else:
		print("To white")
		base_mask.set_color(Color.WHITE)
		cur_base_col = 0

func toggle_spiral_mask():
	var tween = create_tween()
	if not cur_spiral_mask:
		spiral_mask.visible = true
		tween.tween_property(spiral_mask, "scale", Vector2(100, 100), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		cur_spiral_mask = true
	else:
		tween.tween_property(spiral_mask, "scale", Vector2(1, 1), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		tween.tween_callback(_hide_spiral)
		
func _hide_spiral():
	spiral_mask.visible = false
	cur_spiral_mask = false
