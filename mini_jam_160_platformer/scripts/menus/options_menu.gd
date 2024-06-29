extends Control


@onready var back_button: Button = %BackButton


func _ready() -> void:
	hide()


func _on_back_button_pressed() -> void:
	var menu: CanvasItem = get_parent().get_node("VBoxContainer")
	if menu is not CanvasItem:
		printerr("Invalid menu")
		return
	menu.show()
	hide()


func _on_draw() -> void:
	back_button.grab_focus()
