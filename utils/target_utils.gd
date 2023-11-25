# Static utility functions for target selection
extends Node


func find_nearest_alive_player(enemy: Enemy) -> Player:
	return find_nearest_player_with_filter(
			enemy,
			func(node:Node): return node is Player and not node.is_dead
	)

func find_nearest_player(enemy: Enemy) -> Player:
	return find_nearest_player_with_filter(enemy, func(node:Node): return node is Player)
		
func find_nearest_player_with_filter(enemy: Enemy, filter: Callable):
	var players = get_tree().get_nodes_in_group("Player")\
					   		.filter(filter)
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
