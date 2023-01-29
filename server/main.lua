---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by dragonir.
--- DateTime: 30/08/2020 21:35
---

function getMaximumGrade(jobname)
    local result = MySQL.Sync.fetchAll("SELECT * FROM job_grades WHERE job_name=@jobname  ORDER BY `grade` DESC ;", {
        ['@jobname'] = jobname
    })
    if result[1] ~= nil then
        return result[1].grade
    end
    return nil
end

---Player data
ESX.RegisterServerCallback('Drago_menuperso:getName', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function() end)
    local playerInfo = {
        firstname = result[1].firstname,
        lastname = result[1].lastname,
        fullname = result[1].firstname..' '..result[1].lastname,
        dob = result[1].dateofbirth,
        height = result[1].height,
        sex = result[1].sex
    }
    cb(playerInfo)
end)

ESX.RegisterServerCallback('Drago_menuperso:getLicense', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerLicense = {}
    MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        for i=1, #result do
            table.insert(playerLicense, result[i])
        end
        cb(playerLicense)
    end)
end)

ESX.RegisterServerCallback('Drago_menuperso:getPlayerWeight', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getWeight())
end)

ESX.RegisterServerCallback('Drago_menuperso:Bill_getBills', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local bills = {}

    MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        for i = 1, #result, 1 do
            table.insert(bills, {
                id = result[i].id,
                label = result[i].label,
                amount = result[i].amount
            })
        end
        cb(bills)
    end)
end)

ESX.RegisterServerCallback('Drago_menuperso:getKey', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local key = {}

    MySQL.Async.fetchAll('SELECT * FROM open_car WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        for i=1, #result, 1 do
            table.insert(key, {
                id = result[i].id,
                label = result[i].label,
                value = result[i].value
            })
        end
        cb(key)
    end)
end)

ESX.RegisterServerCallback('Drago_menuperso:getSim', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerSim = {}
    MySQL.Async.fetchAll('SELECT * FROM user_sim WHERE owner = @identifier', {['@identifier'] = xPlayer.identifier}, function(result)
        for _,v in pairs(result) do
            table.insert(playerSim, {
                num = v.number,
                label = v.label
            })
        end
        cb(playerSim)
    end)
end)

RegisterServerEvent('Drago_menuperso:updatePhoneNumber')
AddEventHandler('Drago_menuperso:updatePhoneNumber', function(number)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE users SET phone_number=@number WHERE identifier=@identifier', {['@number'] = number, ['@identifier'] = xPlayer.identifier})
end)

RegisterServerEvent('Drago_menuperso:renameSim')
AddEventHandler('Drago_menuperso:renameSim', function(sim, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('UPDATE user_sim SET label=@label WHERE number=@number AND owner=@identifier', {
        ['@label'] = label,
        ['@number'] = sim,
        ['@identifier'] = xPlayer.identifier
    })
    xPlayer.showNotification(("La carte au numéro ~y~%s~s~ s'appel maintenant ~b~%s~s~"):format(sim, label))
end)

RegisterServerEvent('Drago_menuperso:dropSim')
AddEventHandler('Drago_menuperso:dropSim', function(sim)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('DELETE FROM user_sim WHERE number=@number AND owner=@identifier', {
        ['@number'] = sim,
        ['@identifier'] = xPlayer.identifier
    })
    xPlayer.showNotification(("Vous avez ~r~jeté~s~ la carte sim ~y~%s~s~"):format(sim))
end)

ESX.RegisterServerCallback('Drago_menuperso:getActivePlayer', function(_, cb)
    local playersConnected = {}
    for _,v in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(v)
        table.insert(playersConnected, {
            name = xPlayer.name,
            id = xPlayer.source
        })
    end
    cb(playersConnected)
end)

RegisterServerEvent('Drago_menuperso:renameItem')
AddEventHandler('Drago_menuperso:renameItem', function(item, newLabel)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.editItemData(item, 'label', newLabel)
end)

---Boss
RegisterServerEvent('Drago_menuperso:promouvoirplayer')
AddEventHandler('Drago_menuperso:promouvoirplayer', function(target)

    local _source = source

    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    local maximumgrade = tonumber(getMaximumGrade(sourceXPlayer.job.name)) -1

    if(targetXPlayer.job.grade == maximumgrade) or sourceXPlayer.job.grade == targetXPlayer.job.grade then
        TriggerClientEvent('esx:showNotification', _source, "Vous devez demander une autorisation du ~r~Gouvernement~w~.")
    else
        if(sourceXPlayer.job.name == targetXPlayer.job.name)then

            local grade = tonumber(targetXPlayer.job.grade) + 1
            local job = targetXPlayer.job.name

            targetXPlayer.setJob(job, grade)

            TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~promu "..targetXPlayer.name.."~w~.")
            TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~promu par ".. sourceXPlayer.name.."~w~.")
        else
            TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
        end
    end
end)

RegisterServerEvent('Drago_menuperso:destituerplayer')
AddEventHandler('Drago_menuperso:destituerplayer', function(target)

    local _source = source

    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if(targetXPlayer.job.grade == 0)then
        TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~r~rétrograder~w~ davantage.")
    else
        if(sourceXPlayer.job.name == targetXPlayer.job.name) or sourceXPlayer.job.grade == targetXPlayer.job.grade then

            local grade = tonumber(targetXPlayer.job.grade) - 1
            local job = targetXPlayer.job.name

            targetXPlayer.setJob(job, grade)

            TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~rétrogradé "..targetXPlayer.name.."~w~.")
            TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~r~rétrogradé par ".. sourceXPlayer.name.."~w~.")
        else
            TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
        end
    end
end)

RegisterServerEvent('Drago_menuperso:recruterplayer')
AddEventHandler('Drago_menuperso:recruterplayer', function(target, job, grade)

    local _source = source

    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    targetXPlayer.setJob(job, grade)

    TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~recruté "..targetXPlayer.name.."~w~.")
    TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~embauché par ".. sourceXPlayer.name.."~w~.")

end)

RegisterServerEvent('Drago_menuperso:virerplayer')
AddEventHandler('Drago_menuperso:virerplayer', function(target)

    local _source = source

    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    local job = "unemployed"
    local grade = "0"

    if(sourceXPlayer.job.name == targetXPlayer.job.name) or sourceXPlayer.job.grade == targetXPlayer.job.grade or sourceXPlayer.job.grade < targetXPlayer.job.grade then
        targetXPlayer.setJob(job, grade)

        TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré "..targetXPlayer.name.."~w~.")
        TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~viré par ".. sourceXPlayer.name.."~w~.")
    else

        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

    end

end)

---Boss2
RegisterServerEvent('Drago_menuperso:promouvoirplayer2')
AddEventHandler('Drago_menuperso:promouvoirplayer2', function(target)

    local _source = source

    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    local maximumgrade = tonumber(getMaximumGrade(sourceXPlayer.gang.name)) -1

    if(targetXPlayer.gang.grade_name == maximumgrade)then
        TriggerClientEvent('esx:showNotification', _source, "Vous devez demander une autorisation du ~r~Gouvernement~w~.")
    else
        if(sourceXPlayer.gang.name == targetXPlayer.gang.name)then

            local grade = tonumber(targetXPlayer.gang.grade_name) + 1
            local job = targetXPlayer.gang.name

            targetXPlayer.setOrg(job, grade)

            TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~promu "..targetXPlayer.name.."~w~.")
            TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~promu par ".. sourceXPlayer.name.."~w~.")

        else
            TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

        end

    end

end)

RegisterServerEvent('Drago_menuperso:destituerplayer2')
AddEventHandler('Drago_menuperso:destituerplayer2', function(target)

    local _source = source

    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if(targetXPlayer.gang.grade_name == 0)then
        TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~r~rétrograder~w~ davantage.")
    else
        if(sourceXPlayer.gang.name == targetXPlayer.gang.name)then

            local grade = tonumber(targetXPlayer.gang.grade_name) - 1
            local job = targetXPlayer.gang.name

            targetXPlayer.setOrg(job, grade)

            TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~rétrogradé "..targetXPlayer.name.."~w~.")
            TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~r~rétrogradé par ".. sourceXPlayer.name.."~w~.")

        else
            TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

        end

    end

end)

RegisterServerEvent('Drago_menuperso:recruterplayer2')
AddEventHandler('Drago_menuperso:recruterplayer2', function(target, job, grade)

    local _source = source

    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    targetXPlayer.setOrg(job, grade)

    TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~recruté "..targetXPlayer.name.."~w~.")
    TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~recruté par ".. sourceXPlayer.name.."~w~.")

end)

RegisterServerEvent('Drago_menuperso:virerplayer2')
AddEventHandler('Drago_menuperso:virerplayer2', function(target)

    local _source = source

    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    local job = "unemployed2"
    local grade = "0"

    if(sourceXPlayer.gang.name == targetXPlayer.gang.name)then
        targetXPlayer.setOrg(job, grade)

        TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré "..targetXPlayer.name.."~w~.")
        TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~viré par ".. sourceXPlayer.name.."~w~.")
    else

        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

    end

end)

---Admin
ESX.RegisterServerCallback('Drago_menuperso:getUsergroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    cb(group)
end)
RegisterServerEvent("Drago_menuperso:giveCash")
AddEventHandler("Drago_menuperso:giveCash", function(money)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money

    xPlayer.addMoney((total))
    local item = ' $ d\'argent !'
    local message = 'Tu t\'es GIVE '
    TriggerClientEvent('esx:showNotification', _source, message.." "..total.." "..item)

end)

RegisterServerEvent("Drago_menuperso:giveBank")
AddEventHandler("Drago_menuperso:giveBank", function(money)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money

    xPlayer.addAccountMoney('bank', total)
    local item = ' $ en banque.'
    local message = 'Tu t\'es octroyé '
    TriggerClientEvent('esx:showNotification', _source, message.." "..total.." "..item)

end)

RegisterServerEvent("Drago_menuperso:giveDirtyMoney")
AddEventHandler("Drago_menuperso:giveDirtyMoney", function(money)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money

    xPlayer.addAccountMoney('black_money', total)
    local item = ' $ d\'argent sale.'
    local message = 'Tu t\'es octroyé '
    TriggerClientEvent('esx:showNotification', _source, message.." "..total.." "..item)

end)

ESX.RegisterServerCallback('Drago_menuperso:giveItem', function(source, cb, item, qty)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, qty)
    cb(true)
end)

ESX.RegisterServerCallback('Drago_menuperso:getJob', function(_, cb)
    local job = {}
    MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(result)
        for i=1, #result, 1 do
            table.insert(job, {
                name = result[i].name,
                label = result[i].label
            })
        end
        cb(job)
    end)
end)

ESX.RegisterServerCallback('Drago_menuperso:getGrade', function(_, cb, job)
    local grade = {}
    MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job_name', {
        ['@job_name'] = job
    }, function(result)
        for i=1, #result, 1 do
            table.insert(grade, {
                label = result[i].label,
                name = result[i].name,
                grade = result[i].grade
            })
        end
        cb(grade)
    end)
end)

RegisterServerEvent('Drago_menuperso:setjob')
AddEventHandler('Drago_menuperso:setjob', function(job, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setJob(job, grade)
end)

RegisterServerEvent('Drago_menuperso:setgang')
AddEventHandler('Drago_menuperso:setgang', function(job, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setJob2(job, grade)
end)

RegisterServerEvent('Drago_VehShop:setVehicleOwned')
AddEventHandler('Drago_VehShop:setVehicleOwned', function(vehicleProps)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',{
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function()
        TriggerClientEvent('esx:showNotification', _source, "le véhicule avec la plaque ~y~"..vehicleProps.plate.."~s~ est désormais à ~b~vous~s~")
    end)
end)

RegisterServerEvent('Drago_menuperso:sendMessage')
AddEventHandler('Drago_menuperso:sendMessage', function(player, message)
    TriggerClientEvent('RageUI:Radar', player, "Admin", "Message", message, 'CHAR_SOCIAL_CLUB', 2)
end)

RegisterServerEvent('Drago_menuperso:getId')
AddEventHandler('Drago_menuperso:getId', function(id)
    for _,v in ipairs(GetPlayerIdentifiers(id)) do
        TriggerClientEvent('RageUI:Popup', source, '~y~'..GetPlayerName(id) ..'~s~ '..v)
    end
end)

RegisterServerEvent('Drago_menuperso:heal')
AddEventHandler('Drago_menuperso:heal', function(id)
    TriggerClientEvent('esx_basicneeds:healPlayer', id)
end)

RegisterServerEvent('Drago_menuperso:Revive')
AddEventHandler('Drago_menuperso:Revive', function(playerid)
    local xTarget = ESX.GetPlayerFromId(playerid)
    if xTarget then
        xTarget.triggerEvent('esx_ambulancejob:revive')
    end
end)

RegisterServerEvent('Drago_menuperso:kill')
AddEventHandler('Drago_menuperso:kill', function(id)
    TriggerClientEvent('Drago_menuperso:kill', id)
end)

RegisterServerEvent('Drago_menuperso:summon')
AddEventHandler('Drago_menuperso:summon', function(playerId, coords)
    TriggerClientEvent('Drago_menuperso:summon', playerId, coords)
end)

RegisterServerEvent('Drago_menuperso:kick')
AddEventHandler('Drago_menuperso:kick', function(playerId, reason)
   DropPlayer(playerId, reason)
end)

---Save position
RegisterServerEvent("Drago_menuperso:SavePos")
AddEventHandler("Drago_menuperso:SavePos", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        ESX.SavePlayer(xPlayer, function()
            ESX.Players[_source] = nil
        end)
    end
end)