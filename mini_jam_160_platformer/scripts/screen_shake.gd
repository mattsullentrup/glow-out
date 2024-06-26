class_name ScreenShake
extends Node2D


@export var random_shake_strength: float = 30.0
@export var shake_decay_rate: float = 5.0
@export var noise_shake_speed: float = 30.0
@export var noise_shake_strength: float = 60.0

@export var intensity: float = 30.0

var camera: Camera2D
var noise_i: float = 0.0
var shake_strength: float = 0.0

@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var noise: FastNoiseLite = FastNoiseLite.new()


func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	rng.randomize()
	noise.seed = rng.randi()
	noise.frequency = 0.5


func _process(delta: float) -> void:
	shake_strength = lerpf(shake_strength, 0, shake_decay_rate * delta)
	camera.offset = get_noise_offset(delta)


func get_noise_offset(delta: float) -> Vector2:
	noise_i += delta * noise_shake_speed
	return Vector2(
		noise.get_noise_2d(1, noise_i) * shake_strength,
		noise.get_noise_2d(100, noise_i) * shake_strength
	)


func apply_shake() -> void:
	shake_strength = random_shake_strength


func get_random_offset() -> Vector2:
	return Vector2(
		rng.randf_range(-intensity, intensity),
		rng.randf_range(-intensity, intensity)
	)
