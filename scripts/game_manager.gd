class_name GameManager
extends Node

signal GameStart(combo_size: int)
signal TurnStart(player: Player.PlayerNum)

enum State {
	PREGAME,
	GAMESTART,
	P1ROLL,
	P1TURN,
	P2ROLL,
	P2TURN,
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

var combo: Array[ComboColor] = []
var game_state: State:
	get:
		return game_state
	set(value):
		game_state = value
		%StateValue.text = State.keys()[value]
var current_turn: Player.PlayerNum = Player.PlayerNum.ONE


func _ready() -> void:
	game_state = State.PREGAME
	if debug:
		%DebugLabel.visible = true
	start_game()


func start_game() -> void:
	game_state = State.GAMESTART
	set_combo()
	emit_signal("GameStart", combo_size)
	next_turn(true)


func next_turn(is_start: bool = false) -> void:
	if !is_start:
		if current_turn == Player.PlayerNum.ONE:
			current_turn = Player.PlayerNum.TWO
		else:
			current_turn = Player.PlayerNum.ONE
	emit_signal("TurnStart", current_turn)


func set_combo() -> void:
	for i in combo_size:
		## choose random values from ComboColor range excluding 0 (black means empty)
		combo.append(randi_range(1, ComboColor.size() - 1))
		%ComboValue.text = %ComboValue.text + " " + ComboColor.keys()[combo[i]]
