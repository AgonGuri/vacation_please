extends Node2D


@onready var catalogue = $catalogue

var current_customer
var instance

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	instance = load("res://scenes/AI Message.tscn").instantiate()
	add_child(instance)
	new_customer()
	pass # Replace with function body.

func new_customer():
	Global.next_customer()
	current_customer = Global.client_dict[Global.current_customer]
	print(Global.current_customer)
	$AnimalSprite.texture = current_customer.portrait
	$AnimationPlayer.play("customer_new")
	instance.delete_text()
	instance.generate_text()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	#turn off the catalogue if it is open
	if catalogue.openCatalogue.visible == true && event.is_pressed():
		catalogue.closeCanvas()
		


# calculation outcomes
var COMMISSION_PERCENTAGE = 0.15
var BONUS_PERCENTAGE = 0.4
var COURT_COST = 2000
var LYER_REWARD = 10
var LIE_COMING_OUT_PERCENTAGE = .5
var boss_text = " "

func commission(money):
	return money * COMMISSION_PERCENTAGE

func bonus(money):
	return money * BONUS_PERCENTAGE

func _on_main_ui_money_sent(customer: CustomerResource, amount: float) -> void:
	if customer.is_lying: #if hes lying
		if amount <= 0:
			#we sused out the liar and get little money
			boss_text = "We aint giving money to liars! Great that you sused that one out! Here is a little reward"
			Global.currency += LYER_REWARD
		#50% chance of lie gets out
		elif randf() < LIE_COMING_OUT_PERCENTAGE:
			#we pay everything
			Global.currency -= amount
			boss_text = "You pay for that liar from your own pocket!"


	#handeled customer well
	if amount == customer.max_payout : 
		Global.currency += commission(amount)
		boss_text = "Customer well handeled, heres the commission"

	#pay out of own pocket
	if amount > customer.max_payout:
		Global.currency -= (amount - customer.max_payout)
		boss_text = "No commission for you and you are paying everything over our max payout from your own pocket!"

	#get bonus since we save money
	if amount < customer.max_payout: 
		Global.currency += commission(amount) + bonus(customer.max_payout - amount)
		boss_text = "Nice you saved us some money, here is a bonus for the good work!"
		
		#the less we give them the higher the chance of being sued
		if amount < customer.price:
			if randf() < (customer.max_payout - amount) / customer.max_payout:
				#rest of what they could have gotten + court cost
				boss_text = ("you got sued and have to pay: %s" % (customer.max_payout - amount + COURT_COST))
				Global.currency -= customer.max_payout - amount + COURT_COST
	new_customer()
