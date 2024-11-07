extends Rune

class_name MergeRune

func _init(rune_name: String, rune_description: String, rune_symbol: String, rune_level: int, rune_capacity: int):
    super._init(rune_name, rune_description, rune_symbol, rune_level)
    self.type = RuneType.MERGE
    self.flowCapacity = rune_capacity