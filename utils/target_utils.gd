# Static utility functions for target selection
extends Node

func find_nearest_player(enemy: Enemy) -> Player:
	var players = get_tree().get_nodes_in_group("Player")\
					   		.filter(func(node:Node): return node is Player)
	if players.size() > 0:
		return find_closest_to(enemy, players)
	else:
		return null

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