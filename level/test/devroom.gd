extends Node2D
@onready var timer: Timer = $Timer
@export var tower_scn: PackedScene
@onready var player: Player = $Player

func _ready() -> void:
	SignalBus.add_to_scene.connect(add_child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(&"ui_accept"):
		if not timer.is_stopped(): return
		timer.start()
		var node := (tower_scn.instantiate() as Node2D)
		node.position = player.position
		add_child(node)
