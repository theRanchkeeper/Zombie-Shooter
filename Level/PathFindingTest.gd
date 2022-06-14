extends Node2D

onready var destiny = $Destination
onready var enemy = $Zombie
onready var line = $Line2D
onready var nav = $Navigation2D

func _physics_process(delta: float) -> void:
	var path = nav.get_simple_path(enemy.position,destiny.position,true)
	line.points = path

