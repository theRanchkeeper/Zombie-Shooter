extends Node2D
#world script

signal enemy_hurt
signal enemy_died
onready var zombie = $Zombie
onready var player = $Player
onready var gun = load("res://Weapon/Weapon.tscn")


func _on_TestLevel_enemy_died() -> void:
	print("queue free")
	zombie.queue_free()
