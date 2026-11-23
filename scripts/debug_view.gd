extends Node2D
## Debug overlay. Subscribes to the models and renders their state; it is the
## only writer of these labels. Nothing here is reachable from the models.

@export var game_manager: GameManager
@export var dice: Dice

@onready var _combo_rows: Array[Label] = [%Player1KeyComboValue, %Player2KeyComboValue]
@onready var _phase: Label = %StateValue
@onready var _current_turn: Label = %CurrentPlayerValue
@onready var _combo: Label = %ComboValue
@onready var _roll: Label = %CurrentRollValue


func _ready() -> void:
	visible = game_manager.debug
	game_manager.phase_changed.connect(_on_phase_changed)
	game_manager.turn_changed.connect(_on_turn_changed)
	game_manager.combo_changed.connect(_on_combo_changed)
	dice.rolled.connect(_on_rolled)
	for i in game_manager.players.size():
		game_manager.players[i].key_combo_changed.connect(
			_on_player_combo_changed.bind(i),
		)
	refresh()


func refresh() -> void:
	_on_phase_changed(game_manager.phase)
	_on_turn_changed(game_manager.players[game_manager.current_turn])
	_on_combo_changed(game_manager.combo)
	_on_rolled(dice.current_roll)
	for i in game_manager.players.size():
		_on_player_combo_changed(game_manager.players[i].key_combo, i)


func _on_phase_changed(p: GameManager.Phase) -> void:
	_phase.text = GameManager.Phase.keys()[p]


func _on_turn_changed(player: Player) -> void:
	_current_turn.text = player.display_name


func _on_combo_changed(combo: Array[int]) -> void:
	_combo.text = GameManager.format_combo(combo)


func _on_player_combo_changed(combo: Array[int], index: int) -> void:
	_combo_rows[index].text = GameManager.format_combo(combo)


func _on_rolled(faces: Array[int]) -> void:
	_roll.text = Dice.format_faces(faces)
