class_name GameManager
extends Node

enum State {
	PREGAME,
	GAMESTART,
	P1ROLL,
	P1TURN,
	P2ROLL,
	P2TURN,
	GAMEEND,
}
enum ComboColor {
	RED,
	GREEN,
	BLUE,
	YELLOW,
	ORANGE,
}

@export var debug: bool = false
@export var combo_size: int = 3

var combo: Array[ComboColor] = []
var game_state: State:
	get:
		return game_state
	set(value):
		game_state = value
		%StateValue.text = State.keys()[value]


func _ready() -> void:
	game_state = State.PREGAME
	if debug:
		%DebugLabel.visible = true
	start_game()


func start_game() -> void:
	game_state = State.GAMESTART
	set_combo()


func set_combo() -> void:
	for i in combo_size:
		combo.append(randi_range(0, 4))
		%ComboValue.text = %ComboValue.text + " " + ComboColor.keys()[combo[i]]
