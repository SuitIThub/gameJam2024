extends ShiftRune

class_name SplitRune

var nextLayerRune: Rune
@export
var splitRatio: float

func _init(rune_name: String, rune_description: String, rune_symbol: String, rune_level: int, rune_cost: float, split_ratio: float):
	super._init(rune_name, rune_description, rune_symbol, rune_level, rune_cost)
	self.type = RuneType.SPLIT
	self.splitRatio = split_ratio

func update_data():
	if self.layer == null:
		return
	if self.layer.parentCircle == null:
		return
	if self.layer.parentCircle.layers.size() <= self.layer.getLayer() + 1:
		return
	var next_layer = self.layer.parentCircle.layers[self.layer.getLayer() + 1]
	self.nextLayerRune = self.layer.getClosestRuneInOtherLayer(self.layer.runes.find(self), next_layer.getLayer())

func toNextRune(mana: Mana):
	var mana1 = mana
	var mana2 = mana.clone()

	mana1.manaAmount = mana1.manaAmount * self.splitRatio
	mana2.manaAmount = mana2.manaAmount * (1 - self.splitRatio)

	mana1.manaStrength = mana1.manaStrength * self.splitRatio
	mana2.manaStrength = mana2.manaStrength * (1 - self.splitRatio)

	mana2 = self.applyCost(mana2)
	var rune_pos = self.layer.getRuneCoordinate(self.layer.runes.find(self))
	var nextLayer = self.nextLayerRune.layer
	var next_rune_pos = nextLayer.getRuneCoordinate(nextLayer.runes.find(self.nextLayerRune))
	var distance = rune_pos.distance_to(next_rune_pos)
	mana2.changeManaAmount(-distance * RESISTANCE_MODIFIER)
	if mana2.manaAmount <= 0 or self.nextLayerRune == null:
		layer.parentCircle.releaseMana(mana2)
	else:
		self.nextLayerRune.enterRune(mana2)

	super.toNextRune(mana1)
