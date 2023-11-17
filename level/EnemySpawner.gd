extends Node

class_name EnemySpawner

@export var enemy_scene: PackedScene # The enemy to spawn
@export var camera: Camera2D # Is used to calculate spawn positions
@export var spawn_root_node: Node2D # The parent node of the spwned enemies

@export var spawn_rate: float = 30.0 # Spawns per minute
@export var spawn_base_radius: float = 500.0

@onready var spawn_timer: Timer = Timer.new()

# TODO: Keep track of enemies far away from the camera 
#       and teleport them closer to the players

func _ready():
	# Setup timer
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_spawn_enemy)
	_spawn_enemy() # Spawn the initial enemy
	
func reset_timer():
	var spawn_interval = 60.0 / spawn_rate
	spawn_timer.start(spawn_interval)

func _spawn_enemy():
	var enemy = enemy_scene.instantiate()
	spawn_root_node.add_child(enemy)
	# Make the spawn radius depend on the camera zoom, to ensure enemies spwan outside
	# of the camera viewport.
	# Invariant: in the multi tracking camera script we ensure an uniform zoom for x and y
	var spawn_radius = spawn_base_radius * camera.zoom.x
	# Spawn enemies on random positions on a circle around the camera center
	enemy.position = camera.position + Vector2(spawn_radius, 0).rotated(randf_range(0, 2*PI))
	
func update_rate(rate: float):
	spawn_rate = rate
	reset_timer()
	

