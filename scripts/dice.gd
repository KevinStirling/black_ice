class_name Dice
extends Node

enum Faces {
	PEEK,
	SWAP,
	SET,
	RESET,
	COPY,
	WILD,
}

@export var quantity: int = 3


static func format_faces(faces: Array[int]) -> String:
	var parts: PackedStringArray = []
	for face in faces:
		if face < 0 or face >= Faces.size():
			parts.append("INVALID")
		else:
			parts.append(Faces.keys()[face])

	return " ".join(parts)


func roll() -> Array[int]:
	var result: Array[int] = []
	for i in quantity:
		result.append(Faces.values().pick_random())

	return result
