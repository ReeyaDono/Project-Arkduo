extends Area2D

@onready var boss_fight = $"../BossFight"

func _on_body_entered(body):
	set_deferred("monitoring", false)
	if body.name == "Player":
		body.set_collision_mask_value(8, true)
	var tween = create_tween()
	tween.tween_property(boss_fight, "modulate:a", 1, 2)
	tween.tween_callback(boss_fight.start_fight)
