extends Node2D

onready var hit_effect = load("res://Weapon/HitEffect.tscn")
onready var blood = load("res://Weapon/BloodSplatter.tscn")
onready var gun_point = $RayCast2D
onready var reload_delay = $Timer
onready var root = get_parent()
onready var gun_sfx = $GunShot
onready var no_ammo_sfx = $NoAmmo
onready var reload_sfx =$Reloading


signal reload_time
signal shot_fired
signal bullet_count_update(count)

const MAX_BULLET : int= 30
var bullet_counter = MAX_BULLET


func _ready() -> void:
	connect("reload_time",root,"_reload_time")
	connect("bullet_count_update",root,"_bullet_count_changed")
	emit_signal("bullet_count_update",MAX_BULLET)
		
#when gun is fired
func _input(event: InputEvent) -> void:
	#shooting
	if event.is_action_pressed("FIRE"):
		if bullet_counter > 0:
			bullet_counter -=1
			gun_sfx.play()
			emit_signal("bullet_count_update",bullet_counter)
			emit_signal("shot_fired")
		else:
			print("Time to reload")
			no_ammo_sfx.play()
			emit_signal("reload_time")
			gun_point.enabled = false
		
		#when shooting enemy
		if gun_point.is_colliding() and _collided_node_check(gun_point,"enemy"):
			print("Shooting zombie")
			var hit_point = gun_point.get_collision_point()
			var effect = blood.instance()
			add_child(effect)
			effect.global_position = hit_point
			effect.emit_signal("hit_enemy")
		#shooting obstacles
		if gun_point.is_colliding() and _collided_node_check(gun_point,"obstacles"):
			var hit_point = gun_point.get_collision_point()
			var effect = hit_effect.instance()
			add_child(effect)
			effect.global_position = hit_point
			effect.emit_signal("hit_obstacle")
	
	#reloading
	if event.is_action_pressed("Reload"):
		reload_sfx.play()
		$Timer.start()
		

func _collided_node_check(point : RayCast2D , group:String):
	var temp = point.get_collider()
	var res = temp.is_in_group(group)
	if res:
		return true
	else:
		return false
		

func _reload():
	bullet_counter = MAX_BULLET
	emit_signal("bullet_count_update",bullet_counter)
	gun_point.enabled = true
	print("Reloaded")



func _on_Timer_timeout() -> void:
	 _reload()
