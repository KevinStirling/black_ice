class_name GameManager
extends Node

signal phase_changed(phase: Phase)
signal turn_changed(player: Player)
signal combo_changed(combo: Array[int])
signal roll_changed(roll: Array[int])

enum Phase {
	PREGAME,
	GAMESTART,
	ROLL,
	ACTION,
	RESOLVE,
	GAMEEND,
}
## black indicates empty, used mostly by player key_combo
enum ComboColor {
	BLACK,
	RED,
	GREEN,
	BLUE,
	YELLOW,
	ORANGE,
}

@export var debug: bool = false
@export var combo_size: int = 3
@export var players: Array[Player] = []

var phase: Phase = Phase.PREGAME:
	set(value):
		if phase == value:
			return
		phase = value
		phase_changed.emit(value)
var current_turn: int = 0:
	set(value):
		if current_turn == value:
			return
		current_turn = value
		turn_changed.emit(players[value])
var combo: Array[int] = []:
	set(value):
		combo = value
		combo_changed.emit(value)
var current_roll: Array[int] = []:
	set(value):
		current_roll = value
		roll_changed.emit(value)
var _running: bool = false


static func format_combo(c: Array[int]) -> String:
	var parts: PackedStringArray
	for color in c:
		if color < 0 or color >= ComboColor.size():
			parts.append("INVALID")
		else:
			parts.append(GameManager.ComboColor.keys()[color])

	return " ".join(parts)


func _ready() -> void:
	phase = Phase.PREGAME
	start_game()


func start_game() -> void:
	phase = Phase.GAMESTART
	set_combo()
	for p in players:
		p.reset_key_combo(combo_size)
	_running = true
	while _running:
		await _run_turn()


func stop_game() -> void:
	_running = false


func set_combo() -> void:
	combo.clear()
	for i in combo_size:
		# choose random values from ComboColor range excluding 0 (black means empty)
		combo.append(randi_range(1, ComboColor.size() - 1))


func roll() -> void:
	current_roll.clear()
	current_roll = %Dice.roll()


func _run_turn() -> void:
	var p := players[current_turn]
	p.is_active = true
	phase = Phase.ROLL
	roll()
	phase = Phase.ACTION
	await p.turn_finished
	if not _running:
		return
	p.is_active = false
	phase = Phase.RESOLVE
	current_turn = (current_turn + 1) % players.size()
