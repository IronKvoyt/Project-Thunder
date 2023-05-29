extends ColorRect

@onready var label_name = $Label_Name
@onready var label_description = $Label_Description
@onready var label_level = $Label_Level
@onready var itemIcon = $ColorRect/ItemIcon

var mouse_over = false 
var item = null
@onready var player = get_tree().get_first_node_in_group("player")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(player,"upgrade_character"))
	if item == null:
		item = "pot"
	label_name.text = Upgrades.UPGRADES[item]["displayname"]
	label_description.text = Upgrades.UPGRADES[item]["details"]
	label_level.text = Upgrades.UPGRADES[item]["level"]
	itemIcon.texture = load(Upgrades.UPGRADES[item]["icon"])
		

func _input(event):
	if event.is_action("Click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)

func _on_mouse_entered():
	mouse_over = false


func _on_mouse_exited():
	mouse_over = true
