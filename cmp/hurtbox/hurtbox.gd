extends Area2D
class_name Hurtbox

@export_enum(
	Groups.FRIEND_HURTFUL,
	Groups.ENEMY_HURTFUL,
) var listen_for_group: String

signal damaged(amount: float)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(listen_for_group):
		damaged.emit(1)
		body.queue_free()
