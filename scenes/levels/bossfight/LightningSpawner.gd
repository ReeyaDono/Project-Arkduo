extends Node2D

@onready var lightnings = [$Ligthning, $Ligthning2, $Ligthning3, $Ligthning4, $Ligthning5, $Ligthning6, $Ligthning7, $Ligthning8, $Ligthning9, $Ligthning10]
@export var boss_seed: int = 0
@onready var rng = RandomNumberGenerator.new()

func _get_random_num():
	var numbers = [rng.randi_range(0, 9)]
	while numbers.size() < 3:
		var num = rng.randi_range(0, 9)
		if not numbers.has(num):
			numbers.append(num)
	
	return numbers
	
func init_seed():
	rng.seed = boss_seed
	
func call_lightnings():
	var numbers = _get_random_num()
	for i in numbers:
		lightnings[i].strike()
