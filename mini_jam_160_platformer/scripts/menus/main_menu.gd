extends Control


const OPTIONS_MENU := preload("res://scenes/menus/options_menu.tscn") as PackedScene
const LEVEL_SELECT := ("res://scenes/menus/level_select_menu.tscn") as String


func _on_start_button_pressed() -> void:
	GameManager.start_new_game()


func _on_level_select_button_pressed() -> void:
	#get_tree().change_scene_to_packed(LEVEL_SELECT)
	get_tree().change_scene_to_file(LEVEL_SELECT)


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_packed(OPTIONS_MENU)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
