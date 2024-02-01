extends Node

var _all_enemies: Array[Enemy]

func register(e: Enemy):
	_all_enemies.append(e)
	e.tree_exiting.connect(func(x): _all_enemies.erase(x))

func get_all_enemies() -> Array[Enemy]:
	for enemy in _all_enemies:
		assert(is_instance_valid(enemy))
	return _all_enemies
