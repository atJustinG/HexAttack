extends Node
class_name TileSystem
## Interface object to the TileSystem.
##
## TileSpawner handles generation and storage of the tiles.

@onready var _spawner = $TileSpawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


## Get the tile at [param pos].
## Returns null when it can not be found: Out of bounds, not yet initialized etc.
func get_tile(pos: TilePos) -> BaseTile:
	var ap: Vector2i = pos.to_array_pos()
	return _spawner.get_tile(ap.x, ap.y)
	
