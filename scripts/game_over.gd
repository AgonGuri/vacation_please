extends Node2D

func _ready():
	print(Global.currency)
	$Sprite2D/Label.text = str(Global.currency)+ "$"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_layout.tscn")
	
