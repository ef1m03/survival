inventory = {}

inventory["Main window"] = guiCreateWindow(0.15, 0.28, 0.72, 0.63, "", true)
inventory["Suicide button"] = guiCreateButton(0.94, 0.95, 0.02, 0.06, "", true, inventory["Main window"])
inventory["Loot label"] = guiCreateLabel(0.06, 0.05, 0.34, 0.09, "Loot", true, inventory["Main window"])
inventory["Inventory label"] = guiCreateLabel(0.60, 0.05, 0.34, 0.09, "Inventory", true, inventory["Main window"])

inventory["Loot gridlist"] = guiCreateGridList(0.03, 0.10, 0.39, 0.83, true, inventory["Main window"])
inventory["Loot column"] = guiGridListAddColumn(inventory["Loot gridlist"], "Loot", 0.7)
inventory["Loot column amount"] = guiGridListAddColumn(inventory["Loot gridlist"], "", 0.2)

inventory["Inventory gridlist"] = guiCreateGridList(0.57, 0.11, 0.39, 0.83, true, inventory["Main window"])
inventory["Inventory column"] = guiGridListAddColumn(inventory["Inventory gridlist"], "Inventory", 0.7)
inventory["Inventory column amount"] = guiGridListAddColumn(inventory["Inventory gridlist"], "", 0.2)

-- Settings

guiLabelSetHorizontalAlign(inventory["Loot label"], "center")
guiSetFont(inventory["Loot label"], "sans-small")

guiLabelSetHorizontalAlign(inventory["Inventory label"], "center")
guiSetFont(inventory["Inventory label"], "sans-small")

guiSetVisible(inventory["Main window"], false)