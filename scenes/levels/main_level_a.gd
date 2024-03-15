extends Node2D

signal hit
signal fight_finished

@export var boss_seed: int = 0
var hit_num: int = 0

func init_seed():
	$BossFight.boss_seed = boss_seed

func _on_hit():
	hit_num += 1
	print("Number of hit: " + str(hit_num))
	hit.emit()

func _on_bossfight_finish():
	fight_finished.emit()
