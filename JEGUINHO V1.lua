-- =============================================
-- SUPER TACO + ARREMESSO DE VEÍCULOS
-- Bind: Z
-- =============================================

local ToggleSuperTaco = false
local lastSwing = 0

print("^2[Super Taco] Injetado! Pressione Z para ligar/desligar.")

-- Thread Principal
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if ToggleSuperTaco then
            local ped = PlayerPedId()
            local batHash = GetHashKey('WEAPON_BAT')

            if GetSelectedPedWeapon(ped) == batHash then
                SetPlayerMeleeWeaponDamageModifier(PlayerId(), 20.0)
                SetWeaponDamageModifier(batHash, 999999.0)

                if IsPedPerformingMeleeAction(ped) and (GetGameTimer() - lastSwing > 450) then
                    lastSwing = GetGameTimer()

                    local hit, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())

                    if hit and DoesEntityExist(entity) then
                        local forward = GetEntityForwardVector(ped)

                        if IsEntityAPed(entity) then
                            SetEntityVelocity(entity, forward.x * 30.0, forward.y * 30.0, 14.0)
                            SetPedToRagdoll(entity, 2000, 2000, 0, true, true, false)
                            local coords = GetEntityCoords(entity)
                            AddExplosion(coords.x, coords.y, coords.z + 0.5, 0, 1.0, true, false, 1.0)
                            print("^3[Super Taco] Ped atingido")

                        elseif IsEntityAVehicle(entity) then
                            NetworkRequestControlOfEntity(entity)
                            local force = 75.0
                            SetEntityVelocity(entity, forward.x * force, forward.y * force, 25.0)
                            ApplyForceToEntity(entity, 1, forward.x * 55, forward.y * 55, 40.0, 0, 0, 0, 0, false, true, true, false, true)
                            local coords = GetEntityCoords(entity)
                            AddExplosion(coords.x, coords.y, coords.z + 0.5, 0, 1.0, true, false, 1.0)
                            print("^3[Super Taco] Veículo arremessado!")
                        end
                    end
                end
            end
        end
    end
end)

-- Bind Z
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 20) then -- Z
            ToggleSuperTaco = not ToggleSuperTaco
            if ToggleSuperTaco then
                Notify("~g~Super Taco ATIVADO ~w~(~y~Z~w~)")
                print("^2[Super Taco] ATIVADO")
            else
                Notify("~r~Super Taco DESATIVADO")
                print("^1[Super Taco] DESATIVADO")
            end
        end
    end
end)

function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
