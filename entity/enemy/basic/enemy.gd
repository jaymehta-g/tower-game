extends CharacterBody2D
class_name Enemy

@export var bullet_tscn: PackedScene
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var vision: Vision = $Vision

var player_target: Player # Nullable
var move_speed: float = 200
var avoid_distance: float = 250
var health := 10

func _ready() -> void:
	hurtbox.damaged.connect(
		func(amnt: int): 
			health-=1
			if health <= 0:
				queue_free()
	)
	vision.target_entered.connect(_on_sight_body_entered)

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

func _on_sight_body_entered() -> void:
	player_target = vision.get_closest_target()

func _on_shoot_timer_timeout() -> void:
	if not player_target: return
	SignalBus.add_to_scene.emit(
		(bullet_tscn.instantiate() as Bullet).init(
			position.direction_to(player_target.position) * 300,
			position
		)
	)
