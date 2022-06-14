extends Node2D

signal enemy_hurt
signal enemy_died
signal player_dead
signal reload_prompt

export (PackedScene) var zombie
onready var player = $Player
onready var path_offset = $Player/Camera2D/Path2D/PathFollow2D
onready var spawn_point = $Player/Camera2D/Path2D/PathFollow2D/Position2D
onready var scoreboard = $HUD/ScoreBG/ScoreOut
onready var bullet_count = $Player/Weapon.bullet_counter
onready var ammo_count_display = $HUD/GunStatBG/AmmoCount
onready var hud = $HUD
onready var health_bar = $HUD/ProgressBar

#game stats
var _score:int = 0


func _ready() -> void:
	#_spawn_enemy()
	connect("player_dead",player,"_dead")
	connect("reload_prompt",hud,"prompt_to_reload")
	scoreboard.add_text("nil")
	print("main scene name" + get_tree().to_string())
	print("pause menu")
	
func _process(delta: float) -> void:
	pass
	

#game world functions
func update_score(score:int):
	Global.score += score
	_show_score()

func _show_score():
	scoreboard.clear()
	scoreboard.add_text(str(Global.score))

func _game_over():
	get_tree().free()



#spawns an enemy
func _spawn_enemy():
	var enemy
	enemy= zombie.instance()
	add_child(enemy)
	self.connect("enemy_hurt",enemy,"_enemy_got_hurt")
	self.connect("enemy_died",enemy,"_enemy_is_dead")
	enemy.position = set_enemy_spawn()
	
#player damage
func _hurt_player():
	player.health -= 15
	health_bar.value = player.health
	if player.health < 0:
		emit_signal("player_dead")

#generate random enemy spawn
func set_enemy_spawn():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	path_offset.offset = rng.randi_range(0,3664)
	return spawn_point.global_position


func _on_EnemeyWave_timeout() -> void:
	_spawn_enemy()
	

func update_bullet_count(bullet_count):
	ammo_count_display.clear()
	ammo_count_display.add_text(str(bullet_count))
	
