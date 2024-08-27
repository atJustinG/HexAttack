extends Node3D


var player: Node3D
var speed = 3
var dir: Vector3 = Vector3.ZERO
var minZoom: int = 2
var maxZoom: int = 9


var mouse_sensitivity: float = 0.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent()
	print("player: ", player.rotation_degrees)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move(delta)

func move(delta: float) -> void:
	dir = Vector3(0,0,0)
	
	if Input.is_action_pressed("move_up"):
		move_up()
	if Input.is_action_pressed("move_down"):
		move_down()
	if Input.is_action_pressed("move_left"):
		move_left()
	if Input.is_action_pressed("move_right"):
		move_right()
	var direction = Vector3(dir.x, 0., dir.z)
	print("direction", direction)
	direction = direction.normalized()
	player.transform.origin -= direction * speed * delta

func move_up() -> void:
	dir += player.transform.basis.z

func move_down() ->void:
	dir -= player.transform.basis.z

func move_left() ->void:
	dir += player.transform.basis.x

func move_right() ->void:
	dir -= player.transform.basis.x
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("rotate_cam"):
		if event is InputEventMouseMotion:
			if event.relative.x:
				player.rotation_degrees.y -= event.relative.x * mouse_sensitivity
				rotation_degrees.x -= event.relative.y * mouse_sensitivity
				rotation_degrees.x = clamp(rotation_degrees.x, -45, 45)
			if event.relative.y:
				player.rotation_degrees.x -= event.relative.y * mouse_sensitivity
				rotation_degrees.x += event.relative.y * mouse_sensitivity
				rotation_degrees.x = clamp(rotation_degrees.x, -45, 45)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("zoom_in"):
		if(player.transform.origin.y > minZoom):
			player.transform.origin.y += - 1
	if Input.is_action_pressed("zoom_out"):
		if(player.transform.origin.y < maxZoom):
			player.transform.origin.y += + 1 
