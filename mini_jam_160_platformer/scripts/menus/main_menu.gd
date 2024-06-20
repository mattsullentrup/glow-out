extends Control


const OPTIONS_MENU := preload("res://scenes/menus/options_menu.tscn") as PackedScene
const LEVEL_SELECT := preload("res://scenes/menus/level_select_menu.tscn") as PackedScene


func _enter_tree() -> void:
	Globals.play_enter_transition(self)


func _on_start_button_pressed() -> void:
	GameManager.start_new_game()


func _on_level_select_button_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_SELECT)


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_packed(OPTIONS_MENU)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
