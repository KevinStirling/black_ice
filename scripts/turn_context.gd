class_name TurnContext
extends Resource

var acting_player: Player
var opponent_player: Player
var roll: Array[int]
var _manager: GameManager


func _init(manager: GameManager, acting: Player, opponent: Player) -> void:
	_manager = manager
	acting_player = acting
	opponent = opponent
