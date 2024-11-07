extends Rune

class_name ShiftRune

@export
var shiftCost: float

func _init(rune_name: String, rune_description: String, rune_symbol: String, rune_level: int, rune_cost: float):
	super._init(rune_name, rune_description, rune_symbol, rune_level)
	self.type = RuneType.SHIFT
	self.shiftCost = rune_cost

func update_data():
	if self.layer == null:
		return
	if self.layer.parentCircle == null:
		return
	var next_layer_index = self.layer.getLayer() + 1
	if self.layer.parentCircle.layers.size() <= next_layer_index:
		return
	self.nextRune = self.layer.getClosestRuneInOtherLayer(self.layer.runes.find(self), next_layer_index)

func applyCost(mana: Mana) -> Mana:
	mana.changeManaAmount(-self.shiftCost)
	return mana

func toNextRune(mana: Mana):
	mana = self.applyCost(mana)
	super.toNextRune(mana)
