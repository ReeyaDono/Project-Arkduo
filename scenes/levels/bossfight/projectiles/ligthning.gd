extends Area2D

signal hit

func strike():
	var tween = get_tree().create_tween()
	tween.tween_property($Marker, "modulate:a", 255, 0.5)
	tween.tween_property($Marker, "modulate:a", 0, 0.3)
	tween.tween_callback(_strike)
	
func _strike():
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	hit.emit()
	print("Hit with lightning")

func _on_animated_sprite_2d_frame_changed():
	var frame_num = $AnimatedSprite2D.get_frame()
	if frame_num == 3:
		monitoring = true
	elif frame_num == 9:
		monitoring = false
