extends Node3D


@onready var camera: Camera3D = $Camera3D
@onready var raycast: RayCast3D = $Camera3D/RayCast3D

var highlighted_tile: Node3D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	raycast.enabled = true
	print("Raycast enabled")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_raycast_from_mouse()
	highlight_tile_under_mouse()

# function soll ein Tile bei mouseover hervorheben
func highlight_tile_under_mouse() -> void:
	if raycast.is_colliding():
		var collided_object = raycast.get_collider()
		print("Raycast hit: ", collided_object.name)
		
		var potential_tile = collided_object
		print("Potential tile: ", potential_tile.name)
		
		if potential_tile.is_in_group("tileGroup"):
			print("object is in tileGroup")
			if potential_tile != highlighted_tile:
				#print("New Tile to highlight")
				unhighlight_current_tile()
				highlighted_tile = potential_tile
				highlighted_tile.highlight()
				#print("highlighted tile: ", highlighted_tile.name)
		else:
			unhighlight_current_tile()
	else:
		unhighlight_current_tile()

func unhighlight_current_tile() -> void:
	if highlighted_tile != null:
		highlighted_tile.unhighlight()
		highlighted_tile = null


func update_raycast_from_mouse() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	
	raycast.transform.origin = ray_origin
	raycast.target_position = ray_direction*1000
	raycast.force_raycast_update()  # Erzwinge ein Update des RayCasts
