extends Control


const MAIN_MENU := "res://scenes/menus/main_menu.tscn" as String


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU)
