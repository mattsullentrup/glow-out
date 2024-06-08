class_name RoomExit
extends Area2D


signal player_exited_room(room: Room)

@export var exit_direction: Globals.Directions
@export var path_to_new_scene: PackedScene

var is_player_entering_room: bool = true


func _on_body_entered(body: Node2D) -> void:
	if not body is Player or is_player_entering_room:
		return

	player_exited_room.emit(path_to_new_scene, exit_direction)
	is_player_entering_room = false
	#queue_free()


func _on_body_exited(_body: Node2D) -> void:
	if is_player_entering_room:
		is_player_entering_room = false
