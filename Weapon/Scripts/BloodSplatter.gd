extends Node2D

onready var anim = $AnimationPlayer
signal hit_enemy

func _play_anim():
	print("blood splatters")
	anim.play("BloodSplatter")


func _on_BloodSplatter_hit_enemy() -> void:
	_play_anim()


func _on_Timer_timeout() -> void:
	queue_free()
