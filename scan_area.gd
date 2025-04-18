extends Area3D

func _ready():
	# Connect signals
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)

func _on_body_entered(body: Node3D):
	if body is BookEntity:
		self.get_parent().get_node("book_prices").visible = false
		self.get_parent().get_node("book_names").visible = false
		self.get_parent().get_node("book_total_price").visible = false
		self.get_parent().get_node("baggage_area_alert").visible = true
		self.get_parent().get_node("Screen").set_surface_override_material(1, self.get_parent().scanning_screen_material)
	print(body.name, " body entered scan_area")

func _on_area_entered(area: Area3D):
	print(area.name, " area entered scan_area")
	
func _on_body_exited(body: Node3D):
	if body is BookEntity:
		self.get_parent().get_node("book_prices").visible = true
		self.get_parent().get_node("book_names").visible = true
		self.get_parent().get_node("book_total_price").visible = true
		self.get_parent().get_node("baggage_area_alert").visible = false
		self.get_parent().get_node("Screen").set_surface_override_material(1, self.get_parent().default_screen_material)
		self.get_parent().current_books[body] = {
			"name" = body.book_name,
			"price" = body.book_price
		}
	print(body.name, " body exited scan_area")

func _on_area_exited(area: Area3D):
	print(area.name, " area exited scan_area")
