extends Object
class_name TilePos
## Represents a tile position using cubic/axial coordinates
##
## QRS are nice for calculating positions, but are hard to grasp.
## Consider using [member from_array_pos] to generate TilePos
##
## @tutorial(d): https://www.redblobgames.com/grids/hexagons/

var q: int
var r: int
var s: int:
	get:
		return -q-r


## Create a new TilePos using the cubic coordinates
func _init(q: int, r: int):
	self.q = q
	self.r = r
	self.s = -q-r


## Add two positions together
func add(tp: TilePos):
	return TilePos.new(q+tp.q, r+tp.r)
	
	
## Add two positions together
func multiply(i: int):
	return TilePos.new(q*i, r*i)


## Create a TilePos from a given row, col from the TileSpawner array
static func from_array_pos(col, row) -> TilePos:
	var new_q = col
	var new_r = -row - (col + (col&1)) / 2
	return TilePos.new(new_q, new_r)


## Convert this TilePos to array coordinates we use for saving the tiles
func to_array_pos() -> Vector2i:
	var col: int = q
	var row: int = -(r + (q + (q&1)) / 2)
	return Vector2i(col, row)
		

## Represent the QRS like a Vector3i	
func _to_string():
	return str(to_array_pos())
