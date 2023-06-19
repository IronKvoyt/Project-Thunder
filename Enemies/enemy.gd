extends CharacterBody2D


@export var  movespeed = 20
@export var hp = 10 
@export var knockback_recovery = 2
@export var experience = 1 
@export var enemy_damage = 1 
var knockback = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sound_hit = $sound_hit
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var hitBox = $Hit_Box

var exp_orb = preload("res://Objects/experience_orb.tscn") 


func _ready():
	hitBox.damage = enemy_damage

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movespeed
	velocity += knockback
	move_and_slide()

func death():
	var new_orb  = exp_orb.instantiate()
	new_orb.position = position
	new_orb.experience = experience
	loot_base.call_deferred("add_child", new_orb)
	queue_free()
	

func _on_hurt_box_hurt(damage,angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
	else:
		sound_hit.play()
