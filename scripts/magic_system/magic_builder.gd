extends Node

@export var circle: MagicCircle

func _ready() -> void:
	self.circle = MagicCircle.new()

	var layer1 = ManaLayer.new()
	var layer2 = ManaLayer.new(6)
	self.circle.addLayer(layer1)
	self.circle.addLayer(layer2)

	var mana_effect1 = Mana.new(0)
	mana_effect1.manaElement = Mana.ElementType.FIRE
	var rune1 = EffectRune.new("Rune1", "Rune1 description", "R1", 1, mana_effect1)
	layer1.addRune(rune1, 0)

	var rune2 = SplitRune.new("Rune2", "Rune2 description", "R2", 1, 2, 0.5)
	layer1.addRune(rune2, 1)

	var mana_effect3 = Mana.new(10)
	var rune3 = EffectRune.new("Rune3", "Rune3 description", "R3", 1, mana_effect3)
	layer1.addRune(rune3, 2)

	var mana_effect4 = Mana.new(0)
	mana_effect4.manaElement = Mana.ElementType.WATER
	var rune4 = EffectRune.new("Rune4", "Rune4 description", "R4", 1, mana_effect4)
	layer2.addRune(rune4, 0)



	var mana = Mana.new(100)
	self.circle.update_data()
	self.circle.injectMana(mana)
