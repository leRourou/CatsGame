class_name RoomRepository extends Node2D

func get_normal_room(pattern: PatternUtils.Patterns) -> Node2D:
	return $NormalRooms.get_child(pattern).duplicate()
