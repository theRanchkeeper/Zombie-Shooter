extends Node2D

onready var anim = $AnimationPlayer

func _on_Weapon_shot_fired() -> void:
	anim.play("muzzle_flash")
