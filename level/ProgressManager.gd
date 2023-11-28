extends Node

class_name ProgressManager

# This node is meant to increase the games difficulty based on passend time
# and / or player performance.
#
# - [x] Initially it will just raise the spawnrate of a singular enemy spawner in
#       a predefined intervall.
# - [ ] Once we track the players kill count, it should also scale based on this,
#       for a more challenging experience.
# - [ ] Once more enemy types are introduced it should also add in new spawner nodes
#       on certain time keys.

@export var spawner: EnemySpawner
@export var raise_interval: float = 30.0 # interval between increase steps (seconds)
@export var raise_amount: float = 10.0 # increase of the enemy spawn rate (spawns/min)

func _ready():
	var progress_timer = Timer.new()
	add_child(progress_timer)
	progress_timer.timeout.connect(_raise_spawn_rate)
	progress_timer.start(raise_interval)
	
func _raise_spawn_rate():
	spawner.update_rate(spawner.spawn_rate + raise_amount)
	print("Raised spawn rate to %s spawns/min" % spawner.spawn_rate)
