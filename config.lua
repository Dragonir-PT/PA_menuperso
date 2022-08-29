local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config = {}

Config.TitlePlayerName = true --make the player name as title for all the menu

Config.ServerName = "CosmoRP" --if TitlePlayerName was false, the title was define from this

Config.doubleJob = true
Config.idCard = true
Config.useDoubleKey = true

Config.Shortcut = {
    job = true,
    animal = true, --for eden_animal
    mobile = true, --for GCPhone
    radio = true, --for rp-radio mumble
    lockCar = true, --for esx_vehiclelock
    trunk = true, --for Drago_VehChest
    voiceVolume = true, --for mumble-voip
    dpclothing = true --for dpclothing
}

Config.Locale = 'fr'

Config.GPS = {
    {label = 'Aucun', coords = nil},
    {label = 'LSPD', coords = vector2(-1110.31,-823.0)},
    {label = 'Garage Central', coords = vector2(254.49,-760.41)},
    {label = 'Hôpital', coords = vector2(308.66,-587.65)},
    {label = 'Benny\'s', coords = vector2(-216.07,-1318.92)},
    {label = 'Mécano', coords = vector2(-339.86,-157.29)},
    {label = 'Concess Auto', coords = vector2(-41.64,-1092.31)},
    {label = 'Concess Moto', coords = vector2(34.04,6490.88)},
    {label = 'Pôle emplois', coords = vector2(-265.0, -963.6)},
    {label = 'Auto école', coords = vector2(239.471,-1380.960)},
    {label = 'Sandy Shore', coords = vector2(1799.88, 3680.99)},
    {label = 'Paleto Bay', coords = vector2(-105.1, 6304.76)},
}

-- Lever les mains
Config.handsUP = {
    clavier = Keys["~"],
}
-- Pointer du doight
Config.pointing = {
    clavier = Keys["B"],
}
-- S'acroupir
Config.crouch = {
    clavier = Keys["LEFTCTRL"],
}
