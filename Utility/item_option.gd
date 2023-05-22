extends ColorRect

var mouse_over = false 
var item = null
@onready var player = get_tree().get_first_node_in_group("player")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(player,"upgrade_character"))

func _input(event):
	if event.is_action("Click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)

func _on_mouse_entered():
	mouse_over = false


func _on_mouse_exited():
	mouse_over = true
