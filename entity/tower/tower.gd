extends Node2D

@export var bullet_scn: PackedScene

@onready var vision: Vision = $Vision
@onready var shoot_timer: Timer = $ShootTimer

func _on_shoot_timer_timeout() -> void:
	var target := vision.get_closest_target() # Nullable
	if not target:
		shoot_timer.one_shot = true
		return
	SignalBus.add_to_scene.emit(
		(bullet_scn.instantiate() as Bullet).init(
			position.direction_to(target.position) * 500,
			position
		)
	)

func _on_vision_body_entered() -> void:
	shoot_timer.one_shot = false
	if shoot_timer.is_stopped():
		shoot_timer.start()
