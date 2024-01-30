extends Area2D

@export var detect_group: Groups.Names

signal target_enterred()

@onready var parent: Node2D = get_parent()

func get_all_targets() -> Array[Node2D]:
	return get_overlapping_bodies() \
		.filter(func(x): return x.is_in_group(Groups.group_name(detect_group)))

# Nullable
func get_closest_target() -> Node2D:
	var all := get_all_targets()
	if all.size() == 0:
		return null
	elif all.size() == 1:
		return all[0]
	var mypos := parent.position if parent else Vector2.ZERO
	var best: Node2D = null
	var bestdist_sq := 99999
	for body: Node2D in all:
		if body.position.distance_squared_to(mypos) < bestdist_sq:
			best = body
			bestdist_sq = body.position.distance_squared_to(mypos)
	return best

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(Groups.group_name(detect_group)): target_enterred.emit()
