extends Node


enum Directions {
	NORTH,
	SOUTH,
	EAST,
	WEST
}

var direction_pairs: Dictionary = {
	Directions.NORTH: Vector2.UP,
	Directions.SOUTH: Vector2.DOWN,
	Directions.EAST: Vector2.RIGHT,
	Directions.WEST: Vector2.LEFT
}
