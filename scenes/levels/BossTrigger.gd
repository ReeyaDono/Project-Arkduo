extends Area2D

@onready var boss_fight = $"../BossFight"

func _on_body_entered(body):
	monitoring = false
	var tween = get_tree().create_tween()
	tween.tween_property(boss_fight, "modulate:a", 255, 1)
	tween.tween_callback(boss_fight.start_fight)
