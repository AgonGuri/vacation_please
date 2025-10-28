extends Control


var customer_resource: Array[CustomerResource] = []
var current_customer: CustomerResource 
#so we know to which customer what amount of money is sent
signal money_sent(customer: CustomerResource, amount: float)

@onready var animals = $NinePatchRect/Panel/NameList/Names
@onready var namesButton = $NinePatchRect/Panel/NamesButton
@onready var nameContainer = $NinePatchRect/Panel/NameList
@onready var conditions = $NinePatchRect/Panel/ConditionList/Conditions
@onready var conditionContainer = $NinePatchRect/Panel/ConditionList
@onready var information = $NinePatchRect/Information
@onready var conditionsButton = $NinePatchRect/Panel/ConditionsButton
@onready var document_panel = $NinePatchRect/DocumentPanel
@onready var customer_name= $NinePatchRect/DocumentPanel/CustomerName
@onready var customer_insurance_status = $NinePatchRect/DocumentPanel/CustomerInsuranceStatus
@onready var customer_species = $NinePatchRect/DocumentPanel/CustomerSpecies
@onready var money_input = $NinePatchRect/DocumentPanel/MoneyInput
@onready var done_button = $NinePatchRect/DocumentPanel/DoneButton
@onready var buttonBack = $NinePatchRect/Button


#calling functions and connecting buttons 
func _ready():
	size = Vector2(694, 677)
	populate_customer_text()
	homescreen()
	done_button.pressed.connect(on_done_button_pressed)
	namesButton.pressed.connect(on_names_button_pressed)
	conditionsButton.pressed.connect(on_conditions_button_pressed)
	buttonBack.pressed.connect(on_back_button_pressed)


#ui stuff
func homescreen():
	nameContainer.visible = false
	conditionContainer.visible = false
	document_panel.visible = false
	buttonBack.visible = false
	namesButton.visible = true
	conditionsButton.visible = true
	
#getting the information about each customer
func populate_customer_text():
#called from the global script
#read in the exact order from the folder they are created in
	for child in animals.get_children():
		child.queue_free()
	
	var customers = Global.get_all_customers_ordered()
	var text = ""
	for customer in customers:
		var button = Button.new()
		button.text = "%s" % [customer.name]
		button.pressed.connect(Callable(self, "customer_button_click").bind(customer))
		button.add_theme_color_override("font_color", Color.BLACK)
		
		#ui for buttons
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.0,0.0,0.0,0.0)
		button.add_theme_stylebox_override("normal", style)
		var hover_style = StyleBoxFlat.new()
		hover_style.bg_color = Color.BLUE
		button.add_theme_stylebox_override("hover", hover_style)
		var pressed_style = StyleBoxFlat.new()
		pressed_style.bg_color = Color.DIM_GRAY
		button.add_theme_stylebox_override("pressed", pressed_style)
		animals.add_child(button)
		var focus_style = StyleBoxFlat.new()
		focus_style.bg_color = Color.BLUE
		button.add_theme_stylebox_override("focus", focus_style)
		animals.add_child(button)

#when you click on the names' button it does some ui stuff
func on_names_button_pressed():
	namesButton.visible = false
	conditionsButton.visible = false
	buttonBack.visible = true
	nameContainer.visible = true
	

func on_conditions_button_pressed():
	namesButton.visible = false
	conditionsButton.visible = false
	buttonBack.visible = true
	conditionContainer.visible = true
	create_conditions_as_labels()


func create_conditions_as_labels():
	
	for child in conditions.get_children():
		child.queue_free()
	var conditions_list = [
		{"condition": "Broken limbs", "max_payout": 1000},
		{"condition": "Eye surgery", "max_payout": 5000},
		{"condition": "Cancer treatment", "max_payout": 15000},
		{"condition": "Parasitic illness", "max_payout": 750},
		{"condition": "Removal of foreign bodies", "max_payout": 1100},
		{"condition": "Recorrective surgery", "max_payout": 3700},
		{"condition": "Hypersensibilization", "max_payout": 10000},
		{"condition": "Psychotherapy", "max_payout": 50},
		{"condition": "Healthcare work", "max_payout": 5000}]
		
	for conditionItem in conditions_list:
		var conditionLabel = Label.new()
		conditionLabel.text = "%s - Max payout: $%d" % [conditionItem["condition"], conditionItem["max_payout"]]
		conditionLabel.size_flags_horizontal = Control.SIZE_FILL
		conditionLabel.add_theme_color_override("font_color", Color.BLACK)
		conditions.add_child(conditionLabel)

#when you click on some customer the document pops up 
func customer_button_click(customer: CustomerResource):
	current_customer = customer
	namesButton.visible = false
	conditionsButton.visible = false
	buttonBack.visible = true
	show_document(customer)

#display of information about the chosen customer on the document
func show_document(customer: CustomerResource):
	conditionContainer.visible = false
	document_panel.visible = true
	customer_name.text = "Name: %s" % customer.name
	customer_species.text = "Species: %s" % customer.species
	customer_insurance_status.text = "Has insurance: %s" % customer.insured
	money_input.text = "Amount in $" 
	##//done_button.pressed.disconnect_all()
	
#go back button
func on_back_button_pressed():
	homescreen()
	
#when we're done with the document 
func on_done_button_pressed():
	
	#if input is string it cleans unnecessary spaces and stuff
	var moneyAmount = money_input.text.strip_edges()
	#error handling
	if moneyAmount == "":
		push_warning("Sirrrrr please enter som moneh")
		return
		
	#reading the current customer and taking amount of money entered
	var amount = float(moneyAmount)
	if current_customer:
		emit_signal("money_sent", current_customer, amount)
	else:
		push_warning("No customer found :(")
		
	document_panel.visible = false
	homescreen()
		
	
	
	
	
