extends Area2D

@export var experince = 1

var spr_blue = preload("res://Textures/blue_orb.png")
var spr_red = preload("res://Textures/red_orb.png")

var target = null
var speed = 1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $sound_collected

func _ready():
	if experince<5:
		return 
	elif experince<25:
		sprite.texture = spr_blue
	else:
		sprite.texture = spr_red

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed+= 2*delta

func collect():
	sound.play()
	collision.call_deferred("set","disabled",true)
	sprite.visible= false
	return experince


func _on_sound_collected_finished():
	queue_free()
