class_name Dice
extends Node

signal rolled(faces: Array[int])

enum Faces {
	PEEK,
	SWAP,
	SET,
	RESET,
	COPY,
	WILD,
}

var quantity: int = 3
var current_roll: Array[int] = []


static func format_faces(faces: Array[int]) -> String:
	var parts: PackedStringArray = []
	for face in faces:
		if face < 0 or face >= Faces.size():
			parts.append("INVALID")
		else:
			parts.append(Faces.keys()[face])

	return " ".join(parts)


func roll() -> void:
	var result: Array[int] = []
	for i in quantity:
		result.append(randi_range(0, Faces.size() - 1))

	current_roll = result
	rolled.emit(current_roll)
