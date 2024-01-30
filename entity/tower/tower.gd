extends Node2D

@export var bullet_scn: PackedScene

@onready var vision: Area2D = $Vision
@onready var shoot_timer: Timer = $ShootTimer

# Nullable
func get_closest_seen_enemy() -> Node2D:
	var bodies := vision.get_overlapping_bodies()
	var closest: Node2D
	var best_dist_sq := 99999.9
	if bodies.size() == 0: return null
	closest = bodies[0]
	for body in bodies:
		if body.position.distance_squared_to(position) < best_dist_sq:
			closest = body
	return closest

func _on_shoot_timer_timeout() -> void:
	var target := get_closest_seen_enemy()
	if not target:
		shoot_timer.stop()
		return
	SignalBus.add_to_scene.emit(
		(bullet_scn.instantiate() as Bullet).init(
			position.direction_to(target.position) * 500,
			position
		)
	)

func _on_vision_body_entered(body: Node2D) -> void:
	if shoot_timer.is_stopped():
		shoot_timer.start()
