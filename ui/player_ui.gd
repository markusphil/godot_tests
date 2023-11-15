extends Node2D

class_name PlayerUI

@export var player: Player

@onready var health_bar: ProgressBar = $HealthBar
@onready var health_label: Label = $HealthLabel
@onready var player_label: Label = $PlayerLabel

func _ready():
	print("ready")
	player_label.text = "Player: %s" % (player.player_id + 1)
	health_bar.max_value = player.health_component.max_health
	_set_current_hp(player.health_component.current_health)
	player.health_component.took_damage.connect(_on_took_dmg)
	
func _on_took_dmg(_amount):
	_set_current_hp(player.health_component.current_health)
	
func _set_current_hp(current_hp: int):
	health_bar.value = current_hp
	health_label.text = str(current_hp) + " / " + str(player.health_component.max_health)
	
	
