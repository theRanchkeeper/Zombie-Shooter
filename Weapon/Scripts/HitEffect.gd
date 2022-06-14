extends Node2D

signal hit_obstacle
onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _play_anim():
	print("hit effect")
	anim.play("HitEffect")


func _on_Timer_timeout() -> void:
	queue_free()


func _on_HitEffect_hit_obstacle() -> void:
	_play_anim()
