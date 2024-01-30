extends Area2D
class_name Hurtbox

@export var listen_for_group: Groups.Names

signal damaged(amount: float)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(Groups.group_name(listen_for_group)):
		damaged.emit(1)
		body.queue_free()
