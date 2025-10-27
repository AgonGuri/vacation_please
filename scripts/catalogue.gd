extends TextureButton

@onready var openCatalogue = $openCatalogue
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func closeCanvas() -> void:
	openCatalogue.visible = false
	button_pressed = false

func _pressed() -> void:
	if openCatalogue.visible == false :
		openCatalogue.visible = true
