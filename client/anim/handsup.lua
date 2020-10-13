local canHandsUp = true
local handsup = false
local GUI							= {}
GUI.Time							= 0

AddEventHandler("handsup:toggle", function(param)
	canHandsUp = param
end)

RegisterNetEvent('Drago_menuperso:handsup')
AddEventHandler('Drago_menuperso:handsup',function()
	local lPed = GetPlayerPed(-1)
	RequestAnimDict("random@mugging3")
	if handsup then
		if DoesEntityExist(lPed) then
			Citizen.CreateThread(function()
				RequestAnimDict("random@mugging3")
				while not HasAnimDictLoaded("random@mugging3") do
					Citizen.Wait(100)
				end

				if handsup then
					handsup = false
					ClearPedSecondaryTask(lPed)
				end
			end)
		end
	else
		if DoesEntityExist(lPed) then
			Citizen.CreateThread(function()
				RequestAnimDict("random@mugging3")
				while not HasAnimDictLoaded("random@mugging3") do
					Citizen.Wait(100)
				end

				if not handsup then
					handsup = true
					TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
				end
			end)
		end
	end
end)