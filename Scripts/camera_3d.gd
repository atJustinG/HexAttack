extends Camera3D


const RAY_LENGTH = 1000


func shoot_ray() -> Dictionary:
	var mouse_pos = get_viewport().get_mouse_position()	
	var from = project_ray_origin(mouse_pos)
	var to = project_position(mouse_pos, RAY_LENGTH)
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)	
	return raycast_result
