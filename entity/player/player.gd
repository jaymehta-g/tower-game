extends CharacterBody2D
class_name Player

@export var stats: PlayerStats

var input_dir: Vector2
var health: float

func _ready() -> void:
	health = stats.max_health

func _process(delta: float) -> void:
	input_dir = Input.get_vector(&"ui_left",&"ui_right",&"ui_up", &"ui_down")
	if health == 0:
		queue_free()

func _physics_process(delta: float) -> void:
	velocity = input_dir*stats.move_speed
	move_and_slide()

func _on_hurtbox_damaged(amount: float) -> void:
	health -= amount
