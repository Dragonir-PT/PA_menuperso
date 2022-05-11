local crouched = false
local GUI							= {}
GUI.Time							= 0

RegisterNetEvent('Drago_menuperso:crouch')
AddEventHandler('Drago_menuperso:crouch', function()
    local ped = GetPlayerPed( -1 )
    local plyPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(plyPed,false)
    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
        if ( not IsPauseMenuActive() ) and not IsPedInVehicle(plyPed, vehicle, false) then
            RequestAnimSet( "move_ped_crouched" )
            while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do
                Citizen.Wait( 100 )
            end
            if crouched then
                ResetPedMovementClipset( ped, 0 )
                crouched = false
            elseif not crouched then
                SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                crouched = true
            end
            GUI.Time  = GetGameTimer()
        end
    end
end)