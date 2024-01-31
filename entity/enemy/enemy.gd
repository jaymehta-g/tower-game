extends CharacterBody2D
class_name Enemy

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var vision: Vision = $Vision

var health := 10

func _ready() -> void:
	hurtbox.damaged.connect(
		func(amnt: int): 
			health-=1
			if health <= 0:
				queue_free()
	)

func _physics_process(delta: float) -> void:
	move_and_slide()

