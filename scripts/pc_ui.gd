extends Control

#var animals_list = [
	#{"name": "agon", "insured": false},
	#{"name": "patrick", "insured": true}, 
	#{"name": "kris", "insured": true},
	#{"name": "sara", "insured": false}, 
#]

#var conditions_list = ["broken nose", "dirrahea", "eye infection", "uncotrollable laughing"]
var customer_resource: Array[CustomerResource] = []

@onready var animals = $NameList/Names
@onready var namesButton = $NamesButton
@onready var nameContainer = $NameList
@onready var conditions = $ConditionList/Conditions
@onready var conditionContainer = $ConditionList
@onready var information = $Information
@onready var document = $DocumentButton
@onready var conditionsButton = $ConditionsButton

func _ready():
	customer_resource = [
		preload("res://scripts/customers/1.tres"),
		preload("res://scripts/customers/2.tres"),
		preload("res://scripts/customers/3.tres")
	]
	
	namesButton.pressed.connect(on_names_button_pressed)
	#conditionsButton.pressed.connect(on_conditions_button_pressed)
	nameContainer.visible = false
	conditionContainer.visible = false
	conditionsButton.visible = false

func on_names_button_pressed():
	namesButton.visible = false
	conditionsButton.visible = false
	conditions.visible = false
	conditionContainer.visible = false
	nameContainer.visible = !nameContainer.visible
	for customer in customer_resource:
		var button = Button.new()
		var insured_text = "yes" if customer.insured else "no"
		button.text = "%s, insured: %s" % [customer.name, insured_text]
		#//meContainer.scroll_vertical = 0
		button.pressed.connect(Callable(self, "customer_button_click").bind(customer))
		animals.add_child(button)
		
#func on_conditions_button_pressed():
	#namesButton.visible = false
	#conditionsButton.visible = false
	#animals.visible = false
	#nameContainer.visible = false
	#conditionContainer.visible = !conditionContainer.visible
	#for condition in customer_resource:
		#var label = Label.new()
		#label.text = condition.condition
		#label.mouse_filter = Control.MOUSE_FILTER_STOP
		#conditions.add_child(label)
		##//meContainer.scroll_vertical = 0

func customer_button_click(customer: CustomerResource):
		information.text = "Condition: %s" % customer.condition
