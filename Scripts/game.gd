extends Node3D

@onready var camera = $Camera3D

<<<<<<< Updated upstream
=======
@onready var camera: Camera3D = $Camera3D
@onready var raycast: RayCast3D = $RayCast3D


var highlighted_tile: Node3D = null
>>>>>>> Stashed changes
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


<<<<<<< Updated upstream
func _input(event):
	if(event.is_action_pressed("click")):
		camera.shoot_ray()
=======
func update_raycast_from_mouse() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos).normalized()
	ray_origin.y += 10
	var ray_direction = camera.project_ray_normal(mouse_pos)

	raycast.transform.origin = ray_origin
	raycast.target_position = ray_direction*1000
	#DebugDraw.line_3d(mouse_pos, raycast.target_position, Color.RED)
	raycast.force_raycast_update()  # Erzwinge ein Update des RayCasts
>>>>>>> Stashed changes
