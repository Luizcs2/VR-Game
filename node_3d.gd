@tool
extends Node3D
class_name Books

# Export variables for easy assignment in the Inspector
@export var book_title: String = ""
@export var book_summary: String = ""
@export var book_price: float = 0.0
@export var book_model_1: String = "res://books_&_ bookshelf_Luiz/book1.fbx"  # Path for book 1
@export var book_model_2: String = "res://books_&_ bookshelf_Luiz/book2.fbx"  # Path for book 2
@export var book_model_3: String = "res://books_&_ bookshelf_Luiz/book3.fbx"  # Path for book 3
@export var book_model_4: String = "res://books_&_ bookshelf_Luiz/book4.fbx"  # Path for book 4

# Called when the node enters the scene tree for the first time
func _ready():
	if Engine.is_editor_hint():
		return  # Don't execute in editor
		
	# Set initial values for the book
	if book_title != "":
		set_title(book_title)
	if book_summary != "":
		set_summary(book_summary)
	if book_price > 0:
		set_price(book_price)
	
	# Load and instantiate the specified book model
	if book_model_1 != "":
		load_and_add_model(book_model_1)
	elif book_model_2 != "":
		load_and_add_model(book_model_2)
	elif book_model_3 != "":
		load_and_add_model(book_model_3)
	elif book_model_4 != "":
		load_and_add_model(book_model_4)
	
	# Hide labels by default
	change_label_visibility(false)
	
	# Connect signals to handle interaction
	if has_method("picked_up"):
		self.picked_up.connect(_on_object_picked_up)
	if has_method("grabbed"):
		self.grabbed.connect(_on_object_grabbed)
	if has_method("dropped"):
		self.dropped.connect(_on_object_dropped)

# Change the visibility of book labels (title, summary, price)
func change_label_visibility(vis: bool):
	if has_node("label_title_text"):
		get_node("label_title_text").visible = vis
	if has_node("label_summary_text"):
		get_node("label_summary_text").visible = vis
	if has_node("label_price_text"):
		get_node("label_price_text").visible = vis
	if has_node("label_title"):
		get_node("label_title").visible = vis
	if has_node("label_summary"):
		get_node("label_summary").visible = vis
	if has_node("label_price"):
		get_node("label_price").visible = vis
	if has_node("label_background_mesh"):
		get_node("label_background_mesh").visible = vis

# Signal handler when the book is picked up
func _on_object_picked_up(_pickable):
	change_label_visibility(true)
	print(self.name, " picked up")

# Signal handler when the book is grabbed
func _on_object_grabbed(_pickable, by):
	change_label_visibility(true)
	print(self.name, " grabbed by node:", by.name)

# Signal handler when the book is dropped
func _on_object_dropped(_pickable):
	change_label_visibility(false)
	print(self.name, " dropped")

# Set the book's title and update the UI
func set_title(title: String):
	self.book_title = title
	if has_node("label_cover"):
		get_node("label_cover").text = title
	if has_node("label_title_text"):
		get_node("label_title_text").text = title

# Set the book's price and update the UI
func set_price(price: float):
	self.book_price = price
	if has_node("label_price_text"):
		get_node("label_price_text").text = str(price)

# Set the book's summary and update the UI
func set_summary(summary: String):
	self.book_summary = summary
	if has_node("label_summary_text"):
		get_node("label_summary_text").text = summary

# Load and instantiate a book model and add it to the scene
func load_and_add_model(model_path: String):
	if model_path.is_empty():
		return
		
	var model_scene = load(model_path)
	if model_scene != null:
		var book_model = model_scene.instantiate()
		
		# Position the book model
		book_model.position = Vector3.ZERO
		
		# Standard rotation for books on a shelf
		book_model.rotate(Vector3.FORWARD, deg_to_rad(90))
		book_model.rotate(Vector3.LEFT, deg_to_rad(90))
		book_model.rotate(Vector3.RIGHT, deg_to_rad(180))
		
		add_child(book_model)
	else:
		print("Failed to load model: ", model_path)

# Helper function to check if the object is in front of the camera
func is_object_in_front_of_camera(main_obj: Node3D, viewed_obj_position: Vector3, 
								  threshold_angle: float = 45.0) -> bool:
	# Get view direction from camera
	var view_direction = main_obj.global_transform.basis.y
	
	# Calculate direction from camera to object
	var direction_to_object = (viewed_obj_position - main_obj.global_transform.origin).normalized()
	
	# Calculate angle between view direction and direction to object
	var angle = rad_to_deg(acos(view_direction.dot(direction_to_object)))
	
	# Check if object is within viewing angle
	return angle <= threshold_angle

# Update the visibility of labels based on the object's position in front of the camera
func _process(_delta):
	if has_method("is_picked_up") and self.is_picked_up():
		var camera = get_viewport().get_camera_3d()
		if camera and !is_object_in_front_of_camera(self, camera.global_position):
			change_label_visibility(false)
		else:
			change_label_visibility(true)
