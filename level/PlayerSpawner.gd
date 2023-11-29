extends Node2D

# TODO: this should be handled differently:
#       Players should join in the main menu, so this is where input devices are associates with
#		players, and where players should select a character.
#
#		The responsibility of this class should be to instantiate the player-charakters in the
# 		level and track their Porgress / Status

class_name PlayerSpawner

@export var camera: MultiTrackingCamera
@export var ui_controller: UIController

# Decide: do we want to allow joining when the level started?
# TODO: in any case, we need to handle changes in the device connection.

const PLAYER_COLORS = [
	Color(0.98, 0, 0.33),
	Color(0, 0.98, 0.1),
	Color(0, 0.5, 0.5),
	Color(0.65, 0.5, 0)
]

const MAX_PLAYERS = 4

var players: Array = []

signal all_players_died

func _ready():
	# In the future, we need to be able to ignore the keyboard
	# Idea: listen to all devices in a menu and let players join with an action
	
	var devices = [-1] + Input.get_connected_joypads()
	print(devices)
	for device_id in devices:
		spawn_player(device_id)

func spawn_player(device_id: int) -> void:
	# Don't add more players if limit is reached
	if players.size() >= MAX_PLAYERS:
		return
		
	var id: int = players.size()
	# The players need to be able choose their characters
	var player_node: Player = load("res://player/player.tscn").instantiate()
	players.append(player_node)
	player_node.init(id, device_id, PLAYER_COLORS[id])
	# randomize spawn location
	player_node.position = Vector2(randf_range(-100, 100), randf_range(-100, 100))
	# TODO: this should be replaced with designated spawn positions
	add_child(player_node)
	player_node.player_died.connect(_on_player_died)
	camera.add_target(player_node)
	ui_controller.add_player_ui(player_node)

func _on_player_died(player: Player):
	print("Player %s died!" % player.id)
	# Remove player from camera
	camera.remove_target(player)
	# End level if no player is left
	if _are_all_players_dead():
		all_players_died.emit()

func _are_all_players_dead() -> bool:
	var accu = true
	for player in players:
		accu = player.is_dead && accu
	return accu
	

	
