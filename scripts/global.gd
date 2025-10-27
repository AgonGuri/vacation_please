extends Node

@export var current_customer = 0
@export var last_customer = 12
var client_dict = {}

func _ready():
	load_and_randomize_clients()
	
func load_and_randomize_clients():
	var folder_path = "res://scripts/customers/"  # Change this to your folder
	var clients = []
	
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
	
	# Randomize the order
	clients.shuffle()
	
	# Create dictionary with numbers as keys
	for i in range(clients.size()):
		client_dict[i] = clients[i]
	
	print("Loaded ", client_dict.size(), " clients")

func new_customer():
	if current_customer == last_customer:
		end_game()
	else:
		current_customer += 1
		start_customer(current_customer)
		
	
func start_customer(customer):
	#client_dict[customer]
	#play animation and sound
	#Load UI with relevant information
	
	pass

func end_game():
	pass
