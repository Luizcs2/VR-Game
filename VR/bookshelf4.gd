extends RigidBody3D

@export var book_model: String = "res://hardcover_book.tscn"


var book_names = [
	"The Whispering Clockwork",
	"Beneath the Velvet Sea",
	"The Last Garden of Andromeda",
	"Inkheart's Heir",
	"The Silence Between Worlds",
	"Echoes of the Forgotten",
	"The Moonlit Alchemist",
	"Tales from the Hollow Lantern",
	"The Secret Map of Aetheria",
	"Shadows of the Silver Tempest",
	"Slack Me Never: A Study in Selective Participation",
	"The Ember and the Ashen Sky"
]
var book_summaries = [
	"A young inventor uncovers a hidden world inside her mechanical creations, where time itself is at risk of unraveling.",
	"A sailor stranded on an island discovers an ancient, underwater city that holds the key to unlocking his past.",
	"In a dying galaxy, a botanist embarks on a journey to find the last surviving garden and save her people.",
	"A teenager inherits the power to bring stories to life with a single word, but soon discovers the consequences of tampering with reality.",
	"Two kingdoms, separated by an invisible boundary, struggle to communicate as their worlds teeter on the edge of collapse.",
	"A historian stumbles upon a lost civilization's records, only to realize that the history they wrote is still alive and hunting them.",
	"A young alchemist seeking the secret to eternal life uncovers dark truths about the cost of immortality under the moonlight.",
	"A traveling storyteller becomes trapped in a cursed town, where the stories he tells begin to manifest and blur the line between fiction and reality.",
	"A band of explorers follows an ancient map that leads to a forgotten world, filled with strange creatures and unimaginable treasures.",
	"A group of adventurers must race against time to stop an ancient storm from engulfing the world, while confronting their darkest fears.",
	"An exploration of ghosting, vague replies, and unread messages in the workplace.",
	"In a post-apocalyptic world, a survivor searches for hope in the ashes of a dying world, guided by the mysterious ember of an ancient flame."
]

var book_prices = [
	19.99,  # The Whispering Clockwork
	14.49,  # Beneath the Velvet Sea
	22.99,  # The Last Garden of Andromeda
	17.50,  # Inkheart's Heir
	18.75,  # The Silence Between Worlds
	25.00,  # Echoes of the Forgotten
	21.00,  # The Moonlit Alchemist
	16.99,  # Tales from the Hollow Lantern
	24.99,  # The Secret Map of Aetheria
	23.45,  # Shadows of the Silver Tempest
	20.99,  # The Tides of Nevermore
	27.30   # The Ember and the Ashen Sky
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
	
	
