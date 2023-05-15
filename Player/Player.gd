extends CharacterBody2D

var movespeed = 50
var hp = 100
var experience = 0
var experience_level = 1
var collected_experience = 0

#Attack
var Sword = preload("res://Player/Attack.tscn")

#AttackNodes
@onready var SwordTimer = get_node("%SwordTimer")
@onready var SwordAttackTimer = get_node("%SwordAttackTimer")

#Sword
var sword_ammo = 0
var sword_baseammo = 1
var sword_attackspeed = 1.4
var sword_level = 1


#Enemy Related
var enemy_close = []


@onready var sprite = $Sprite2D

#GUI
@onready var expBar= get_node("%ExpBar")
@onready var labellevel= get_node("%Label_Level")

func _ready():
	attack()
	set_expbar(experience,calculate_experiencecap())
	
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
 
func attack():
	if sword_level>0:
		SwordTimer.wait_time = sword_attackspeed
		if SwordTimer.is_stopped():
			SwordTimer.start()

func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)


func _on_sword_timer_timeout():
	sword_ammo +=sword_baseammo
	SwordAttackTimer.start()


func _on_sword_attack_timer_timeout():
	if sword_ammo>0:
		var sword_attack = Sword.instantiate()
		sword_attack.position = global_position
		sword_attack.target = get_random_target()
		sword_attack.level = sword_level
		add_child(sword_attack)
		sword_ammo-=1
		if sword_ammo>0:
			SwordAttackTimer.start()
		else:
			SwordAttackTimer.stop()
		
func get_random_target():
	if enemy_close.size() >0: 
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP


func _on_enemy_detectio_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detectio_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)


func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"): 
		area.target = self


func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"): 
		var orb_exp= area.collect()
		calculate_experience(orb_exp)
		
func calculate_experience(orb_exp):
	var exp_required = calculate_experiencecap()
	collected_experience+=orb_exp
	if experience + collected_experience >= exp_required:
		collected_experience -=exp_required-experience
		experience_level +=1
		labellevel.text = str("Level: ", experience_level)
		experience = 0
		exp_required = calculate_experiencecap()
		calculate_experience(0)
	else: 
		experience+= collected_experience
		collected_experience=0
	
	set_expbar(experience,exp_required)
	
func calculate_experiencecap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level*5
	elif experience_level < 40:
		exp_cap+95 *(experience_level-19)*8
	else:
		exp_cap = 255+ (experience_level-39)*12
	return exp_cap

func set_expbar(set_value=1, set_max_value=100):
	expBar.value = set_value
	expBar.max_value= set_max_value
