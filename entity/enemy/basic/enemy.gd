extends CharacterBody2D

@export var bullet_tscn: PackedScene
var player_target: Player
var move_speed: float = 200
var avoid_distance: float = 250

func _process(delta: float) -> void:
	if not player_target: return
	if not is_instance_valid(player_target): player_target = null
	if not player_target.position \
		.distance_squared_to(position) \
		< avoid_distance**2:
		
		velocity = position.direction_to(player_target.position)
	else:
		velocity = Vector2.ZERO
	velocity *= move_speed

func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_sight_body_entered(body: Node2D) -> void:
	if player_target or not body.is_in_group(&"player"): return
	print_debug("!")
	player_target = body

func _on_shoot_timer_timeout() -> void:
	if not player_target: return
	var scene := (bullet_tscn.instantiate() as Bullet).init(
		position.direction_to(player_target.position) * 300
	)
	scene.position = position
	get_parent().add_child(scene)
