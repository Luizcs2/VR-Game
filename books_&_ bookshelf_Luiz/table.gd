extends Node3D  # or RigidBody3D if using physics

@export var book_models: Array[String] = [
	"res://books_&_ bookshelf_Luiz/books/luiz_book_1.tscn",
	"res://books_&_ bookshelf_Luiz/books/luiz_book_2.tscn",
	"res://books_&_ bookshelf_Luiz/books/luiz_book_3.tscn",
	"res://books_&_ bookshelf_Luiz/books/luiz_book_4.tscn"
]

func _ready():
	var spawnpoints = []

	for child in get_children():
		if child.name.begins_with("Spawnpoint"):
			print("Found spawnpoint:", child.name)
			spawnpoints.append(child)

	for i in range(min(spawnpoints.size(), book_models.size())):
		var book_scene = load(book_models[i])
		if book_scene:
			var book_instance = book_scene.instantiate()
			print("Instantiating:", book_models[i])
			book_instance.position = spawnpoints[i].global_position
			call_deferred("add_child", book_instance)
		else:
			print("Failed to load book at:", book_models[i])
