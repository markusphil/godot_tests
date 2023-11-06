extends Area2D

class_name HurtBox
@export var damage: int
@export_range(0.1,2) var hurt_interval = 0.5

var timer: Timer
var player: Player

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_hurt_player)
	
func _on_area_entered(area):
	if area is HitBoxComponent:
		var parent = area.get_parent()
		if parent is Player:
			player = parent
			_hurt_player()
			timer.start(hurt_interval)
			
func _on_area_exited(_area):
	timer.stop()
	player = null
	
func _hurt_player():
	player.health_component.apply_damage(damage)
