extends Control

#var animals_list = [
	#{"name": "agon", "insured": false},
	#{"name": "patrick", "insured": true}, 
	#{"name": "kris", "insured": true},
	#{"name": "sara", "insured": false}, 
#]

#var conditions_list = ["broken nose", "dirrahea", "eye infection", "uncotrollable laughing"]
var customer_resource: Array[CustomerResource] = []

@onready var animals = $NinePatchRect/Panel/NameList/Names
@onready var namesButton = $NinePatchRect/Panel/NamesButton
@onready var nameContainer = $NinePatchRect/Panel/NameList
@onready var conditions = $NinePatchRect/Panel/ConditionList/Conditions
@onready var conditionContainer = $NinePatchRect/Panel/ConditionList
@onready var information = $NinePatchRect/Information
@onready var document = $NinePatchRect/DocumentButton
@onready var conditionsButton = $NinePatchRect/Panel/ConditionsButton
@onready var document_panel = $NinePatchRect/DocumentPanel
@onready var customer_name= $NinePatchRect/DocumentPanel/CustomerName
@onready var customer_insurance_status = $NinePatchRect/DocumentPanel/CustomerInsuranceStatus
@onready var customer_species = $NinePatchRect/DocumentPanel/CustomerSpecies
@onready var money_input = $NinePatchRect/DocumentPanel/MoneyInput
@onready var done_button = $NinePatchRect/DocumentPanel/DoneButton
@onready var buttonBack = $NinePatchRect/Button

func _ready():
	size = Vector2(694, 677)

	populate_customer_text()
	homescreen()
	done_button.pressed.connect(on_done_button_pressed)
	namesButton.pressed.connect(on_names_button_pressed)
	buttonBack.pressed.connect(on_back_button_pressed)
	#conditionsButton.pressed.connect(on_conditions_button_pressed)

func homescreen():
	nameContainer.visible = false
	conditionContainer.visible = false
	document_panel.visible = false
	buttonBack.visible = false
	namesButton.visible = true
	conditionsButton.visible = true
	
func populate_customer_text():
	var customers = Global.get_all_customers()
	var text = ""
	for customer in customers:
		var button = Button.new()
		var insured_text = "yes" if customer.insured else "no"
		button.text = "%s, insured: %s" % [customer.name, insured_text]
		button.pressed.connect(Callable(self, "customer_button_click").bind(customer))
		animals.add_child(button)
		
func on_names_button_pressed():
	namesButton.visible = false
	conditionsButton.visible = false
	conditions.visible = false
	conditionContainer.visible = false
	document.visible = false
	buttonBack.visible = true
	nameContainer.visible = !nameContainer.visible
	

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
	namesButton.visible = false
	conditionsButton.visible = false
	document.visible = false
	buttonBack.visible = true
	show_document(customer)
		
func show_document(customer: CustomerResource):
	document.visible = false
	conditionContainer.visible = false
	document_panel.visible = true
	customer_name.text = "Name: %s" % customer.name
	customer_species.text = "Species: %s" % customer.species
	customer_insurance_status.text = "Has insurance: %s" % customer.insured
	
	money_input.text = "Money you give them" # Clear input
	##//done_button.pressed.disconnect_all()
	
func on_back_button_pressed():
	#change plis
	homescreen()
	
func on_done_button_pressed():
	document_panel.visible = false
