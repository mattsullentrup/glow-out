class_name Level
extends Node2D


@export var initial_room: Room
@export var player: Player

static var current_room: Room

@onready var camera: Camera2D = $Camera2D


func _ready() -> void:
	player.position = $StartPosition.position

	current_room = initial_room
	#toggle_room(current_room, true)

	for child: Room in get_tree().get_nodes_in_group("rooms"):
		if child != initial_room:
			toggle_room(child, false)

	for exit: RoomExit in get_tree().get_nodes_in_group("exits"):
		exit.player_exited_room.connect(_on_player_exited_room)


func load_new_room(new_room: Room, entry_door: RoomExit, exit_direction: Globals.Directions) -> void:
	toggle_room(current_room, false)

	toggle_room(new_room, true)
	camera.enabled = true

	new_room.player = player
	new_room.setup_player(entry_door, exit_direction)
	current_room = new_room


func toggle_room(room: Room, should_be_active: bool) -> void:
	if should_be_active == true:
		room.process_mode = Node.PROCESS_MODE_INHERIT
		#add_child(room)
	else:
		room.process_mode = Node.PROCESS_MODE_DISABLED
		#remove_child(room)
	room.visible = should_be_active
	room.get_node("TileMapLayer").enabled = should_be_active


func _on_player_exited_room(new_room: Room, entry_door: RoomExit, exit_direction: Globals.Directions) -> void:
	camera.enabled = false
	camera.position = new_room.position
	camera.reset_physics_interpolation()
	load_new_room.call_deferred(new_room, entry_door, exit_direction)
