class_name ComboView
extends Node2D

signal slot_selected(index: int)

@export var game_manager: GameManager
@export var slot_scene: PackedScene


func _ready() -> void:
	game_manager.combo_changed.connect(_on_combo_changed)
	_on_combo_changed(game_manager.combo)


func _on_combo_changed(combo: Array[int]) -> void:
	for c in get_children():
		c.queue_free()
	for i in combo.size():
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.position.x = i * 64
