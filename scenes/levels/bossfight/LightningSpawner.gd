extends Node2D

@onready var lightnings = [$Ligthning, $Ligthning2, $Ligthning3, $Ligthning4, $Ligthning5, $Ligthning6, $Ligthning7, $Ligthning8, $Ligthning9, $Ligthning10]

func _get_random_num():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var numbers = [rng.randi_range(0, 9)]
	while numbers.size() < 3:
		var num = rng.randi_range(0, 9)
		if not numbers.has(num):
			numbers.append(num)
	
	return numbers
	
func call_lightnings():
	var numbers = _get_random_num()
	for i in numbers:
		lightnings[i].strike()
