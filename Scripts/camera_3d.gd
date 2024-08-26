extends Camera3D

const RAY_LENGTH = 1000
var highlight_list: Array = []

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not highlight_list.is_empty():
		highlight_list.pick_random().unhighlight()
		#print("unhighlighted!!!")
	for foo in highlight_list:
			foo.unhighlight()
	var dictionary : Dictionary = shoot_ray()
	if dictionary:
		var collider: StaticBody3D = dictionary["collider"]
		var baseTile: Node3D = collider.get_parent().get_parent()
		baseTile.highlight()
		if not baseTile in highlight_list:
			#print("taleHighlighted!!")
			highlight_list.append(baseTile)
