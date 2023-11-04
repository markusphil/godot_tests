extends CharacterBody2D

class_name Enemy

@export var health_component: HealthComponent
@export var animationPlayer: AnimationPlayer
# TODO: generalize Behabviour
@export var behaviour: SimpleBehaviour

func _ready():
	health_component.took_damage.connect(_on_took_damage)
	health_component.health_depleted.connect(_on_health_depleted)
	behaviour.parent = self
	
func _physics_process(_delta):
	behaviour.perform_movement()

func _on_took_damage(amount:int):
	# TODO: use the amount to display damage numbers
	animationPlayer.play("hit")

func _on_health_depleted():
	animationPlayer.play("death")
