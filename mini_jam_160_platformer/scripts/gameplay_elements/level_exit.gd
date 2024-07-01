class_name LevelExit
extends Area2D


signal player_exiting_level

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	player_exiting_level.connect(GameManager._on_player_exiting_level)


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return

	var player: Player = body
	if not player.has_key:
		return

	audio_stream_player.play()
	player_exiting_level.emit()
