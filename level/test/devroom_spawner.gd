extends Node2D
@onready var timer: Timer = $Timer

@export var enemy_scn: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var node := (enemy_scn.instantiate() as Enemy)
	node.position = position + Vector2.RIGHT.rotated(randf()) * 300
	SignalBus.add_to_scene.emit(node)
