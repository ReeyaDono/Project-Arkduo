extends Node2D

signal fight_finished

@export var boss_seed: int = 0

func start_fight():
	$FireballSpawner.boss_seed = boss_seed
	$FireballSpawner.init_seed()
	$LightningSpawner.boss_seed = boss_seed
	$LightningSpawner.init_seed()
	$LaserPilarSpawner.boss_seed = boss_seed
	$LaserPilarSpawner.init_seed()
	$AnimationPlayer.play("Bossfight Scene")
	
func finish_fight():
	fight_finished.emit()
