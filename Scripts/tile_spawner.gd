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
			var tile = BASE_TILE.instantiate()
			get_parent().add_child(tile)
			new_row.append(m) # 2d matrix
			tile.transform.origin.z = n * 1.8
			tile.transform.origin.x = (m * 2) + offset
		tiles.append(new_row) # 2d matrix
	#2d matrix wip
	for a in tiles:
		print(a)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("spawn", 6, 6)
