extends CanvasLayer

onready var prompt_state = $ReloadPrompt.visible
onready var ammo_stat = $GunStatBG/AmmoCount

func prompt_to_reload():
	$ReloadPrompt.visible = not prompt_state

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Reload"):
		$ReloadPrompt.visible = prompt_state
