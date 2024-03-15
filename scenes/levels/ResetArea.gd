extends Area2D

signal hit

@export var activate_hit_scanner: bool = true
var current_checkpoint = 0
var checkpoints = []

# Called when the node enters the scene tree for the first time.
func _ready():
	checkpoints.append(Vector2(312, 408))
	checkpoints.append($"../CameraAreaChange/Area2/CollisionShape2D".position)
	checkpoints.append($"../CameraAreaChange/Area3/CollisionShape2D".position)
	checkpoints.append($"../CameraAreaChange/Area4/CollisionShape2D".position)
	checkpoints.append($"../CameraAreaChange/Area5/CollisionShape2D".position)
	checkpoints.append($"../CameraAreaChange/Area6/CollisionShape2D".position)
	checkpoints.append($"../CameraAreaChange/Area7/CollisionShape2D".position)


func _on_body_entered(body):
	if body.name == "Player":
		body.velocity = Vector2.ZERO
		body.position = checkpoints[current_checkpoint]
		if activate_hit_scanner:
			hit.emit()
