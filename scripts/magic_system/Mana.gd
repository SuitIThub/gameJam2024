extends Node

class_name Mana

enum ElementType {RAW, FIRE, WATER, EARTH, AIR, STEAM, LAVA, LIGHTNING, MUD, ICE, DUST}
enum ManaProperty {FAST, SLOW, EXPANDED, COMPRESSED}

var uid: String
var manaAmount: float
var manaStrength: float
var manaSpeed: float
var manaElement: ElementType
var manaProperties: Array[ManaProperty]

func _init(startingManaAmount):
	self.uid = Helper.generate_unique_id()
	self.manaAmount = startingManaAmount
	self.manaStrength = 1.0
	self.manaSpeed = 1.0
	self.manaElement = ElementType.RAW
	self.manaProperties = []

func applyMana(mana: Mana):
	self.manaAmount += mana.manaAmount
	self.manaStrength += mana.manaStrength
	self.manaSpeed += mana.manaSpeed
	self.manaElement = combineElements(self.manaElement, mana.manaElement)
	for property in mana.manaProperties:
		if property not in self.manaProperties:
			self.manaProperties.append(property)

func combineElements(element1: ElementType, element2: ElementType):
	if element1 == ElementType.RAW:
		return element2
	elif element2 == ElementType.RAW:
		return element1

	var element_combinations = {
		ElementType.FIRE: {
			ElementType.WATER: ElementType.STEAM,
			ElementType.EARTH: ElementType.LAVA,
			ElementType.AIR: ElementType.LIGHTNING
		},
		ElementType.WATER: {
			ElementType.FIRE: ElementType.STEAM,
			ElementType.EARTH: ElementType.MUD,
			ElementType.AIR: ElementType.ICE
		},
		ElementType.EARTH: {
			ElementType.FIRE: ElementType.LAVA,
			ElementType.WATER: ElementType.MUD,
			ElementType.AIR: ElementType.DUST
		},
		ElementType.AIR: {
			ElementType.FIRE: ElementType.LIGHTNING,
			ElementType.WATER: ElementType.ICE,
			ElementType.EARTH: ElementType.DUST
		}
	}

	if element1 in element_combinations and element2 in element_combinations[element1]:
		return element_combinations[element1][element2]
	elif element2 in element_combinations and element1 in element_combinations[element2]:
		return element_combinations[element2][element1]
	else:
		return element1

func changeManaAmount(amount: float):
	self.manaAmount += amount

func clone() -> Mana:
	var new_mana = Mana.new(self.manaAmount)
	new_mana.manaStrength = self.manaStrength
	new_mana.manaSpeed = self.manaSpeed
	new_mana.manaElement = self.manaElement
	for property in self.manaProperties:
		new_mana.manaProperties.append(property)
	return new_mana

func _to_string() -> String:
	var keys = ElementType.keys()
	var element = keys[self.manaElement]
	return "Mana: " + str(self.manaAmount) + ", " + str(manaStrength) + ", " + element + ", " + str(self.manaProperties)
