extends Node3D

@onready var camera = $Camera3D

var highlight_list: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for foo in highlight_list:
		foo.unhighlight()
	
	var dictionary : Dictionary = camera.shoot_ray()
	if dictionary:
		var collider: StaticBody3D = dictionary["collider"]
		var baseTile: Node3D = collider.get_parent().get_parent()
		print(baseTile)
		baseTile.highlight()
		highlight_list.append(baseTile)
