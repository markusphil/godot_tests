extends Node

class_name GameManager

@export var level_scene: PackedScene # Later this should be selected in a menu
@export var menu_scene: PackedScene  # The main menu

var _menu: MainMenu
var _level: LevelManager


enum GameState {
	INITIAL,
	RUNNING,
	ENDED
}

var state: GameState = GameState.INITIAL

func _ready():
	# instantiate main menu
	_menu = menu_scene.instantiate() as MainMenu
	add_child(_menu)
	_menu.start_game.connect(_on_start_game)

func _on_start_game():
	state = GameState.RUNNING
	_level = level_scene.instantiate() as LevelManager
	_menu.hide()
	add_child(_level)
	_level.level_end.connect(_on_level_end)
	
func _on_level_end():
	# Remove the level instance
	# TODO: what is the idomatic way to remove a child scene in godot?
	remove_child(_level)
	_level.queue_free()
	_level = null
	# Update the state
	state = GameState.ENDED
	# Show the main menu
	_menu.show()
	
	
	
