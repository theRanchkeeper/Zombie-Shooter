extends Control

var state:bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = self.visible

func _on_Timer_timeout() -> void:
	self.visible = state
