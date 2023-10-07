extends CharacterBody2D

@export var player_color: Color
@export var controller_index: int 
@onready var polygon: Polygon2D = $Polygon2D

const BASE_SPEED = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	polygon.color = player_color
	MultiplayerInput.reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = MultiplayerInput.get_vector(controller_index, "left", "right", "up", "down") * BASE_SPEED
	move_and_slide()
