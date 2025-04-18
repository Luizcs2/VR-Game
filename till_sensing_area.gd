extends Area3D

var current_items = []
#func _process(delta):
	#print(get_overlapping_bodies())

func _ready():
	# Connect signals
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)

func _on_body_entered(body: Node3D):
	print("Body entered:", body.name)

func _on_area_entered(area: Area3D):
	print("Area entered:", area.name)
	
func _on_body_exited(body: Node3D):
	print("Body exited:", body.name)

func _on_area_exited(area: Area3D):
	print("Area exited:", area.name)
