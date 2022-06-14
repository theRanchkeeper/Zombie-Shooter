class_name Level extends Node2D

var _score:int = 0
var _bullet:int = 0

func update_score(score:int):
	_score = score

func _show_score ():
	return _score

func _game_over():
	get_tree().free()
	
func _pause_game():
	pass
