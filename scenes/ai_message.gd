extends Control

@onready var ai_text = $PanelContainer/VBoxContainer/RichTextLabel
@onready var ai_chat = $NobodyWhoChat

@export var client_name = ""
@export var client_condition = ""
@export var client_price = 0
@export var client_species = ""
@export var client_is_insured = true
@export var client_is_lying = false

func _ready():
	if client_is_lying == false:
		print("setting truthful prompt")
		ai_chat.system_prompt = "Your name is " + client_name + " and you are a " + client_species + ". You are talking to a health insurance, trying to get a payout. You say you suffered from " + client_condition + " and it cost you " + str(client_price) + " Lovecoints (a fictional currency). You have insurance at this company and they owe you the money. Your speech should be somewhat formal and have a random length between 60 and 100 words. You may only use plain speech. You are being truthful."
	elif client_is_lying == true:
		print("setting lying prompt")
		ai_chat.system_prompt = ""
	else:
		print("Error: client_is_lying not found/set")
	
	await get_tree().process_frame
	
	
	print("About to start talking")
	ai_chat.say("start talking")



func _on_nobody_who_chat_response_updated(new_token: String) -> void:
	print("token recieved")
	ai_text.text += new_token
