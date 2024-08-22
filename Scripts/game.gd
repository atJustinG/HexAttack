extends Node3D


@onready var camera: Camera3D = $Camera3D
@onready var raycast: RayCast3D = $Camera3D/RayCast3D

var highlighted_tile = null
var original_material = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	raycast.enabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_raycast_from_mouse()
	highlight_tile_under_mouse()

# function soll ein Tile bei mouseover hervorheben
func highlight_tile_under_mouse() -> void:
	if raycast.is_colliding():
		var collided_object = raycast.get_collider()
		
		if collided_object.is_in_group("tileGroup"):
			if collided_object != highlighted_tile:
				if highlighted_tile != null:
					highlighted_tile.material_override = original_material
				#neues Tile hervorheben
				highlighted_tile = collided_object
				original_material = highlighted_tile.material_override
				
				#weißes highlight erstellen
				if original_material != null:
					var highlight_material = original_material.duplicate()
					highlight_material.albedo_color(1, 1, 1) #weiß
					highlighted_tile.material_override = highlight_material
		else:
			#wenn kein tile getroffen wird highlight zurücksetzen
			if highlighted_tile != null:
				highlighted_tile.material_override = original_material
				highlighted_tile = null
	else:
		#wenn kein Objekt getroffen wird zurücksetzen 
		if highlighted_tile != null:
				highlighted_tile.material_override = original_material
				highlighted_tile = null


func update_raycast_from_mouse() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	
	raycast.transform.origin = ray_origin
	raycast.target_position = ray_direction*1000
	raycast.force_raycast_update()  # Erzwinge ein Update des RayCasts
