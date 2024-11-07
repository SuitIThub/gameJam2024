extends Node

class_name Rune

enum RuneType {NONE, EFFECT, SHIFT, SPLIT, MERGE}

const RESISTANCE_MODIFIER = 1

var uid: String
var type: RuneType
var title: String
var description: String
var symbol: String
var level: int
var nextRune: Rune = null
@export var manaCache: Mana = Mana.new(0)
var flowCapacity: int = 1
var layer: ManaLayer = null
var enteredMana: int = 0

func _init(rune_name: String, rune_description: String, rune_symbol: String, rune_level: int):
    self.uid = Helper.generate_unique_id()
    self.type = RuneType.NONE
    self.title = rune_name
    self.description = rune_description
    self.symbol = rune_symbol
    self.level = rune_level

func update_data():
    if layer == null:
        return
    var next_rune_index = self.layer.runes.find(self) + 1
    if next_rune_index >= self.layer.runes.size():
        next_rune_index = 0
    self.nextRune = self.layer.runes[next_rune_index]

func applyEffect(mana: Mana) -> Mana:
    mana.applyMana(self.manaCache)
    return mana

func toNextRune(mana: Mana):
    mana = applyResistance(mana)
    if mana.manaAmount <= 0 or self.nextRune == null:
        layer.parentCircle.releaseMana(mana)
    else:
        self.nextRune.enterRune(mana)

func applyResistance(mana: Mana) -> Mana:
    var rune_pos = self.layer.getRuneCoordinate(self.layer.runes.find(self))
    var next_rune_pos = self.layer.getRuneCoordinate(self.layer.runes.find(self.nextRune))
    var distance = rune_pos.distance_to(next_rune_pos)

    mana.changeManaAmount(-distance * RESISTANCE_MODIFIER)
    return mana

func getLevel() -> int:
    return self.level

func increaseLevel(delta: int = 1):
    self.level += delta

func enterRune(mana: Mana):
    # print("Entering rune: " + self.title + ", Layer: " + str(self.layer.getLayer()) + ", Index: " + str(self.layer.runes.find(self)))
    self.enteredMana += 1
    if enteredMana > flowCapacity:
        layer.parentCircle.releaseMana(mana)
    else:
        mana = applyEffect(mana)
        self.manaCache = mana
        toNextRune(mana)