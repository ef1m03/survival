local string_gsub = string.gsub 
local string_len = string.len 
local table_concat = table.concat 
local anti_flood = {}

--

local chatConfig = { -- key, keystate, func, arg, admin func
	{"x", "down", "chatbox", "World", false},
	{"u", "down", "chatbox", "Admin", true},
}

-- bindKey(player, key, state, func, func_arg)

function onPlayerLogin(prevacc, currentacc)
	local account_name = getAccountName(currentacc)
	if account_name then
		for i = 1, #chatConfig do
			local key = chatConfig[i][1]
			local state = chatConfig[i][2]
			local func = chatConfig[i][3]
			local arg = chatConfig[i][4]
			local admin_func = chatConfig[i][5]

			if admin_func and not isObjectInACLGroup("user."..account_name, aclGetGroup("Admin")) then
				return
			end

			bindKey(source, key, state, func, arg)
		end
	end
end
addEventHandler("onPlayerLogin", getRootElement(), onPlayerLogin)

--

function onResourceStart()
	local players = getElementsByType("player")
	for i = 1, #players do
		local player = players[i]
		if player then
			local player_acc = getPlayerAccount(player)
			if player_acc and not isGuestAccount(player_acc) then
				local account_name = getAccountName(player_acc)
				for i = 1, #chatConfig do
					local key = chatConfig[i][1]
					local state = chatConfig[i][2]
					local func = chatConfig[i][3]
					local arg = chatConfig[i][4]
					local admin_func = chatConfig[i][5]
					if admin_func and not isObjectInACLGroup("user."..account_name, aclGetGroup("Admin")) then
						return
					end

					bindKey(player, key, state, func, arg)
				end
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, onResourceStart)

--

function onPlayerChat(msg, msgType)
	if msgType == 1 or msgType == 2 then
		cancelEvent()
	end

	local msgLen = string_len(msg)
	if msgLen == 0 or msgLen > 127 then
		return
	end

	if msgType == 0 then
		local x, y, z = getElementPosition(source)
		local players_in_range = getElementsWithinRange(x, y, z, 30, "player")
		if #players_in_range > 1 then
			outputChatBox(""..string_gsub((getPlayerName(source)..": "..msg), "#%x%x%x%x%x%x", ""), players_in_range, 211, 211, 211, true)
		end
	end
end
addEventHandler("onPlayerChat", getRootElement(), onPlayerChat)

--

function onPlayerGlobalChat(player, cmd, ...)
	if player and cmd then
		local message = {...}
		message = table_concat(message, " ")

		local text_length = string_len(message)
		if text_length == 0 or text_length > 127 then
			return
		end

		outputChatBox("#7CFC00[Мир] "..string_gsub((getPlayerName(player)..": "..message), "#%x%x%x%x%x%x", "#FFFFFF"), getRootElement(), 211, 211, 211, true)
	end
end
addCommandHandler("World", onPlayerGlobalChat)

--

function onPlayerAdminChat(player, cmd, ...)
	if player and cmd then
		local message = {...}
		message = table_concat(message, " ")

		local text_length = string_len(message)
		if text_length == 0 or text_length > 127 then
			return
		end

	end
end
addCommandHandler("Admin", onPlayerAdminChat)

-- Anti-flood

function onPlayerCommand(command)
	if anti_flood[source] then
		if getTickCount() - anti_flood[source] > 700 then
			anti_flood[source] = getTickCount()
		else
			cancelEvent()
		end
	else
		anti_flood[source] = getTickCount()
	end

	--[[if block_commands[command] then
		cancelEvent()
	end]]
end
addEventHandler("onPlayerCommand", getRootElement(), onPlayerCommand)

--

function onPlayerQuit(quitType, reason, responsibleElement)
	-- Clear data

	if anti_flood[source] then
		anti_flood[source] = nil
	end
end
addEventHandler("onPlayerQuit", getRootElement(), onPlayerQuit)