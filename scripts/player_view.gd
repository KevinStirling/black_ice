class_name PlayerView
extends Control

@export var player: Player

@onready var _end_turn_button: Button = %EndTurnButton


func _ready() -> void:
	player.active_changed.connect(_on_active_changed)
	_end_turn_button.pressed.connect(player.turn_end)
	_end_turn_button.text = "end turn " + player.display_name
	refresh()


func refresh() -> void:
	_on_active_changed(player.is_active)


func set_interactable(v: bool) -> void:
	_end_turn_button.disabled = not v


func _on_active_changed(is_active: bool) -> void:
	set_interactable(is_active)
