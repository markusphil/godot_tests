extends Area2D

class_name HitBoxComponent

@export var health: HealthComponent

func _ready():
	area_entered.connect(_on_area_entered)
	
	
func _on_area_entered(area):
	if area is Projectile:
		health.apply_damage(area.damage)

	



