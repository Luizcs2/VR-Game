extends Area3D

func _ready():
	# Connect signals
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)

func _on_body_entered(body: Node3D):
	print(body.name, " body entered storage_area")

func _on_area_entered(area: Area3D):
	print(area.name, " area entered storage_area")
	
func _on_body_exited(body: Node3D):
	if body is BookEntity:
		self.get_parent().current_books.erase(body)
	print(body.name, " body exited storage_area")

func _on_area_exited(area: Area3D):
	print(area.name, " area exited storage_area")
