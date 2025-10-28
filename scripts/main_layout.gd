extends Node2D


@onready var catalogue = $catalogue

var current_customer

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	var instance = load("res://scenes/AI Message.tscn").instantiate()
	add_child(instance)
	new_customer()
	pass # Replace with function body.

func new_customer():
	Global.next_customer()
	current_customer = Global.client_dict[Global.current_customer]
	print(Global.current_customer)
	$AnimalSprite.texture = current_customer.portrait
	$AnimationPlayer.play("customer_new")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	#turn off the catalogue if it is open
	if catalogue.openCatalogue.visible == true && event.is_pressed():
		catalogue.closeCanvas()
