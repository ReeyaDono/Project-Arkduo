extends Area2D

signal hit

func _ready():
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	if body.collision_layer == 2: # if hit player
		hit.emit()
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color(255, 255, 255, 0), 0.5)
	tween.tween_callback(queue_free)
