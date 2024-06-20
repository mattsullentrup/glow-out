extends Control


func _ready() -> void:
	hide()


func _on_back_button_pressed() -> void:
	var menu: CanvasItem = get_parent().get_node("VBoxContainer")
	if menu is not CanvasItem:
		printerr("Invalid menu")
		return
	menu.show()
	hide()
