extends RigidBody3D

@export var book_model: String = "res://hardcover_book.tscn"


var book_names = [
	"The Lost Kingdom of Rohan",
	"Secrets Beneath the Sand",
	"Eyes of the Dragon Queen",
	"The Dark Spellcaster's Curse",
	"Throne of the Fire King",
	"Legend of the Drowned City",
	"Fate of the Emerald Blade",
	"The Last Watcher of the Fallen Star",
	"The Silent War of Shadows",
	"Rise of the Iron Fangs",
	"The City of Eternal Night",
	"The Shattered Dreamer"
]

var book_summaries = [
	"An ancient kingdom is rediscovered, but its dark secrets could threaten the entire world.",
	"A vast desert hides treasures and dangers alike, and only the bravest dare to unearth its hidden mysteries.",
	"The dragon queen's eyes hold the key to the survival of her people, but will they fall into darkness?",
	"A young sorcerer must break the curse placed upon their family before it consumes them all.",
	"A kingdom burns under the rule of a cruel fire king, but a secret rebellion may ignite the flames of revolt.",
	"An ancient city, swallowed by the ocean, is believed to hold the greatest treasures of all, but it is not empty.",
	"An unassuming hero stumbles upon an emerald blade that could tip the balance of power in an ongoing war.",
	"The last of the watchers, cursed to guard a dying star, must choose between their duty and their heart's desire.",
	"In the shadows, a war is fought in silence, where the fate of all is decided in the darkness.",
	"An army of iron wolves rises from the ashes of the past, their claws set on the path of destruction.",
	"A city where the sun never rises is ruled by shadows, and an unlikely hero must bring light to the eternal night.",
	"A dreamer is shattered by their own visions, but their fractured mind holds the key to saving the world."
]

var book_prices = [
	22.00,  # The Lost Kingdom of Rohan
	19.50,  # Secrets Beneath the Sand
	21.00,  # Eyes of the Dragon Queen
	23.25,  # The Dark Spellcaster's Curse
	24.00,  # Throne of the Fire King
	25.75,  # Legend of the Drowned City
	20.50,  # Fate of the Emerald Blade
	26.25,  # The Last Watcher of the Fallen Star
	22.75,  # The Silent War of Shadows
	23.00,  # Rise of the Iron Fangs
	27.00,  # The City of Eternal Night
	28.50   # The Shattered Dreamer
]

func _ready():
	var child_nodes = get_children()
	var spawnpoint_nodes = []
	
	# Gets all the child nodes of the object and places the spawnpoint nodes in a list
	for child in child_nodes:
		if child.name.substr(0,10) == "Spawnpoint":
			spawnpoint_nodes.append(child)
	
	# Adds books to spawnpoints while counting each creation with the c variable
	var c = 0
	for spawnpoint in spawnpoint_nodes:
		# Creates the book object
		var book_entity = load(book_model).instantiate()
		
		# Rotates the book to the upright position
		book_entity.rotate(Vector3.FORWARD, deg_to_rad(90))
		book_entity.rotate(Vector3.LEFT, deg_to_rad(90))
		book_entity.rotate(Vector3.RIGHT, deg_to_rad(180))
		
		# Places the book on its corresponding spawnpoint
		book_entity.position = spawnpoint.position
		
		# Sets book variables to those in the bookshelf's list attributes
		book_entity.set_title(book_names[c])
		book_entity.set_summary(book_summaries[c])
		book_entity.set_price(book_prices[c])
		
		# Sets the book cover's material to a random colour
		var book_material = StandardMaterial3D.new()
		var random_color = Color(randf(), randf(), randf())
		book_material.albedo_color = random_color
		book_entity.get_node("Hardcover_book").set_surface_override_material(0, book_material)

		print("Created Book: ", book_entity.name)
		add_child(book_entity)
		c += 1



### Book spamming!!
#func _physics_process(delta):
	#var child_nodes = get_children()
	#var spawnpoint_nodes = []
	#
	## Gets all the child nodes of the object and places the spawnpoint nodes in a list
	#for child in child_nodes:
		#if child is Marker3D:
			#spawnpoint_nodes.append(child)
	#
	##if (int(delta*100) % 12) == 0:
	#var book_entity = create_book_entity()
	#book_entity.rotate(Vector3.FORWARD, deg_to_rad(90))
	#book_entity.rotate(Vector3.LEFT, deg_to_rad(90))
	#book_entity.position = spawnpoint_nodes[10].position
	#print("Created Book at: ", book_entity.visible)
	#add_child(book_entity)
	
	
