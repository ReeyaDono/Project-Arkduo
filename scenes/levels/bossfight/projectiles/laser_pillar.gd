extends Area2D

signal hit

@onready var laser = $ColorRect
@export_range(0.0, 1.0, 0.01) var laser_progress: float = 1.0
@export var type_toggle = false
@export var a_side_collision_toggle = true
@export var b_side_collision_toggle = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if type_toggle:
		laser.material.set_shader_parameter("color", Vector4(0, 141, 247, 255))
		
func _process(_delta):
	laser.material.set_shader_parameter("progress", laser_progress)
	if laser_progress == 0:
		monitoring = false
	else:
		monitoring = true

func _on_body_entered(body):
	# Case mask 1 & 3
	if body.get_collision_mask_value(3) and a_side_collision_toggle:
		#print("hit with laser A")
		hit.emit()
	# Case mask 1 & 4
	elif body.get_collision_mask_value(4) and b_side_collision_toggle:
		#print("hit with laser B")
		hit.emit()
