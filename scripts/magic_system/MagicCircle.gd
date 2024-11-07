extends Node

class_name MagicCircle

@export
var layers: Array[ManaLayer]

func _init():
    self.layers = []

func addLayer(layer: ManaLayer):
    layer.setCircle(self)
    self.layers.append(layer)

    self.update_data()

func setLayer(layer: ManaLayer, index: int):
    layer.setCircle(self)
    self.layers[index] = layer

    self.update_data()

func update_data():
    for layer in self.layers:
        layer.update_data()

func injectMana(mana: Mana):
    self.layers[0].runes[0].enterRune(mana)

func releaseMana(mana: Mana):
    print(str(mana))
    pass