extends Node3D


const BASE_TILE = preload("res://Scenes/base_tile.tscn")

const zpos = 1.8
var offset = 1.8
var tiles = []

func spawn(col, row) -> void:
	for n in col:
		var new_row = [] # 2d matrix
		offset = 1
		if n%2 == 0: 
			offset = 0
		for m in row:
			#Tile Object wird instantiiert
			var tile = BASE_TILE.instantiate()
			get_parent().add_child(tile)
			#Tile position wird festgelegt
			tile.transform.origin.z = n * 1.8
			tile.transform.origin.x = (m * 2) + offset
			
			new_row.append(tile) # 2d matrix
		tiles.append(new_row)

func spawn_alternate(row, col)-> void:
	for n in range(col):
		var new_row = []
		offset = 1
		if n%2 == 0: 
			offset = 0
		for m in range(row):
			var tile = BASE_TILE.instantiate()
			tile.position = Vector3((m * 2) + offset, 0, n * 1.8)
			tile.add_to_group("tilesGroup")
			
			get_parent().add_child(tile)
			new_row.append(tile)
			
		tiles.append(new_row)


#get specific Tile
func get_tile(col: int, row: int) -> Node3D:
	if col >= 0 and col < tiles.size() and row >=0 and row < tiles[col].size():
		return tiles[col][row] 
	return null 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#call_deferred("spawn", 6, 6)
	call_deferred("spawn_alternate", 6, 6)
