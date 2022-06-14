extends KinematicBody2D

onready var player_sprite = $Sprite
onready var ray = $Weapon/RayCast2D
onready var footstep_sfx = $FootStep
#player properties
var speed : float = 150
var velocity : Vector2 = Vector2()
var mouse_sweep : Vector2 = Vector2.ZERO

var health :float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	#player looks based on mouse movement
	mouse_sweep = lerp(mouse_sweep,get_global_mouse_position(),0.3)
	look_at(mouse_sweep)
	

func _physics_process(delta: float) -> void:
	#makes plaer move
	velocity = move_player()
	velocity = move_and_slide(velocity * speed)
	
	if velocity != Vector2(0,0):
		footstep_sfx.play()
		
		
	
	
#moves player on key input
func move_player():
	
	var dir = Vector2.ZERO
	
	if Input.is_action_pressed("UP"):
		dir.y -= 1
	if Input.is_action_pressed("DOWN"):
		dir.y += 1
	if Input.is_action_pressed("RIGHT"):
		dir.x += 1
	if Input.is_action_pressed("LEFT"):
		dir.x -= 1
	
	return dir.normalized()

func _collided_node_check(point : RayCast2D , group:String):
	var temp = point.get_collider()
	var res = temp.is_in_group(group)
	if res:
		return true
	else:
		return false
		

func _on_Weapon_shot_fired() -> void:
	if ray.is_colliding() and _collided_node_check(ray,"enemy"):
		#print("enemy on gun point")
		get_parent().emit_signal("enemy_hurt")
	

func _dead():
	#get_tree().quit()
	get_tree().change_scene("res://Scene/GameOver.tscn")
	
func _reload_time():
	get_parent().emit_signal("reload_prompt")

func _bullet_count_changed(count):
	get_parent().call_deferred("update_bullet_count",count)
