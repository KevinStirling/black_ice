class_name Player
extends Node

signal key_combo_changed(combo: Array[int])
signal active_changed(is_active: bool)
signal turn_finished
## peek_activated emitted when peek turn is used, consumed by GameManager to show player color at index
signal peek_activated(index: int)

@export var display_name: String = "Player 1"
@export var is_cpu: bool = false

var key_combo: Array[int]
var is_active: bool = false:
	set(value):
		if is_active == value:
			return
		is_active = value
		active_changed.emit(is_active)


func reset_key_combo(size: int) -> void:
	key_combo.resize(size)
	key_combo.fill(GameManager.ComboColor.BLACK)
	key_combo_changed.emit(key_combo)


func set_combo_slot(index: int, color: GameManager.ComboColor) -> void:
	if key_combo[index] == color:
		return
	key_combo[index] = color
	key_combo_changed.emit(key_combo)


func turn_end() -> void:
	turn_finished.emit()
	is_active = false
