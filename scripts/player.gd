class_name Player
extends Node

enum PlayerNum {
	ONE,
	TWO,
}

@export var player: PlayerNum = PlayerNum.ONE

var key_combo: Array[int]:
	get:
		return key_combo
	set(value):
		key_combo = value
		if player == PlayerNum.ONE:
			%Player1KeyComboValue.text = _get_color_from_enum_int(value)


func _ready() -> void:
	%GameManager.connect("GameStart", reset_key_combo)


func reset_key_combo(combo_size: int) -> void:
	key_combo.clear()
	var c: Array[int]
	for i in combo_size:
		c.append(GameManager.ComboColor.BLACK)
	key_combo = c


func _get_color_from_enum_int(value: Array[int]) -> String:
	var parts: PackedStringArray
	for color in value:
		if color > GameManager.ComboColor.size() - 1:
			parts.append("INVALID")
			break
		parts.append(GameManager.ComboColor.keys()[color])

	return " ".join(parts)
