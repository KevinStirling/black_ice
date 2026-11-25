class_name DiceView
extends Node2D

signal die_dropped(die_index: int, slot_index: int)

@export var game_manager: GameManager
@export var die_scene: PackedScene

var _dice: Array[DieView] = []


func _ready() -> void:
	for i in game_manager.dice.quantity:
		var d: DieView = die_scene.instantiate()
		add_child(d)
		d.position = Vector2(i * 80, 0)
		d.index = i
		_dice.append(d)
	game_manager.roll_changed.connect(_on_roll_changed)
	_on_roll_changed(game_manager.current_roll)


func _on_roll_changed(roll: Array[int]) -> void:
	for i in _dice.size():
		_dice[i].set_face(roll[i] if i < roll.size() else -1)
