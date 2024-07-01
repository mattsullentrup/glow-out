extends ParentMenu


const MAIN_MENU := "res://scenes/menus/main_menu.tscn" as String

@export var options: Control
@export var menu_contents: VBoxContainer

@onready var options_button: Button = %OptionsButton


func _ready() -> void:
	hide()


func _process(_delta: float) -> void:
	if not Input.is_action_just_pressed("pause"):
		return

	if get_tree().paused == true:
		get_tree().paused = false
		options.hide()
		hide()
	elif get_tree().paused == false:
		show()
		menu_contents.show()
		get_tree().paused = true


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	SceneLoader.load_scene(MAIN_MENU)


func _on_options_button_pressed() -> void:
	menu_contents.hide()
	options.show()


func _on_draw() -> void:
	Globals.mute_click_sound_on_menu_change(options_button)


func _on_sub_menu_back_button_pressed() -> void:
	options.hide()
	menu_contents.show()
	Globals.mute_click_sound_on_menu_change(options_button)
