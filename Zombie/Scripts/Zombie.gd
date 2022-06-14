extends KinematicBody2D

signal damage_player
var health : float = 100

onready var player = get_parent().get_node("Player")
onready var raycast = $RayCast2D

export var speed = 100

func _ready() -> void:
	add_to_group("enemy")
	connect("damage_player",get_parent(),"_hurt_player")


func _process(delta: float) -> void:
	#checks if enemy alive
	if _check_health() < 0:
		get_parent().update_score(10)
		get_parent().emit_signal("enemy_died")
		
		
		
	

func _physics_process(delta: float) -> void:
			_look_at_player()
			var velocity = Vector2.ZERO	
			var dir = _follow_player(player)
			velocity += dir
		
			move_and_slide(velocity*speed)
		

#current health amout of enemy
func _check_health():
	return health


#decrease enemy health on hit
func _enemy_got_hurt():
	health -= 30
	

#enemy is removed from game once died
func _enemy_is_dead() -> void:
	queue_free()

#function to look at player
func _look_at_player():	
	look_at(player.global_position)


#function to follow player (tiggered once player hits the ray cast)
func _follow_player(player):
	var velocity = global_position.direction_to(player.global_position)
	return velocity


func _on_DamageArea_body_entered(body: Node) -> void:
	if player == body:
		emit_signal("damage_player")

