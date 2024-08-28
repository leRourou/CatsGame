class_name RoomRepository extends Node2D

func get_normal_room(pattern: Pattern.Type) -> Node2D:
	return $NormalRooms.get_child(pattern).duplicate()
