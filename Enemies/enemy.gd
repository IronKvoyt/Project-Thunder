extends CharacterBody2D


@export var  movespeed = 20
@export var hp = 10 
@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movespeed
	move_and_slide()


func _on_hurt_box_hurt(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
