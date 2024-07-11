class_name LoadingScreen
extends Control


@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar


func _ready() -> void:
	progress_bar.value = 0


func update_progress_bar(new_value: float) -> void:
	progress_bar.value = new_value * 100

	if progress_bar.value == progress_bar.max_value:
		queue_free()
