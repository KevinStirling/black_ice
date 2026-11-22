extends Button

var player: Player


func _ready() -> void:
	player = get_parent()
	connect("pressed", turn_end)


func turn_end() -> void:
	if player.is_active:
		disabled = true
		player.turn_end()
