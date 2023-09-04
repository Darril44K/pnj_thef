local playerTdd = PlayerPedId()
GiveDelayedWeaponToPed(playerTdd, "weapon_pistol", 100, false,true)
ClearPlayerWantedLevel(playerTdd)

Citizen.CreateThread(function()
    local player = PlayerId()
    local playerPed = PlayerPedId()
    local lastEntity
    while true do
        Wait(1)
        local isAimingOnEntity, EntityHandle = GetEntityPlayerIsFreeAimingAt(player)
        local playerWeapon = GetSelectedPedWeapon(playerPed)
        if(isAimingOnEntity and GetWeaponDamageType(playerWeapon) and GetEntityType(EntityHandle)) then
            print("premier vehicule "..EntityHandle)
            lastEntity = EntityHandle
            local timeout = 1000
            repeat
                if (not isAimingOnEntity or (lastEntity~=EntityHandle and lastEntity~=nil)) then
                    return
                end
                timeout = timeout - 100
                Wait(100)
            until timeout <= 0
            SetVehicleMaxSpeed(EntityHandle, 0.0)
            RequestAnimDict("anim@mp_player_intincarsurrenderbodhi@ps@")
            TaskPlayAnim(EntityHandle,"anim@mp_player_intincarsurrenderbodhi@ps@","idle_a",1.0,-1.0, 5000, 1, 1, true, true, true)
            local isAimingOnEntitySecond, EntityHandleSecond = GetEntityPlayerIsFreeAimingAt(player)
            if(isAimingOnEntitySecond and GetWeaponDamageType(playerWeapon) and GetEntityType(EntityHandleSecond)) then
                SetVehicleMaxSpeed(EntityHandleSecond, 0.0)
                RequestAnimDict("anim@mp_player_intincarsurrenderbodhi@ps@")
                TaskPlayAnim(EntityHandleSecond,"anim@mp_player_intincarsurrenderbodhi@ps@","idle_a",1.0,-1.0, 5000, 1, 1, true, true, true)
            end
        end
    end
end)