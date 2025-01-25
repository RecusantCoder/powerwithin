extends RefCounted  # Use Reference for data-only classes

class_name Card

var name: String
var cost: int
var effects: Array = []  # List of effects (e.g., [{type: "damage", value: 10}, {type: "draw", value: 1}])

# Method to return card information as a string
func get_card_info() -> String:
	var effects_str = []
	for effect in effects:
		effects_str.append(effect_to_string(effect))
	
	# Convert the array into a single string by manually joining each effect with a comma and a space
	var effects_combined = ""
	for i in range(effects_str.size()):
		effects_combined += effects_str[i]
		if i < effects_str.size() - 1:
			effects_combined += ", "  # Add a comma and space except after the last element
	
	# Return the final string
	return "\n".join([
		"Name: " + name,
		"Cost: " + str(cost),
		"Effects: " + effects_combined,
		"\n"
	])

# Helper method to convert effects array to a readable string
func effect_to_string(effect) -> String:
	return effect["type"] + ": " + str(effect["value"])

# Example of initializing a card from the JSON structure
# This should be done when creating a card instance, e.g., after parsing JSON
func init_card(name: String, cost: int, effects: Array) -> void:
	self.name = name
	self.cost = cost
	self.effects = effects
