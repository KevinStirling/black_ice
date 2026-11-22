class_name Player
extends Node

enum PlayerNum {
	ONE,
	TWO,
}

@export var player: PlayerNum = PlayerNum.ONE
@export var is_cpu: bool = false
# TODO would like a nicer way to manage the state of the players ui
@export var end_turn_button: Button

var key_combo: Array[int]:
	get:
		return key_combo
	set(value):
		key_combo = value
		if player == PlayerNum.ONE:
			%Player1KeyComboValue.text = _get_color_from_enum_int(value)
		else:
			%Player2KeyComboValue.text = _get_color_from_enum_int(value)
var is_active: bool = false:
	get:
		return is_active
	set(value):
		is_active = value
		%CurrentPlayerValue.text = PlayerNum.keys()[player]


func _ready() -> void:
	%GameManager.connect("GameStart", reset_key_combo)
	%GameManager.connect("TurnStart", turn_start)


func reset_key_combo(combo_size: int) -> void:
	key_combo.clear()
	var c: Array[int]
	for i in combo_size:
		c.append(GameManager.ComboColor.BLACK)
	key_combo = c


func turn_start(p_turn: PlayerNum) -> void:
	if p_turn != player:
		return
	print("player " + PlayerNum.keys()[player] + " is active")
	is_active = true
	end_turn_button.disabled = false
	%Dice.roll()


func turn_end() -> void:
	%GameManager.next_turn()
	is_active = false


func _get_color_from_enum_int(value: Array[int]) -> String:
	var parts: PackedStringArray
	for color in value:
		if color > GameManager.ComboColor.size() - 1:
			parts.append("INVALID")
			break
		parts.append(GameManager.ComboColor.keys()[color])

	return " ".join(parts)
