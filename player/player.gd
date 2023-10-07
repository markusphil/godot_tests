extends CharacterBody2D

@export var player_color: Color
@export_range(-1, 3) var controller_index: int 
@onready var polygon: Polygon2D = $Polygon2D

const BASE_SPEED = 250
const ROTATION_SPEED = 15
const ROTATION_DEADZONE = 0.1
# used to handle roatation interpolation



func init(device_id: int, color: Color):
	player_color = color
	controller_index = device_id
	

# Called when the node enters the scene tree for the first time.
func _ready():
	polygon.color = player_color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_rotation(delta)
	velocity = MultiplayerInput.get_vector(controller_index, "left", "right", "up", "down") * BASE_SPEED
	move_and_slide()
	
func handle_rotation(delta: float) -> void:
	var target_angle = rotation
	if controller_index == -1:
		target_angle = rotation + get_angle_to(get_global_mouse_position())

	else:
		var right_stick_input = MultiplayerInput.get_vector(controller_index, "look_left", "look_right", "look_up", "look_down")
		if (right_stick_input.length()) > ROTATION_DEADZONE:
			target_angle = right_stick_input.angle()
	
	# finds the right roation path respecting angle wrap and limit the roation speed
	rotation = lerp_angle(rotation, target_angle, ROTATION_SPEED * delta)
