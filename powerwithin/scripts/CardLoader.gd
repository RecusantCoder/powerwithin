extends Node

class_name CardLoader

# Preload the Card class
const Card = preload("res://scripts/Card.gd")  # Adjust this path to match your project's structure

var cards: Array = []

func _ready():
	load_cards()

func load_cards():
	if FileAccess.file_exists("res://cards.json"):  # Check if the file exists
		print("Found cards.json, loading...")
		var file = FileAccess.open("res://cards.json", FileAccess.ModeFlags.READ)  # Open the file for reading
		var data = file.get_as_text()  # Read the file's contents as text
		print("Raw data:", data)
		
		# Create an instance of JSON and parse the data
		var json = JSON.new()
		var result = json.parse(data)  # Use the JSON instance to parse the string

		if result == OK:
			print("JSON parsed successfully. Loading cards...")
			var parsed_data = json.get_data()  # Get the parsed data (it will be a Dictionary or Array)
			for card_data in parsed_data:
				var card = Card.new()  # Create a new Card instance
				card.name = card_data["name"]
				card.cost = card_data["cost"]
				
				# Handle effects as an array of dictionaries
				card.effects.clear()  # Clear any existing effects
				for effect_data in card_data["effects"]:
					var effect = {
						"type": effect_data["type"],
						"value": effect_data["value"]
					}
					card.effects.append(effect)  # Add the effect to the card's effects array
				
				cards.append(card)  # Add the card to the cards array
				print("Loaded card:", card.name)
		else:
			print("Error parsing JSON:", result)  # Print the error code if parsing fails
	else:
		print("cards.json not found!")
