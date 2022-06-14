extends Control

onready var progress_wheel = $TextureProgress
onready var timer = $Timer

func _ready() -> void:
	self.visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Reload"):
		self.visible = true
		timer.start()


func _on_Timer_timeout() -> void:
	self.visible = false
