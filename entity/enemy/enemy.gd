"""
Base class for all enemies
Implements movement through move_direction,
Soft collision,
Hurtbox,
Health,
Don't modify velocity directly!
Remember to call super() for builtins!
"""

extends CharacterBody2D
class_name Enemy

@export var soft_collision_strength: float
@export var move_speed: float

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var vision: Vision = $Vision
@onready var soft_collision: Area2D = $SoftCollision

var move_direction: Vector2
var health := 10

func _ready() -> void:
	hurtbox.damaged.connect(
		func(amnt: int): 
			health-=1
			if health <= 0:
				queue_free()
	)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = move_direction.normalized() * move_speed
	for body: Node2D in soft_collision.get_overlapping_bodies():
		if body == self: continue
		var accel := soft_collision_strength / position.distance_to(body.position)
		var vect := position.direction_to(body.position) * accel * -1
		velocity += vect
	move_and_slide()
