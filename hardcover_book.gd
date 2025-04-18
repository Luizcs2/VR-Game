@tool
class_name BookEntity
extends XRToolsPickable

var book_name = "default name"
var book_summary = "default summary"
var book_price = 0

func _ready():
	change_label_visibility(false)
	self.picked_up.connect(_on_object_picked_up)
	self.grabbed.connect(_on_object_grabbed)
	self.dropped.connect(_on_object_dropped)

func change_label_visibility(vis: bool):
	self.get_node("label_title_text").visible = vis
	self.get_node("label_summary_text").visible = vis
	self.get_node("label_price_text").visible = vis
	
	self.get_node("label_title").visible = vis
	self.get_node("label_summary").visible = vis
	self.get_node("label_price").visible = vis
	
	self.get_node("label_background_mesh").visible = vis

func _on_object_picked_up(_pickable: XRToolsPickable):
	change_label_visibility(true)
	print(self.name, " picked up")

func _on_object_grabbed(_pickable: XRToolsPickable, by: Node3D):
	change_label_visibility(true)
	print(self.name, " grabbed by node:", by.name)

func _on_object_dropped(_pickable: XRToolsPickable):
	change_label_visibility(false)
	print(self.name, " dropped")

func set_title(title: String):
	self.book_name = title
	self.get_node("label_cover").text = title
	self.get_node("label_title_text").text = title

func set_price(price: float):
	self.book_price = price
	self.get_node("label_price_text").text = str(price)

func set_summary(summary: String):
	self.book_summary = summary
	self.get_node("label_summary_text").text = summary

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

func _process(_delta):
	if self.is_picked_up():
		if !is_object_in_front_of_camera(self, get_node("../../XROrigin3D/XRCamera3D").global_position):
			change_label_visibility(false)
		else:
			change_label_visibility(true)
