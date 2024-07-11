extends HSlider


var bus_index: int


func _ready() -> void:
	bus_index = AudioServer.get_bus_index("Master")

	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))


func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(new_value))
