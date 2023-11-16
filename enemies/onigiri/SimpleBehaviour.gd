# TODO: add an icon
extends Node

class_name SimpleBehaviour

@export var speed: int = 50
@export var parent: Enemy
@export_range(1, 10) var target_selection_timeout = 5

var target: Player

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_select_target)
	timer.start()
	_select_target() # Select the inital target

func perform_movement():
	if target != null:
		parent.velocity = (target.global_position - parent.global_position).normalized() * speed
		parent.move_and_slide()

func _select_target():
	target = TargetUtils.find_nearest_player(parent)

	
