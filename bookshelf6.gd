extends RigidBody3D

@export var book_model: String = "res://hardcover_book.tscn"


var book_names = [
	"The King's Hollow",
	"Whispers of the Dragon's Heart",
	"Silver Wings in the Storm",
	"Warrior of the Frozen Wastes",
	"The Heart of the Shattered Earth",
	"Thorns of the Eternal Rose",
	"The Blackened Crown",
	"Secrets of the Ancient Flame",
	"The Last Light in the Darkness",
	"Into the Forbidden Realm",
	"Echoes of the Lost Prophet",
	"Songs of the Moonlit Tide"
]

var book_summaries = [
	"In the shadow of the King's Hollow, an ancient power stirs, and a hero must rise to prevent its awakening.",
	"A dragon's heart contains the secret to a dying world, and only a chosen few can unlock its power.",
	"In the eye of a storm, a lone warrior with silver wings stands tall, defending her people against all odds.",
	"Trapped in a frozen wasteland, a hero must navigate dangerous lands to find the one thing that can save their world.",
	"A shattered earth holds the key to rebirth, but its power is too great for one person to control.",
	"A cursed rose blooms in the heart of a forgotten city, and its thorns cut deeper than anyone knows.",
	"An ancient king's crown, long lost, is now the key to an empire's survival, but it’s been claimed by an enemy.",
	"Fire and ash burn at the edges of a world, and the flame of knowledge may hold the answers to its salvation.",
	"The darkness spreads, and the last light that could hold it back is hidden away by those who dare to defy fate.",
	"Beyond the borders of the known world lies a realm forbidden to enter, but a foolhardy adventurer dares.",
	"A prophecy, long ignored, begins to echo in the hearts of those who still believe in the forgotten gods.",
	"The ocean’s tide carries songs from an ancient time, and their meaning could save or doom the world."
]

var book_prices = [
	21.99,  # The King's Hollow
	24.50,  # Whispers of the Dragon's Heart
	20.25,  # Silver Wings in the Storm
	22.75,  # Warrior of the Frozen Wastes
	23.50,  # The Heart of the Shattered Earth
	25.25,  # Thorns of the Eternal Rose
	27.00,  # The Blackened Crown
	28.50,  # Secrets of the Ancient Flame
	20.99,  # The Last Light in the Darkness
	24.25,  # Into the Forbidden Realm
	22.00,  # Echoes of the Lost Prophet
	26.50   # Songs of the Moonlit Tide
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
	
	
