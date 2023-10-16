extends Area2D

@export var health: HealthComponent

func _ready():
	monitorable = false
	monitoring = true
	area_entered.connect(_on_area_entered)
	
	
func _on_area_entered(area):
	if area is Projectile:
		health.apply_damage(area.damage)
	



