extends Node

@export var current_customer = -1
@export var last_customer = 3
var client_dict = {} #dictionary for clients showing up(same as below but randomized)
var clean_dict = {} #dictionary for buttons on pc
var scene

var currency = 0

func _ready():
	client_list()
	
func client_list():
	load_and_randomize_clients()
	#next_customer()
	
func load_and_randomize_clients():
	var folder_path = "res://scripts/customers/"  # Change this to your folder
	var clients: Array = []
	
	# Get all files from the folder
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.ends_with(".tres"):
				var resource = load(folder_path + file_name)
				clients.append(resource)
			
			file_name = dir.get_next()
		
		dir.list_dir_end()
	else:
		print("Failed to open directory: ", folder_path)
	
	for i in range(clients.size()):
		clean_dict[i] = clients[i]
	
	# Randomize the order
	clients.shuffle()
	
	# Create dictionary with numbers as keys
	for i in range(clients.size()):
		client_dict[i] = clients[i]
	
	print("Loaded ", client_dict.size(), " clients")
	for key in client_dict.keys():
		var customer = client_dict[key]
		print("%d: Name: %s, Insured: %s, Condition: %s, Price: $%d" % [
		key,
		customer.name,
		"Yes" if customer.insured else "No",
		customer.condition,
		customer.price
	])

#func start_customer(customer):
	#print(client_dict[customer].name)
	##play animation and sound
	##Load UI with relevant information
	##Load corresponding LLM Text
	#pass

func get_all_customers_ordered() -> Array:
	return clean_dict.values()

func get_customer(index: int):
	return client_dict.get(index, null)

func get_all_customers() -> Array:
	return client_dict.values()

func next_customer():
	if current_customer >= last_customer:
		end_game()
	else:
		current_customer += 1
		return get_customer(current_customer)

func end_game():
	print("Game Over")
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
func reset():
	print("resetting")
	current_customer = 0
	client_list()
