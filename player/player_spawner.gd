extends Node2D

# TODO: handle joining during runtime

const PLAYER_COLORS = [
	Color(0.98, 0, 0.33),
	Color(0, 0.98, 0.1),
	Color(0, 0.5, 0.5),
	Color(0.65, 0.5, 0)
]
# TODO: apply limit!
const MAX_PLAYERS = 4

var players = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var devices = [-1] + Input.get_connected_joypads()
	print(devices)
	for device_id in devices:
		spawn_player(device_id)

func spawn_player(device_id: int) -> void:
	var id: int = players.size()
	var player_node: CharacterBody2D = load("res://player/player.tscn").instantiate()
	players[id] = {
		"device_id": device_id,
		"color":  PLAYER_COLORS[id],
		"node": player_node
	}
	player_node.init(device_id, players[id]["color"])
	# randomize spawn location
	player_node.position = Vector2(randf_range(-100, 100), randf_range(-100, 100))
	
	add_child(player_node)
	print("added player: " + str(id))
	print_tree()
		
