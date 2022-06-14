extends Control

onready var scoreDisplay = $ScoreBoard/YourScore


func _ready() -> void:
	print("Game over screen")
	scoreDisplay.add_text(str(Global.score))

func _on_Retry_pressed() -> void:
	get_tree().change_scene("res://Scene/BasicScene.tscn")


func _on_Quit_pressed() -> void:
	get_tree().quit()
