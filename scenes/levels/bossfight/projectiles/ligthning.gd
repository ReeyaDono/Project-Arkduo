extends Area2D

signal hit

func strike():
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	hit.emit()

func _on_animated_sprite_2d_frame_changed():
	var frame_num = $AnimatedSprite2D.get_frame()
	if frame_num == 3:
		monitoring = true
	elif frame_num == 9:
		monitoring = false
