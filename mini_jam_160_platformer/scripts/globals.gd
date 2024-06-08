extends Node


enum Directions {
	NORTH,
	SOUTH,
	EAST,
	WEST
}

var direction_pairs: Dictionary = {
	Directions.NORTH: Vector2.DOWN,
	Directions.SOUTH: Vector2.UP,
	Directions.EAST: Vector2.LEFT,
	Directions.WEST: Vector2.RIGHT
}
