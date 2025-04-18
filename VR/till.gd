extends Node3D

var current_books = {}
var currently_scanning = false
var default_screen_material = StandardMaterial3D.new()
var scanning_screen_material = StandardMaterial3D.new()

func _ready() -> void:
	scanning_screen_material.albedo_color = Color(0, 1, 0)
	default_screen_material = self.get_node("Screen").get_active_material(1)

func update_till():
	var total_price = 0
	var book_names = ""
	var book_prices = ""
	for book in self.current_books.keys():
		book_names += current_books[book]["name"] + "\n"
		book_prices += str(current_books[book]["price"]) + "\n"
		total_price += current_books[book]["price"]
	
	self.get_node("book_prices").text = book_prices
	self.get_node("book_names").text = book_names
	self.get_node("book_total_price").text = "Total : " + str(total_price)

func _process(_delta):
	if currently_scanning == false:
		update_till()
