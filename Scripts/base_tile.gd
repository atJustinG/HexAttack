extends Node3D


@onready var hex_grass_3: Node3D = $hex_grass3

var mesh_instance: MeshInstance3D
var default_material: Material
var highlight_material: Material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("base tile ", self)
	mesh_instance = find_mesh_instance(self)
	if mesh_instance:
		setup_materials()
	else:
		push_error("no MeshInstance3D found!")
	

func find_mesh_instance(node: Node) -> MeshInstance3D:
	if node is MeshInstance3D:
		return node
	for child in node.get_children():
		var result = find_mesh_instance(child)
		if result:
			return result
	return null

func setup_materials():
	default_material = mesh_instance.get_active_material(0)
	if not default_material:
		default_material = mesh_instance.mesh.surface_get_material(0) if mesh_instance.mesh else null
	if default_material:
		highlight_material = default_material.duplicate()
		highlight_material.albedo_color = Color(0,0,0)
	else:
		push_error("No material found on mesh")

func highlight():
	#print(self, "highlight is called")
	if mesh_instance and highlight_material:
		#print(self, "do highlight")
		mesh_instance.set_surface_override_material(0, highlight_material)


func unhighlight():
	if mesh_instance and default_material:
		mesh_instance.set_surface_override_material(0, default_material)
