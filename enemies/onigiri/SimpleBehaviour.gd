# TODO: add an icon
extends Node

class_name SimpleBehaviour

@export var speed: int = 50

func provide_movement(enemy: Enemy):
	var closest_target = find_nearest_player(enemy)
	if closest_target != null:
		enemy.velocity = (closest_target.global_position - enemy.global_position).normalized() * speed
		enemy.move_and_slide()

func find_nearest_player(enemy: Enemy) -> Player:
	var players = get_tree().get_nodes_in_group("Player").filter(func(node:Node): return node is Player)
	if players.size() > 0:
		return find_closest_to(enemy, players)
	else:
		return null

# TODO: move to a global util
func find_closest_to(target: Node2D, candidates: Array) -> Node2D:
	candidates.sort_custom(is_closer_to(target))
	return candidates[0]

func is_closer_to(target: Node2D) -> Callable:
	return func (a: Node2D, b:Node2D):
		var a_distance = distance(a, target)
		var b_distance = distance(b, target)
		return a_distance < b_distance
	
func distance(a: Node2D, b: Node2D) -> float:
	return a.global_position.distance_to(b.global_position)
	
