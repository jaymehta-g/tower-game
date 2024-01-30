extends CharacterBody2D
class_name Bullet
const ENEMY_MASK := 1<<3
const FRIENDLY_MASK := 1<<4

@export var group: Groups.Names

var is_emeny: bool

func init(vel: Vector2, pos: Vector2, enemy: bool = true) -> Bullet:
	velocity = vel
	position = pos
	is_emeny = enemy
	# collision_mask = ENEMY_MASK if enemy else FRIENDLY_MASK
	return self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_slide()

func _on_expire_timer_timeout() -> void:
	queue_free.call_deferred()
