class_name Player
extends Node

enum PlayerNum {
	ONE,
	TWO,
}

@export var player: PlayerNum = PlayerNum.ONE

var key_combo: Array[GameManager.ComboColor]:
	get:
		return key_combo
	set(value):
		key_combo = value
		if player == PlayerNum.ONE:
			%Player1KeyComboValue.text = _stringify_key_combo_value(value)


func _ready() -> void:
	%GameManager.connect("GameStart", reset_key_combo)


func reset_key_combo(combo_size: int) -> void:
	key_combo.clear()
	var c: Array[GameManager.ComboColor]
	for i in combo_size:
		c.append(GameManager.ComboColor.BLACK)
	key_combo = c


func _stringify_key_combo_value(value: Array[GameManager.ComboColor]) -> String:
	var s: String
	for i in value:
		s = s + " " + GameManager.ComboColor.keys()[value[i]]

	return s
