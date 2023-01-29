local isRagdoll = false
RegisterNetEvent('Drago_menuperso:ragdoll')
AddEventHandler('Drago_menuperso:ragdoll',function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    isRagdoll = not isRagdoll
    if not IsPedInVehicle(playerPed, vehicle, false) then
        while isRagdoll do
            Wait(0)
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, false, false, false)
        end
    end
end)