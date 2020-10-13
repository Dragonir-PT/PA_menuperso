RegisterNetEvent('Drago_menuperso:ragdoll')
AddEventHandler('Drago_menuperso:ragdoll',function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    if not IsPedInVehicle(playerPed, vehicle, false) then
        SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, false, false, false)
    end
end)