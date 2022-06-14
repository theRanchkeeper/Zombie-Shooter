extends Control


onready var resume_btn = $VBoxContainer/Resume
onready var quit_btn = $VBoxContainer/Quit

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause_mode()
		

func _toggle_pause_mode():
	var current_state = self.visible
	self.visible = not current_state
	get_parent().get_tree().paused = self.visible


func _on_Resume_button_down() -> void:
	_toggle_pause_mode()


func _on_Quit_button_down() -> void:
	get_parent().get_tree().quit()
