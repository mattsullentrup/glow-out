class_name MainMenu
extends ParentMenu


@export var level_select: Control
@export var options: Control
@export var menu_contents: VBoxContainer

@onready var start_button: Button = %StartButton


func _enter_tree() -> void:
	Globals.play_enter_transition(self)
	menu_contents.show()


func _ready() -> void:
	start_button.grab_focus()


func _on_start_button_pressed() -> void:
	GameManager.start_new_game()


func _on_level_select_button_pressed() -> void:
	menu_contents.hide()
	level_select.show()


func _on_options_button_pressed() -> void:
	menu_contents.hide()
	options.show()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_sub_menu_back_button_pressed() -> void:
	level_select.hide()
	options.hide()

	menu_contents.show()
	start_button.grab_focus()
