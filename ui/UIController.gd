extends CanvasLayer

# Responsable for adding UI elements for every player
class_name UIController

const player_ui_scene: PackedScene = preload("res://ui/player_ui.tscn")

# This can also be represented with nodes
const PLAYER_UI_POSITIONS = [
	Vector2(10,10),
	Vector2(990,10),
	Vector2(10, 590),
	Vector2(990,590),
]

@onready var viewport = Viewport
# Contract: id must be < PLAYER_UI_POSITIONS.size
func add_player_ui(player: Player):
	var player_ui = player_ui_scene.instantiate()
	player_ui.player = player
	player_ui.position = PLAYER_UI_POSITIONS[player.player_id]
	add_child(player_ui)
