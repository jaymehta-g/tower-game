extends Enemy

@export var bullet_tscn: PackedScene

var player_target: Player # Nullable
var avoid_distance: float = 250

func _ready() -> void:
	super()
	vision.target_entered.connect(_on_sight_body_entered)

func _process(delta: float) -> void:
	super(delta)
	if not player_target: return
	if not is_instance_valid(player_target): player_target = null
	if not player_target.position \
		.distance_squared_to(position) \
		< avoid_distance**2:
		
		move_direction = position.direction_to(player_target.position)
	else:
		move_direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	super(delta)

func _on_shoot_timer_timeout() -> void:
	if not player_target: return
	SignalBus.add_to_scene.emit(
		(bullet_tscn.instantiate() as Bullet).init(
			position.direction_to(player_target.position) * 300,
			position
		)
	)

func _on_sight_body_entered() -> void:
	player_target = vision.get_closest_target()
