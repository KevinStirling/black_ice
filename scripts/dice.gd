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

var quantity: int = 3
var current_roll: Array[int] = []


func roll() -> void:
	%CurrentRollValue.text = ""
	var result: Array[int] = []
	for i in quantity:
		result.append(randi_range(0, Faces.size() - 1))
		%CurrentRollValue.text = %CurrentRollValue.text + " " + Faces.keys()[result[i]]

	current_roll = result
