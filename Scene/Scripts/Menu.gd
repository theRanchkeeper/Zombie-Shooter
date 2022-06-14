extends Control


func _ready() -> void:
	pass



func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://Scene/BasicScene.tscn")


func _on_quitButton_pressed() -> void:
	get_tree().quit()
