extends Area2D

signal hit

@export var projectile_speed = 500
var moving = false

func _process(delta):
	if moving:
		position += Vector2(1, 0).rotated(rotation)*projectile_speed*delta

func _on_body_entered(body):
	if body.get_collision_layer_value(2):
		hit.emit()
		#print("Hit with fireball")
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate:a", 0, 0.2)
	tween.tween_callback(_tween_callback)

func _tween_callback():
	queue_free()

func start_moving():
	moving = true
