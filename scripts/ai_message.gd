extends Control

@onready var ai_text = $PanelContainer/VBoxContainer/RichTextLabel
@onready var ai_chat = $NobodyWhoChat
@onready var overview = $PanelContainer/VBoxContainer/Overview

var customer = 1

@export var client_name = ""
@export var client_condition = ""
@export var client_price = 0
@export var client_species = ""
@export var client_is_insured = true
@export var client_is_lying = false
@export var client_lie = ""

func _ready():
	await get_tree().process_frame
	generate_text()

func generate_text():
	
	customer = Global.current_customer
	print(customer)
	client_name = Global.client_dict[customer].name
	client_species = Global.client_dict[customer].species
	client_condition = Global.client_dict[customer].condition
	client_price = Global.client_dict[customer].price
	client_is_lying = Global.client_dict[customer].is_lying
	client_lie = Global.client_dict[customer].lie
	client_is_insured = Global.client_dict[customer].insured
	
	overview.text = "Name: " + client_name + "\nSpecies: " + client_species + "\nCondition: " + client_condition + "\nClaim: " + str(client_price)
	
	if client_is_lying == false:
		print("setting truthful prompt")
		ai_chat.system_prompt = "In this world everyone is an animal. Your name is " + client_name + ". You are talking to a health insurance representative, trying to get a payout. You say you suffered from " + client_condition + " and it cost you " + str(client_price) + " Lovecoints (a fictional currency). Your speech should be in coherent, formal sentences, and around 100 words. Never send anything other than literal, direct speech (for example: never describe your actions in **)."
	elif client_is_lying == true:
		print("setting lying prompt")
		ai_chat.system_prompt = "In this world everyone is an animal. You are talking to a health insurance representative and want to get a payout. Your speak in coherent, formal sentences. Use about 100 words. However, you are lying about " + client_lie + ". You say your name is " + client_name + ". You request a payout of " + str(client_price) + " Lovecoins (a fictional currency) for " + client_condition + ". If you are lying about your condition give the reader a hint to figure it out (hidden in the text). Never send anything other than literal, direct speech (for example: never describe your actions in **)."
	else:
		print("Error: client_is_lying not found/set")
	
	await get_tree().process_frame
	
	print("About to start talking")
	ai_chat.say("start talking")

func delete_text():
	overview.text("")
	ai_text.text("")


func _on_nobody_who_chat_response_updated(new_token: String) -> void:
	ai_text.text += new_token
	
