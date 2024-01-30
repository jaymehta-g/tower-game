extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.add_to_scene.connect(add_child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
