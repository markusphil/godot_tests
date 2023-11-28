extends Node2D

# This class manages all the 
class_name LevelManager

@export var player_spawner: PlayerSpawner

# TODO differentiate between failure and success
signal level_end

func _ready():
	player_spawner.all_players_died.connect(_on_all_players_died)
	
func _on_all_players_died():
	level_end.emit()
