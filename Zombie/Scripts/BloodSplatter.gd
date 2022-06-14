extends Node2D

onready var anim = $AnimationPlayer


func _enemy_is_dead():
	anim.play("bloodSplatter")



func _on_Timer_timeout() -> void:
	queue_free()
