"""
Contains constant group names to avoid string reliance
and prevent misspelling errors
"""
extends Node
enum Names {
	PLAYER,
	ENEMY,
	FRIEND,
	FRIEND_HURTFUL,
	ENEMY_HURTFUL,
}
const _NAMES := [
	"player",
	"enemy",
	"friend",
	"friendly-hurtful",
	"enemy-hurtful",
]
func group_name(key: int):
	return _NAMES[key]
