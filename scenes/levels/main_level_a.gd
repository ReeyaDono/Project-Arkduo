extends Node2D

signal hit
signal fight_finished
signal phase2_started
signal phase2_toggle_base
signal phase2_toggle_spiral
signal phase2_toggle_laser

@export var boss_seed: int = 0

func init_seed():
	$BossFight.boss_seed = boss_seed

func _on_hit():
	hit.emit()

func _on_bossfight_finish():
	fight_finished.emit()


func _on_boss_fight_phase_2_started():
	phase2_started.emit()


func _on_boss_fight_phase_2_toggle_base():
	phase2_toggle_base.emit()


func _on_boss_fight_phase_2_toggle_laser():
	phase2_toggle_laser.emit()


func _on_boss_fight_phase_2_toggle_spiral():
	phase2_toggle_spiral.emit()
