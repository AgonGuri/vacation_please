extends Control

var animals_list = [
	{"name": "agon", "insured": false},
	{"name": "patrick", "insured": true}, 
	{"name": "kris", "insured": true},
	{"name": "sara", "insured": false}, 
]

var conditions_list = ["broken nose", "dirrahea", "eye infection", "uncotrollable laughing"]

@onready var animals = $NameList/Names
@onready var namesButton = $NamesButton
@onready var nameContainer = $NameList
@onready var conditions = $ConditionList/Conditions
@onready var conditionContainer = $ConditionList
@onready var information = $Information
@onready var document = $DocumentButton
@onready var conditionsButton = $ConditionsButton

func _ready():
	namesButton.pressed.connect(on_names_button_pressed)
	conditionsButton.pressed.connect(on_conditions_button_pressed)
	nameContainer.visible = false
	conditionContainer.visible = false

func on_names_button_pressed():
	namesButton.visible = false
	conditionsButton.visible = false
	conditions.visible = false
	conditionContainer.visible = false
	nameContainer.visible = !nameContainer.visible
	for animal in animals_list:
		var label = Label.new()
		label.text = animal.name
		label.mouse_filter = Control.MOUSE_FILTER_STOP
		animals.add_child(label)
		#//meContainer.scroll_vertical = 0
		
func on_conditions_button_pressed():
	namesButton.visible = false
	conditionsButton.visible = false
	animals.visible = false
	nameContainer.visible = false
	conditionContainer.visible = !conditionContainer.visible
	for condition in conditions_list:
		var label = Label.new()
		label.text = condition
		label.mouse_filter = Control.MOUSE_FILTER_STOP
		conditions.add_child(label)
		#//meContainer.scroll_vertical = 0
