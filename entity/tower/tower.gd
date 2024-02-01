extends Node2D

@export var bullet_scn: PackedScene

@onready var vision: Vision = $Vision
@onready var shoot_timer: Timer = $ShootTimer

func _on_shoot_timer_timeout() -> void:
	var target := _get_target() # Nullable
	if not target:
		shoot_timer.one_shot = true
		return
	SignalBus.add_to_scene.emit(
		(bullet_scn.instantiate() as Bullet).init(
			position.direction_to(target.position) * 500,
			position
		)
	)

# Nullable
# Prioritise the enemy closest to the player,
# shoot closest enemy otherwise
func _get_target() -> Node2D: 
	var targets:= vision.get_all_targets()
	if targets.size() == 0: return null
	if targets.size() == 1: return targets[0]
	if not Globals.player: return vision.get_closest_target()
	
	# get closest target to player
	return targets.reduce(func(a: Node2D, b: Node2D):
		if _node_dist2_to_player(a) < _node_dist2_to_player(b):
				return a
		return b
	)

# pre: Globals.player.position != null
func _node_dist2_to_player(n: Node2D) -> float:
	return n.position.distance_squared_to(Globals.player.position)

func _on_vision_body_entered() -> void:
	shoot_timer.one_shot = false
	if shoot_timer.is_stopped():
		shoot_timer.start()
