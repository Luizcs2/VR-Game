extends RigidBody3D

@export var book_model: String = "res://hardcover_book.tscn"

var book_names = [
	"The Enchanted Blade",
	"Whispers from the Abyss",
	"The Forgotten Legends of Loria",
	"Echoes of the Celestial Wind",
	"Shadows of the Blackened Moon",
	"The Lost Temple of Seraphis",
	"The Serpent's Golden Eye",
	"Clash of the Skyward Titans",
	"The Enigma of the Silent Valley",
	"King of the Silver Marshes",
	"Blood of the Fallen Phoenix",
	"Rise of the Starborn"
]

var book_summaries = [
	"An ancient sword forged by magic holds the power to shape the future, but only a chosen hero can wield it.",
	"An explorer ventures deep into the ocean’s heart, only to uncover a dark truth hidden beneath the waves.",
	"A kingdom's greatest secrets are locked away, and the only key to unlocking them is a young girl with an ancient lineage.",
	"Across the winds of the cosmos, a lone traveler must uncover the meaning of the echoes that shape the fate of worlds.",
	"Under the pale light of a dying moon, a rogue discovers the sinister forces at work in a land lost to time.",
	"A treasure hunter uncovers a long-forgotten temple, and within it lies the key to unlocking an ancient curse.",
	"An immortal serpent seeks vengeance and treasures hidden within the heart of the earth, but a hero stands in its way.",
	"Two mighty titans clash, their powers threatening to tear apart the very sky, but only one will be crowned the victor.",
	"A peaceful valley hides its own dark past, and a lone traveler must uncover its secrets before it's too late.",
	"A forgotten ruler’s bloodline is the key to reclaiming a lost kingdom, but the path is fraught with danger and betrayal.",
	"A dying phoenix rises from the ashes, and with it, a new era begins—but will it be a time of rebirth or destruction?",
	"The last of the Starborn must face the ultimate trial to save the universe from collapsing into darkness."
]

var book_prices = [
	18.00,  # The Enchanted Blade
	22.50,  # Whispers from the Abyss
	19.75,  # The Forgotten Legends of Loria
	21.25,  # Echoes of the Celestial Wind
	20.99,  # Shadows of the Blackened Moon
	23.50,  # The Lost Temple of Seraphis
	24.75,  # The Serpent's Golden Eye
	26.00,  # Clash of the Skyward Titans
	19.00,  # The Enigma of the Silent Valley
	21.99,  # King of the Silver Marshes
	25.25,  # Blood of the Fallen Phoenix
	27.50   # Rise of the Starborn
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
	
	
