RegisterNetEvent('Drago_menuperso:crossarms')
AddEventHandler('Drago_menuperso:crossarms', function()
    local dict = "amb@world_human_hang_out_street@female_arms_crossed@base"
    
    local lPed = GetPlayerPed(-1)
	RequestAnimDict(dict)
	if crossarms then
		if DoesEntityExist(lPed) then
			Citizen.CreateThread(function()
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end

				if crossarms then
					crossarms = false
					ClearPedSecondaryTask(lPed)
				end
			end)
		end
	else
		if DoesEntityExist(lPed) then
			Citizen.CreateThread(function()
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end

				if not crossarms then
					crossarms = true
					TaskPlayAnim(lPed, dict, "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
				end
			end)
		end
	end
end)