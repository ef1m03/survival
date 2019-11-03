local serverTable = {
	spawns = {
		["Las Venturas"] = {
			{1784.00452, 1732.15063, 6.73438},
			{1782.00452, 1732.15063, 6.73438},
			{1788.00452, 1732.15063, 6.73438},
		},
		["Los Santos"] = {
			{1928.69299, -1483.50647, 10.82813},
			{1929.69299, -1486.50647, 10.82813},
			{1925.69299, -1480.50647, 10.82813},
		},
		["San Fierro"] = {
			{-2098.34790, 117.77132, 35.32031},
			{-2094.34790, 117.77132, 35.32031},
			{-2091.34790, 117.77132, 35.32031},
		},
	},
	welcome_msg = {
		"#FFFFFFДобро пожаловать на сервер #7CFC00День 'Z'#9ACD32!",
		"#FFFFFFЭто закрытая #7CFC00ALFA #FFFFFFстадия сервера, о багах/ошибках сервера сообщать в группу.",
		"#FFFFFFГруппа сервера: #7CFC00vk.com/survivalday_z",
		"#FFFFFFПриятной игры!",
	},
}

-- Internal MTA events

function onPlayerJoin()
	-- Random spawn

	local available_city = {"Las Venturas", "Los Santos", "San Fierro"}
	local random_number = available_city[math.random(1, #available_city)]
	local selected_city = serverTable.spawns[random_number]
	selected_city = selected_city[math.random(1, #selected_city)]

	setTimer(spawnPlayer, 2000, 1, source, selected_city[1], selected_city[2], selected_city[3])
	setTimer(setCameraTarget, 2000, 1, source, source)
	setTimer(fadeCamera, 2000, 1, source, true, 2)

	-- Disable all useless shit

	setPlayerHudComponentVisible(source, "all", false)
end
addEventHandler("onPlayerJoin", getRootElement(), onPlayerJoin)

--

function onPlayerLogin(previousacc, currentacc)
	local savedPos = getAccountData(currentacc, "quitPos")
	if savedPos then
		savedPos = fromJSON(savedPos)
		setTimer(spawnPlayer, 2000, 1, source, savedPos[1], savedPos[2], savedPos[3])
		setTimer(setCameraTarget, 2000, 1, source, source)
	else
		setTimer(spawnPlayer, 2000, 1, source, 0, 0, 10)
		setTimer(setCameraTarget, 2000, 1, source, source)
	end

	-- Welcome msg

	for i = 1, #serverTable.welcome_msg do
		local msg = serverTable.welcome_msg[i]
		outputChatBox(msg, source, 255, 255, 255, true)
	end

	-- Fade camera

	setTimer(fadeCamera, 2000, 1, source, true, 2)
end
addEventHandler("onPlayerLogin", getRootElement(), onPlayerLogin)

--

function onPlayerWasted(ammo, attacker, weapon, bodypart)
	-- Spawn in closest place

	local zoneName = getElementZoneName(source, true)
	outputChatBox(zoneName)
	local selected_city = serverTable.spawns[zoneName]
	selected_city = selected_city[math.random(1, #selected_city)]

	setTimer(spawnPlayer, 2000, 1, source, selected_city[1], selected_city[2], selected_city[3])
	setTimer(setCameraTarget, 2000, 1, source, source)
end
addEventHandler("onPlayerWasted", getRootElement(), onPlayerWasted)

--

function onPlayerQuit(quitType, reason, responsibleElement)
	local player_account = getPlayerAccount(source)
	if player_account then
		if not isGuestAccount(player_account) then
			local x, y, z = getElementPosition(source)
			local playerPos = {x, y, z}

			playerPos = toJSON(playerPos)
			setAccountData(player_account, "quitPos", playerPos)
		end
	end
end
addEventHandler("onPlayerQuit", getRootElement(), onPlayerQuit)