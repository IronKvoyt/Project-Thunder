extends CharacterBody2D

var movespeed = 50
var hp = 100
@onready var sprite = $Sprite2D

func _ready():
	pass
func _physics_process(delta):
	movement()

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov,y_mov)
	
	if mov.x > 0:
		sprite.flip_h = true
	elif mov.x < 0:
		sprite.flip_h = false	
	velocity = mov.normalized()*movespeed
	move_and_slide()
 


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
