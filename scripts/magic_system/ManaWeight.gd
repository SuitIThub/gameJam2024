class_name ManaWeight

var resistance: float
var nextRune: Rune

func _init(startingResistance):
    self.resistance = startingResistance
    self.nextRune = null

func applyResistance(mana: Mana) -> Mana:
    mana.changeManaAmount(-self.resistance)
    return mana

func toNextRune(mana: Mana):
    mana = applyResistance(mana)