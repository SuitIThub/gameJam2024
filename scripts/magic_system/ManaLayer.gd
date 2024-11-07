extends Node

class_name ManaLayer

@export_range(3, 6)
var edges: int
@export
var runes: Array[Rune]
@export_range(0.0, 359.9, 0.1)
var rotation: float
var parentCircle: MagicCircle

func _init(initEdges: int = 3):
	self.edges = initEdges
	self.runes = []
	self.rotation = 0.0
	for i in range(self.edges):
		self.runes.append(null)

func setCircle(circle: MagicCircle):
	self.parentCircle = circle

func update_data():
	for rune in self.runes:
		if rune != null:
			rune.update_data()

func getLayer():
	return self.parentCircle.layers.find(self)

# Adds a rune to the specified edge of the mana layer.
# Updates the rune's layer and links it with adjacent runes.
#
# @param rune: The Rune instance to be added.
# @param edge: The index of the edge where the rune will be placed.
#
# The function performs the following steps:
# 1. Sets the rune's layer to the current layer.
# 2. Places the rune at the specified edge in the runes array.
# 3. Calculates the indices of the previous and next runes, wrapping around if necessary.
# 4. Updates the nextRune property of the previous rune to point to the new rune.
# 5. Sets the nextRune property of the new rune to point to the next rune in the sequence.
func addRune(rune: Rune, edge: int):
	rune.layer = self
	self.runes[edge] = rune

	if parentCircle != null:
		parentCircle.update_data()
	else:
		self.update_data()


# Retrieves the closest rune from another layer based on the position of a given rune.
# 
# @param self_rune_index The index of the rune in the current layer.
# @param other_layer_index The index of the other layer from which to find the closest rune.
# @return The closest rune from the specified other layer.
func getClosestRuneInOtherLayer(self_rune_index: int, other_layer_index: int) -> Rune:
	var rune_pos = getRuneCoordinate(self_rune_index)
	var other_layer = self.parentCircle.layers[other_layer_index]
	var other_layer_rune_index = other_layer.getClosestRuneToPosition(rune_pos)
	return other_layer.runes[other_layer_rune_index]


# Finds the closest rune to the given position.
# 
# This function iterates through all the runes in the current layer and calculates the distance
# from each rune to the given position. It returns the index of the rune that is closest to the
# given position.
#
# @param pos The position to compare against the runes' positions.
# @return The index of the closest rune in the same layer. Returns -1 if no runes are found.
func getClosestRuneToPosition(pos: Vector2) -> int:
	var closest_rune_index = -1
	var closest_distance = INF

	for i in range(self.edges):
		var rune_pos = getRuneCoordinate(i)
		var distance = pos.distance_to(rune_pos)
		if distance < closest_distance:
			closest_distance = distance
			closest_rune_index = i

	return closest_rune_index


# Returns the coordinate of a rune based on its index.
# 
# This function calculates the position of a rune in a circular pattern
# using polar coordinates. The angle for each rune is determined by its
# index, the total number of edges, and an optional rotation. The radius
# of the circle is determined by the layer property.
#
# @param index: The index of the rune in the circular pattern.
# @return: A Vector2 representing the coordinate of the rune.
func getRuneCoordinate(index: int) -> Vector2:
	var angle = (index * 360.0 / self.edges) + self.rotation
	var radians = deg_to_rad(angle)
	var x = self.getLayer() * cos(radians)
	var y = self.getLayer() * sin(radians)
	return Vector2(x, y)
