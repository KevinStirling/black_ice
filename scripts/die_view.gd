class_name DieView
extends Node2D

var index: int
var face: Dice.Faces
var _home: Vector2


func set_face(f: int) -> void:
	face = f as Dice.Faces
	%Label.text = Dice.format_faces([f])
	modulate.a = 1.0 if f >= 0 else 0.3
