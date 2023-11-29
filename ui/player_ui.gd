extends Node2D

class_name PlayerUI

@export var player: Player

@onready var health_bar: ProgressBar = $HealthBar
@onready var health_label: Label = $HealthLabel
@onready var player_label: Label = $PlayerLabel

func _ready():
	print("ready")
	player_label.text = "Player: %s" % (player.id + 1)
	health_bar.min_value = 0
	health_bar.max_value = player.health_component.max_health
	_set_current_hp(player.health_component.current_health)
	player.health_component.took_damage.connect(_on_took_dmg)
	# When we stop the player (and all it's children) from processing on the "health_depleded"
	# signal, the "took_demage" signal is not propagated to the UI. Thus we have to listen to 
	# the "health_depleded" signal additionally.
	player.health_component.health_depleted.connect(_on_health_depleted)
	
func _on_took_dmg(_amount):
	_set_current_hp(player.health_component.current_health)
	
func _on_health_depleted():
	_set_current_hp(0)
	
func _set_current_hp(current_hp: int):
	health_bar.value = current_hp
	health_label.text = str(current_hp) + " / " + str(player.health_component.max_health)
	
	
