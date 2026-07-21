-- =============================================
-- YGZ MENU - VERSÃO CORRIGIDA E ESTÁVEL
-- =============================================

if not LPH_OBFUSCATED then
    LPH_JIT = function(...) return ... end
    LPH_NO_VIRTUALIZE = function(...) return ... end
end

function isProtected()
    return GetResourceState('PL_PROTECT') == 'started'
        or GetResourceState('ThnAC') == 'started'
        or GetResourceState('likizao_ac') == 'started'
        or GetResourceState('MQCU') == 'started'
end

if not debugPrint then
    debugPrint = function(...) return end
end

local ScreenX, ScreenY = GetActiveScreenResolution()
local menuWidth, menuHeight = 843, 600

local YGZ = {
    x = math.ceil(ScreenX / 2 - menuWidth / 2),
    y = math.ceil(ScreenY / 2 - menuHeight / 2),
    width = menuWidth,
    height = menuHeight,
    screenW = ScreenX,
    screenH = ScreenY,
    RenderMenu = true,
    showMenu = true,
    menuLoaded = false,

    SelectedPlayer = nil,
    SelectedVehicle = nil,

    scroll = {},
    sliders = {},
    comboboxes = {},
    key_binds = {},
    vars = { cooldown = {} },
    toggles = {},
    inputs = {},
    savedPositions = {},
    animColors = {},

    MenuKey = { key = 157, Text = '1' },

    currentTheme = 'default',
    themeNames = {'default', 'blue', 'green', 'purple', 'orange', 'pink'},
    currentThemeIndex = 1,

    groupcity = "NENHUM",
    noclipEstilo = 1,
}

-- ==================== FUNÇÕES BÁSICAS (UI) ====================
-- (Coloque aqui as funções DrawText, DrawRoundedRect, Window, Button, CheckBox, etc. do seu original)

-- ==================== LOOP PRINCIPAL ====================
Citizen.CreateThread(function()
    while YGZ.RenderMenu do
        if YGZ.menuLoaded and IsDisabledControlJustPressed(0, YGZ.MenuKey.key) then
            YGZ.showMenu = not YGZ.showMenu
        end

        if YGZ.menuLoaded and not IsPauseMenuActive() and YGZ.showMenu then
            YGZ:Window()

            YGZ:Tab('Jogador')
            YGZ:Tab('Armas')
            YGZ:Tab('Veículos')
            YGZ:Tab('Online')
            YGZ:Tab('Visual')
            YGZ:Tab('Exploits')
            YGZ:Tab('Config')

            -- Aqui você coloca os elementos de cada aba (CheckBox, Button, etc.)
            -- Exemplo para Jogador:
            if YGZ.tabs.active == 'Jogador' then
                YGZ:SubTab('Jogador')
                if YGZ.subtabs.active == 'Jogador' then
                    YGZ:TitleBox('Jogador', 'Outros')
                    YGZ:CheckBoxWithBind('Godmode', 'Godmode', function(state) 
                        -- Código do Godmode
                    end, 'right')
                end
            end
        end
        Wait(0)
    end
end)

print('^2[YGZ Menu] ^1Versão Corrigida Carregada!')
