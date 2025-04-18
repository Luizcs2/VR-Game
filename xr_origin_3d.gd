extends XROrigin3D

@export var move_speed: float = 5.0
@export var sensitivity: float = 0.1

func _ready():
	# Lock cursor when game starts
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	# Mouse movement for looking
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		rotate_object_local(Vector3.RIGHT, deg_to_rad(-event.relative.y * self.sensitivity))


func _process(delta):
	# WASD movement
	var velocity = Vector3.ZERO
	
	if Input.is_key_pressed(KEY_W):
		velocity -= global_transform.basis.z
	if Input.is_key_pressed(KEY_S):
		velocity += global_transform.basis.z
	if Input.is_key_pressed(KEY_A):
		velocity -= global_transform.basis.x
	if Input.is_key_pressed(KEY_D):
		velocity += global_transform.basis.x
		
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	# Apply movement
	transform.origin += velocity.normalized() * move_speed * delta
