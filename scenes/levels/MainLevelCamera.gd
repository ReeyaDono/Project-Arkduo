extends Camera2D

@export var initial_position = Vector2(640, 360)
@onready var area2 = Vector2(1920, 360)
@onready var area3 = Vector2(2992, -64)
@onready var area4 = Vector2(4264, -376)
@onready var area5 = Vector2(4720, -408)
@onready var area6 = Vector2(5680, -1008)
@onready var area7 = Vector2(6304, -1216)
@onready var area8 = Vector2(6304, -1360)
@onready var reset_area = $"../ResetArea"

# Called when the node enters the scene tree for the first time.
func _ready():
	position = initial_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_1_body_entered(body):
	if body.name == "Player":
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", initial_position, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_2_body_entered(body):
	if body.name == "Player":
		if reset_area.current_checkpoint < 1:
			reset_area.current_checkpoint = 1
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area2, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_2r_body_entered(body):
	if body.name == "Player":
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area2, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_3_body_entered(body):
	if body.name == "Player":
		if reset_area.current_checkpoint < 2:
			reset_area.current_checkpoint = 2
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area3, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_3r_body_entered(body):
	if body.name == "Player":
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area3, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_4_body_entered(body):
	if body.name == "Player":
		if reset_area.current_checkpoint < 3:
			reset_area.current_checkpoint = 3
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area4, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_4r_body_entered(body):
	if body.name == "Player":
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area4, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_5_body_entered(body):
	if body.name == "Player":
		if reset_area.current_checkpoint < 4:
			reset_area.current_checkpoint = 4
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area5, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_5r_body_entered(body):
	if body.name == "Player":
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area5, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_6_body_entered(body):
	if body.name == "Player":
		if reset_area.current_checkpoint < 5:
			reset_area.current_checkpoint = 5
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area6, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_7_body_entered(body):
	if body.name == "Player":
		if reset_area.current_checkpoint < 6:
			reset_area.current_checkpoint = 6
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area7, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_8_body_entered(body):
	if body.name == "Player":
		$"../CameraAreaChange/Area7".set_deferred("monitoring", false)
		$"../CameraAreaChange/Area8".set_deferred("monitoring", false)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", area8, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
