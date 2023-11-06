@icon("res://components/weapons/projectile/Projectile.svg")

extends CollisionObject2D

class_name Projectile


@export var damage:= 5
@export var speed:= 300
@export var pircing:= 0

func _physics_process(delta):
	position += transform.x * speed * delta

# TODO: where should the hit calculation be performed? On the projectile or the hitbox?
# This has probably impact on the games overall performance,
# since we want to have hundrets of projectiles existing at the same time.
func hit() -> int:
	if pircing <= 0:
		queue_free()
	else:
		pircing =- 1
	return damage
