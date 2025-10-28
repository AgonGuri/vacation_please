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
		
		# calculation outcomes
var COMMISSION_PERCENTAGE = 0.15
var BONUS_PERCENTAGE = 0.4
var COURT_COST = 2000

func commission(money):
	return money * COMMISSION_PERCENTAGE

func bonus(money):
	return money * BONUS_PERCENTAGE

func _on_main_ui_money_sent(customer: CustomerResource, amount: float) -> void:
	print("got into the signal at least")
	if customer.is_lying: #if hes lying
		if randf() < .5:	#50% chance of max payout being 0 meaning lie gets out
			if amount > 0 :
				Global.currency -= amount
				print("boss: you pay for that liar!")
			else:print("we aint giving money to liars!")
		else: print("*that lie didt get out, you got lucky*")
	if amount == customer.max_payout : #handeled customer well
		Global.currency += commission(amount)
		print("boss: customer well handeled, heres the commission")
	if amount > customer.max_payout: #pay out of own pocket
		Global.currency -= (amount - customer.max_payout)
		print("boss: no commission for you and you are paying everything over the max payout!")
	if amount < customer.max_payout: #get bonus since we save money
		Global.currency += commission(amount) + bonus(customer.max_payout - amount)
		print("boss: nice you saved us some money, here is a bonus for the good work!")
		if amount < customer.price: #the less we give them the higher the chance of being sued
			if randf() < (customer.max_payout - amount) / customer.max_payout:
				#rest of what they could have gotten + court
				print("you got sued and have to pay: ", (customer.max_payout - amount + COURT_COST))
				Global.currency -= customer.max_payout - amount + COURT_COST
