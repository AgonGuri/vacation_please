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
@onready var document_panel = $DocumentPanel
@onready var customer_name= $DocumentPanel/CustomerName
@onready var customer_condition = $DocumentPanel/CustomerCondition
@onready var customer_price = $DocumentPanel/CustomerPrice
@onready var money_input = $DocumentPanel/MoneyInput
@onready var done_button = $DocumentPanel/DoneButton

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
	document_panel.visible = false

func on_names_button_pressed():
	namesButton.visible = false
	conditionsButton.visible = false
	conditions.visible = false
	conditionContainer.visible = false
	document.visible = false
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
		document.visible = true
		#document.pressed.disconnect_all
		document.pressed.connect(Callable(self, "show_document").bind(customer))
		
func show_document(customer: CustomerResource):
	document.visible = false
	nameContainer.visible = false
	conditionContainer.visible = false
	document_panel.visible = true
	customer_name.text = "Name: %s" % customer.name
	customer_condition.text = "Condition: %s" % customer.condition
	customer_price.text = "Price: $%d" % customer.price 
	
	money_input.text = "" # Clear input
	#//done_button.pressed.disconnect_all()
	done_button.pressed.connect(Callable(self, "on_done_pressed").bind(customer))
