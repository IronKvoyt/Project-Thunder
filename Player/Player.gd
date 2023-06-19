extends CharacterBody2D

var movement_speed = 50
var hp = 100
var maxhp= 100
var time = 0

var experience = 0
var experience_level = 1
var collected_experience = 0

#Attack
var Sword = preload("res://Player/Sword.tscn")

#AttackNodes
@onready var SwordTimer = get_node("%SwordTimer")
@onready var SwordAttackTimer = get_node("%SwordAttackTimer")

#Sword
var sword_ammo = 0
var sword_baseammo = 1
var sword_attackspeed = 1.4
var sword_level = 1


#Upgrades
var collected_upgrades = []
var upgrade_options = []
var armor  = 0
var speed = 0
var spell_cooldown = 0
var spell_size = 0 
var additional_attacks = 0

#Enemy Related
var enemy_close = []


@onready var sprite = $Sprite2D

#GUI
@onready var expBar= get_node("%ExpBar")
@onready var levelPanel = get_node("%LevelUp")
@onready var labellevel= get_node("%Label_Level")
@onready var upgradeOptions = get_node("%UpgradeOptions")
@onready var soundLevepUp = get_node("%Sound_LevelUp")
@onready var itemOptions = preload("res://Utility/item_option.tscn")
@onready var healthBar = get_node("%HealthBar")
@onready var labelTime = get_node("%Label_Timer")
@onready var collectedWeapons = get_node("%CollectedWeapons")
@onready var collectedUpgrades = get_node("%CollectedUpgrades")
@onready var itemContainer = preload("res://Player/GUI/item_container.tscn")

@onready var deathPanel  = get_node("%DeathPanel")
@onready var labelResult = get_node("%Label_Result")
@onready var soundVictory = get_node("%Sound_Victory")
@onready var soundLose = get_node("%Sound_Lose")

func _ready():
	attack()
	set_expbar(experience,calculate_experiencecap())
	_on_hurt_box_hurt(0,0,0)
	
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
	velocity = mov.normalized()*movement_speed
	move_and_slide()
 
func attack():
	if sword_level>0:
		SwordTimer.wait_time = sword_attackspeed * (1 - spell_cooldown)
		if SwordTimer.is_stopped():
			SwordTimer.start()

func _on_hurt_box_hurt(damage, _angle, _knockback):
	hp -= clamp(damage- armor, 1.0, 999.0)
	healthBar.max_value = maxhp
	healthBar.value = hp
	if hp <=0:
		death()

func _on_sword_timer_timeout():
	sword_ammo +=sword_baseammo + additional_attacks
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
		experience = 0
		exp_required = calculate_experiencecap()
		levelup()
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
		exp_cap+=95 *(experience_level-19)*8
	else:
		exp_cap = 255+ (experience_level-39)*12
	return exp_cap

func set_expbar(set_value=1, set_max_value=100):
	expBar.value = set_value
	expBar.max_value= set_max_value

func levelup():
	soundLevepUp.play()
	labellevel.text = str("Level: ", experience_level)
	var tween = levelPanel.create_tween()
	tween.tween_property(levelPanel, "position", Vector2(220,50),0.3).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	levelPanel.visible = true
	var options = 0
	var optionsmax = 3
	while options < optionsmax:
		var option_choice = itemOptions.instantiate()
		option_choice.item = get_random_item()
		upgradeOptions.add_child(option_choice)
		options+=1
	get_tree().paused = true 
	
func upgrade_character(upgrade):
	match upgrade:
		"sword1":
			sword_level = 1
			sword_baseammo += 1
		"sword2":
			sword_level = 2
			sword_baseammo += 1
		"sword3":
			sword_level = 3
		"sword4":
			sword_level = 4
			sword_baseammo += 2
		"armor1","armor2","armor3","armor4":
			armor += 1
		"speed1","speed2","speed3","speed4":
			movement_speed += 20.0
		"pipe1","pipe2","pipe3","pipe4":
			spell_size += 0.10
		"scroll1","scroll2","scroll3","scroll4":
			spell_cooldown += 0.05
		"bean1","bean2":
			additional_attacks += 1
		"pot":
			hp += 20
			hp = clamp(hp,0,maxhp)
	adjust_gui_collection(upgrade)
	
	
	
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	levelPanel.visible = false 
	levelPanel.position  = Vector2(800,50)
	get_tree().paused = false
	calculate_experience(0)

func get_random_item():
	var dblist = []
	for i in Upgrades.UPGRADES:
		if i in collected_upgrades:
			pass
		elif i in upgrade_options:
			pass
		elif Upgrades.UPGRADES[i]["type"] == "item":
			pass
		elif Upgrades.UPGRADES[i]["prerequisite"].size()>0:
			for n in Upgrades.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades:
					pass
				else:
					dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() >0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return  randomitem
	else: 
		return null

func change_time(argtime = 0):
	time = argtime 
	var get_m = int(time/60.0)
	var get_s = time %60
	if get_m < 10:
		get_m = str(0,get_m)
	if get_s <10:
		get_s = str(0,get_s) 
	labelTime.text = str(get_m,":",get_s)

func adjust_gui_collection(upgrade):
	var get_upgraded_displayname = Upgrades.UPGRADES[upgrade]["displayname"]
	var get_type = Upgrades.UPGRADES[upgrade]["type"]
	if get_type != "item":
		var get_collected_displayname = []
		for i in collected_upgrades:
			get_collected_displayname.append(Upgrades.UPGRADES[i]["displayname"])
		if not get_upgraded_displayname in get_collected_displayname:
			var new_item = itemContainer.instantiate()
			new_item.upgrade= upgrade
			match get_type:
				"weapon":
					collectedWeapons.add_child(new_item)
				"upgrade":
					collectedUpgrades.add_child(new_item	)

func death():
	deathPanel.visible = true 
	get_tree().paused = true
	var tween = deathPanel.create_tween()
	tween.tween_property(deathPanel,"position", Vector2(220,50),3.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play
	if time >=300:
		labelResult.text="You Win"
		soundVictory.play()
	else:
		labelResult.text = "You Lose"
		soundLose.play()


func _on_button_menu_click_end():
	get_tree().paused = false 
	var _level = get_tree().change_scene_to_file("res://TitleScreen/menu.tscn")
