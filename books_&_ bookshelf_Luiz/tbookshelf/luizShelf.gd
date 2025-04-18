extends RigidBody3D

@export var book_model: String

var book_names = [
	"Clockwork's Secret Realm",
	"Secrets of the Velvet Deep",
	"Andromeda's Final Bloom",
	"The Wordsmith's Legacy",
	"Whispers Across the Divide",
	"Legacy of the Lost Archive",
	"Moonlight and Mortality",
	"The Lantern’s Last Story",
	"Mapmakers of the Mythic Realm",
	"Tempestbound: Rise of the Shadows",
	"Slack to the Future",
	"Flamebound: A Survivor’s Tale"
]

var book_summaries = [
	"A brilliant young tinkerer discovers a hidden dimension within her inventions—one where time unravels and she holds the key.",
	"After a shipwreck, a lone sailor stumbles upon an ancient submerged empire with ties to his forgotten lineage.",
	"In a distant galaxy, a lone botanist journeys across dying stars to find a mythical garden said to revive civilizations.",
	"A teen gifted with the power to breathe life into stories finds that fiction and reality blur in dangerous ways.",
	"Two silent realms divided by a magical veil must learn to understand each other—or risk fading into silence forever.",
	"A forgotten historian finds chronicles from a buried society, only to realize their ghosts are still watching—and rewriting.",
	"An apprentice alchemist chases the secret of eternal life, unaware that moonlit rituals come with soul-shattering prices.",
	"Trapped in a spectral village, a storyteller watches his tales come to life—twisting fate and memory into nightmares.",
	"Guided by a relic map, a team of explorers uncovers a world untouched by time, brimming with magic and peril.",
	"A cursed storm rises again after a thousand years, and only a fractured band of heroes can weather the coming darkness.",
	"A satirical guide to surviving modern workplace communication—ghosting, vague tasks, and disappearing Slack messages.",
	"In a world reduced to ash, a lone wanderer follows an ancient ember said to ignite hope—or destroy what's left."
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
	
	
