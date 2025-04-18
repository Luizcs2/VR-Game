extends Area3D

func _ready():
	# Connect signals
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	#connect("")

func _on_body_entered(body: Node3D):
	if body is XROrigin3D:
		body.global_position = Vector3(0,0,0)
	elif body is BookEntity:
		body.global_position = Vector3(0,1,0)
	print(body.name, " body entered fall_catch_area")

func _on_area_entered(area: Area3D):
	print(area.name, " area entered fall_catch_area")
	
func _on_body_exited(body: Node3D):
	print(body.name, " body exited fall_catch_area")

func _on_area_exited(area: Area3D):
	print(area.name, " area exited fall_catch_area")
