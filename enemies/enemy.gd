extends CharacterBody2D

@export var health_component: HealthComponent
@export var animationPlayer: AnimationPlayer


func _ready():
	health_component.took_damage.connect(_on_took_damage)
	health_component.health_depleted.connect(_on_health_depleted)

func _on_took_damage(amount:int):
	# TODO: use the amount to display damage numbers
	animationPlayer.play("hit")

func _on_health_depleted():
	animationPlayer.play("death")
