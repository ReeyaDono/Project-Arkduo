extends Node2D

signal fight_finished
signal hit
signal phase2_started
signal phase2_toggle_base
signal phase2_toggle_spiral
signal phase2_toggle_laser

@export var boss_seed: int = 0

func _on_projectile_hit():
	hit.emit()
	#print("Hit in bossfight A")

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
	
func start_phase2():
	phase2_started.emit()

func toggle_base_phase2():
	phase2_toggle_base.emit()
	
func toggle_spiral_phase2():
	phase2_toggle_spiral.emit()
	
func toggle_laser_phase2():
	phase2_toggle_laser.emit()
