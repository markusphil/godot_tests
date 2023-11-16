@icon("res://components/weapons/projectile_emitter/ProjectileEmitter.svg")
extends Node

class_name ProjectileEmitter

@export var projectile: PackedScene
@export_range(0.1,600.0) var fire_rate:= 30.0

func _ready():
	reset_timer()

func reset_timer():
	var fire_interval = 60.0 / fire_rate
	var emit_timer = Timer.new()
	add_child(emit_timer)
	emit_timer.timeout.connect(_emit_projectile)
	emit_timer.start(fire_interval)

func _emit_projectile():
	var projectile_instance = projectile.instantiate() as Projectile
	# TODO: inject the root sceene in a way that does not depend on the node path!
	get_parent().get_parent().add_child(projectile_instance)
	projectile_instance.global_transform = self.global_transform
	
