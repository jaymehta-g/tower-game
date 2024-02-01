extends Area2D
class_name Vision

# This jank because export_enum currently doesnt support arrays!
# Keep the enum and GROUP_NAMES parallel!
# FUTURE update when array support added
enum GroupChoices {
	Player, 
	Enemy, 
	Friend,
}

const GROUP_NAMES := [
	Groups.PLAYER,
	Groups.ENEMY,
	Groups.FRIEND,
]

@export var detect_groups: Array[GroupChoices]

signal target_entered

@onready var parent: Node2D = get_parent()

func get_all_targets() -> Array[Node2D]:
	return get_overlapping_bodies() \
		.filter(_body_in_any_detect_groups)

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
	if _body_in_any_detect_groups(body): target_entered.emit()

func _body_in_any_detect_groups(b: Node) -> bool:
	var group_names = detect_groups.map(func(g): return GROUP_NAMES[g])
	return group_names.any(func(name): return b.is_in_group(name))
