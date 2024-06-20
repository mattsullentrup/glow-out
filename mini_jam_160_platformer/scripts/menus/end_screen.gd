extends Control


const MAIN_MENU := "res://scenes/menus/main_menu.tscn" as String


func _on_button_pressed() -> void:
	SceneLoader.load_scene(MAIN_MENU)
