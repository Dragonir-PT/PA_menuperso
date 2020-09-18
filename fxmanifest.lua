fx_version 'bodacious'
game 'gta5'

client_scripts {
    "@RageUI/RMenu.lua",
    "@RageUI/menu/RageUI.lua",
    "@RageUI/menu/Menu.lua",
    "@RageUI/menu/MenuController.lua",

    "@RageUI/components/Audio.lua",
    "@RageUI/components/Enum.lua",
    "@RageUI/components/Keys.lua",
    "@RageUI/components/Rectangle.lua",
    "@RageUI/components/Sprite.lua",
    "@RageUI/components/Text.lua",
    "@RageUI/components/Visual.lua",

    "@RageUI/menu/elements/ItemsBadge.lua",
    "@RageUI/menu/elements/ItemsColour.lua",
    "@RageUI/menu/elements/PanelColour.lua",

    "@RageUI/menu/items/UIButton.lua",
    "@RageUI/menu/items/UICheckBox.lua",
    "@RageUI/menu/items/UIList.lua",

    "@RageUI/menu/items/UISeparator.lua",
    "@RageUI/menu/items/UISlider.lua",
    "@RageUI/menu/items/UISliderHeritage.lua",
    "@RageUI/menu/items/UISliderProgress.lua",

    "@RageUI/menu/panels/UIColourPanel.lua",
    "@RageUI/menu/panels/UIGridPanel.lua",
    "@RageUI/menu/panels/UIPercentagePanel.lua",
    "@RageUI/menu/panels/UIStatisticsPanel.lua",

    "@RageUI/menu/windows/UIHeritage.lua",
}

client_scripts {
    'config.lua',
    'client/main.lua',
    'client/anim/crossarms.lua',
    'client/anim/crouch.lua',
    'client/anim/handsup.lua',
    'client/anim/pointing.lua',
    'client/anim/ragdoll.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/main.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/img/image.png',
    'html/css/app.css',
    'html/scripts/app.js'
}