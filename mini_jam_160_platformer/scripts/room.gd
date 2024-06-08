class_name Room
extends Node2D


@export var initial_player_velocity: float
@export var initial_player_position: Node2D

var previous_player_direction

@onready var player: Player = $Player


func _ready() -> void:
	player.position = initial_player_position.position
	#if previous_player_direction != null:
		#player.velocity = Globals.direction_pairs[previous_player_direction] * initial_player_velocity
