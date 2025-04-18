extends RigidBody3D

@export var book_model: String = "res://hardcover_book.tscn"


var book_names = [
	"Stars Beyond the Horizon",
	"The Lost City of Lothar",
	"Nightfall and the Rising Tide",
	"Breath of the Ancient Forest",
	"The Shattered Shield of Valeria",
	"Sands of Time, Shadows of the Past",
	"Voices in the Wind of the Void",
	"Kingdoms of the Storm and the Sea",
	"The Journey to the Unknown Abyss",
	"Embers of the Fallen Empire",
	"Crimson Dreams and Golden Fates",
	"The Magician's Last Trick"
]

var book_summaries = [
	"An interstellar traveler must break through the barriers of time to save a dying star system from collapse.",
	"An archaeologist uncovers a hidden city in the desert, but disturbing secrets from the past threaten to rise.",
	"A sailor faces the mysterious and deadly forces of the ocean as they try to unravel an ancient prophecy.",
	"Fighting to protect the forest’s sacred land, an ancient spirit seeks a lost artifact that can stop an impending war.",
	"A warrior’s last stand leaves a shattered shield, but their legacy is passed on through those who would follow.",
	"A time-traveling thief unwittingly uncovers the origins of an ancient empire and must stop the past from repeating.",
	"Trapped in an infinite loop, a group of explorers must face voices that lead them into a terrifying void beyond comprehension.",
	"Battling a relentless storm, two ancient kingdoms join forces, but only one can survive the fury of the elements.",
	"An explorer discovers an endless abyss beneath the ocean, and its dark secrets could destroy the world above.",
	"The fall of an empire leaves ashes and remnants, but its heroes may still rise from the dust.",
	"Nightmares haunt a dreamer, but the mysteries of fate may offer answers hidden in blood and fire.",
	"One final illusion casts a shadow over a magician's fate, and the last trick holds the key to a world’s salvation."
]

var book_prices = [
	16.25,  # Stars Beyond the Horizon
	19.75,  # The Lost City of Lothar
	21.50,  # Nightfall and the Rising Tide
	18.00,  # Breath of the Ancient Forest
	24.75,  # The Shattered Shield of Valeria
	22.25,  # Sands of Time, Shadows of the Past
	20.75,  # Voices in the Wind of the Void
	23.50,  # Kingdoms of the Storm and the Sea
	20.00,  # The Journey to the Unknown Abyss
	26.00,  # Embers of the Fallen Empire
	27.75,  # Crimson Dreams and Golden Fates
	29.50   # The Magician's Last Trick
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
	
	
