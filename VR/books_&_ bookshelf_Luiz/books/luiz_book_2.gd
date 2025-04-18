@tool
class_name Luizbook2
extends XRToolsPickable

var book_name = "default name"
var book_summary = "default summary"
var book_price = 0

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
	21.99, 24.50, 20.25, 22.75, 23.50, 25.25,
	27.00, 28.50, 20.99, 24.25, 22.00, 26.50
]

func _ready():
	randomize()
	var i = randi() % book_names.size()
	set_title(book_names[i])
	set_summary(book_summaries[i])
	set_price(book_prices[i])

	change_label_visibility(false)
	self.picked_up.connect(_on_object_picked_up)
	self.grabbed.connect(_on_object_grabbed)
	self.dropped.connect(_on_object_dropped)

func change_label_visibility(vis: bool):
	get_node("label_title_text").visible = vis
	get_node("label_summary_text").visible = vis
	get_node("label_price_text").visible = vis
	get_node("label_title").visible = vis
	get_node("label_summary").visible = vis
	get_node("label_price").visible = vis
	get_node("label_background_mesh").visible = vis

func _on_object_picked_up(_pickable: XRToolsPickable):
	change_label_visibility(true)
	print(self.name, " picked up")

func _on_object_grabbed(_pickable: XRToolsPickable, by: Node3D):
	change_label_visibility(true)
	print(self.name, " grabbed by node:", by.name)

func _on_object_dropped(_pickable: XRToolsPickable):
	change_label_visibility(false)
	print(self.name, " dropped")

func set_title(title: String):
	book_name = title
	get_node("label_cover").text = title
	get_node("label_title_text").text = title

func set_price(price: float):
	book_price = price
	get_node("label_price_text").text = str(price)

func set_summary(summary: String):
	book_summary = summary
	get_node("label_summary_text").text = summary

func is_object_in_front_of_camera(main_obj: Node3D, viewed_obj_position: Vector3, threshold_angle: float = 45.0) -> bool:
	var view_direction = main_obj.global_transform.basis.y
	var direction_to_object = (viewed_obj_position - main_obj.global_transform.origin).normalized()
	var angle = rad_to_deg(acos(view_direction.dot(direction_to_object)))
	return angle <= threshold_angle

func _process(_delta):
	if self.is_picked_up():
		var cam_pos = get_node("../../XROrigin3D/XRCamera3D").global_position
		change_label_visibility(is_object_in_front_of_camera(self, cam_pos))
