class_name LevelExit
extends Area2D


signal player_exiting_level


func _ready() -> void:
	player_exiting_level.connect(GameManager._on_player_exiting_level)


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return

	var player: Player = body
	if not player.has_key:
		return

	#player.animated_sprite.hide()
	#player.footstep_sound.playing = false
	#player.visible = false
	#player.process_mode = Node.PROCESS_MODE_DISABLED
	#player.set_process(false)
	#player.set_process_input(false)
	#player.set_physics_process(false)
	player_exiting_level.emit()
