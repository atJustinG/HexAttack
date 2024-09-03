extends Node3D

@onready var camera = $Camera3D

var highlight_list: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_highlights: Array = []
	var dictionary: Dictionary = camera.shoot_ray()
	if dictionary:
		var collider: StaticBody3D = dictionary["collider"]
		var baseTile: Node3D = collider.get_parent().get_parent()
		if not highlight_list.has(baseTile):
			baseTile.highlight()
		new_highlights.append(baseTile)
	for foo: Node3D in highlight_list:
		if not new_highlights.has(foo):
			foo.unhighlight()
	highlight_list = new_highlights
	
