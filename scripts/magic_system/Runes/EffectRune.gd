extends Rune

class_name EffectRune

func _init(rune_name: String, rune_description: String, rune_symbol: String, rune_level: int, rune_effect: Mana):
    super._init(rune_name, rune_description, rune_symbol, rune_level)
    self.type = RuneType.EFFECT
    self.manaCache = rune_effect