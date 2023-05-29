extends Area2D

@export_enum("Cooldown","HitOnce","DisableHitBox") var HurtBoxType = 0 

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage, angle, knockback)


func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") ==null:
			match HurtBoxType:
				0: #cooldown 
					collision.call_deferred("set","disabled",true) 
					disableTimer.start()
				1: #hitonce
					pass 
				2: #disablehitbox
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage =area.damage
			var angle = Vector2.ZERO
			var knockback = 1
			if not area.get("angle") == null:
				angle = area.angle
			if not area.get("knockback_amount") == null:	
				knockback= area.knockback_amount
				
			emit_signal("hurt",damage, angle, knockback)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)


func _on_disable_timer_timeout():
	collision.call_deferred("set","disabled",false)
