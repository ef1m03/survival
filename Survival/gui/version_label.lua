local server_label = {}

server_label["Label"] = guiCreateLabel(1, 1, 0.3, 0.3, "Survival v0.0.1", true)
guiSetSize(server_label["Label"], guiLabelGetTextExtent(server_label["Label"]), guiLabelGetFontHeight(server_label["Label"]), false)

--

local x, y = guiGetSize(server_label["Label"], true)
guiSetPosition(server_label["Label"], 0.998 - x, 1 - y * 1.8, true)
guiSetAlpha(server_label["Label"], 0.5)

--

x, y = nil, nil