@icon("res://components/health/Health.svg")
extends Node

class_name HealthComponent

@export var max_health: int

signal took_damage
signal health_depleted

var current_health: int

func _ready():
	current_health = max_health
	

func get_health():
	return current_health
	
func apply_damage(amount: int):
	health_depleted.emit()
	current_health =- amount
	if current_health <= 0:
		health_depleted.emit()
