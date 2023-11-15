extends CharacterBody2D

class_name Player

@export var player_color: Color
@export_range(-1, 3) var controller_index: int 
@export_range(0,3) var player_id: int

@onready var polygon: Polygon2D = $Polygon2D

@export var health_component: HealthComponent
@export var animationPlayer: AnimationPlayer
@export var hitbox_component: HitBoxComponent


const BASE_SPEED = 250
const ROTATION_SPEED = 15
const ROTATION_DEADZONE = 0.1

func init(player_id: int, device_id: int, color: Color):
	player_color = color
	controller_index = device_id
	player_id = player_id

func _ready():
	polygon.color = player_color
	hitbox_component.health = health_component
	health_component.took_damage.connect(_on_took_damage)
	health_component.health_depleted.connect(_on_health_depleted)

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
	
func _on_took_damage(amount):
	animationPlayer.play("hit")
	
func _on_health_depleted():
	print("You died!")
