local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local key = require('vkeys')
local imgui = require "imgui"
local wm = require 'lib.windows.message'
local razdacha = imgui.ImInt(0)
imgui.ToggleButton = require('imgui_addons').ToggleButton
imgui.HotKey = require('imgui_addons').HotKey
imgui.Spinner = require('imgui_addons').Spinner
imgui.BufferingBar = require('imgui_addons').BufferingBar
local razdacha_zapusk = imgui.ImInt(0)
local sw, sh = getScreenResolution()
local sampev = require 'lib.samp.events'
local main_window_state = imgui.ImBool(false)
local second_window_state = imgui.ImBool(false)
local third_window_state = imgui.ImBool(false)
local dialogArr = {'������', '���������� ��', '������� ������'}
local dialogStr = ''
local dialogArrr = {'Rifa', 'Vagos', 'Aztecas', 'Groove', 'Ballas'}
local dialogStrr = ''
local dialogGoss = {'���', '���', '���', '�����', '���', '����', '��', '���', '���'}
local dialogGos = ''
local dialogMaff = {'LCN', 'Yakudza', '������� �����', '�������'}
local dialogMaf = ''
local pensTable = [[���������� ����:
    ��
    ����
    ����
    ����������� �������
    ����������� �������������
    ���������� ������
    ����� �������������
    ���� � /gov, /d, /vad, /ad
    �������� �: ������� ���
    ���������� ���� � /gov, ��� /d

    ���������� ��������:
    ������������� ����� � ���������
    ������� ��������
    ������������� ����
    ������������� ����� � ���������
    ����� �� ���������
    ����������� �������
    ����������� ������

    ������ ���������:
    ��
    ��
    ��
    ��
    ��
    nonRP
    ������
    DM �� 3-�� �������
    ���� �� �������
    ����

    ������ �����:
    ����� �� ��������
    �������� ���� ��� ��������

    ���������� �������:
    ��������
    ������
    ���������
]]

local timesTable = [[
    �����
    10 �����
    5 �����
    10 �����
    15 �����
    15 �����
    60 �����
    15 �����
    10 �����
    5 �����
    10 �����


    5 ����
    60 �����
    �������� + banip
    5 ����
    1 ����
    60 �����
    60 ����� -> 2 ��� ����


    10 �����
    10 �����
    10 �����
    10 �����
    5 �����
    10 �����
    15 �����
    20 �����
    30 ����� + ����������
    60 �����


    1 ����
    1 ����


    5 �����
    10 �����
    30 �����
]]
local tableOfNew = {
    tableRes = imgui.ImBool(false),
    tempLeader = imgui.ImBool(false),
    AutoReport = imgui.ImBool(false),
    commandsAdmins = imgui.ImBool(false),
    addInBuffer = imgui.ImBuffer(128),
    carColor1 = imgui.ImInt(0),
    carColor2 = imgui.ImInt(0),
    givehp = imgui.ImInt(100),
    selectGun = imgui.ImInt(0),
    numberGunCreate = imgui.ImInt(0),
    intComboCar = imgui.ImInt(0),
    findText = imgui.ImBuffer(256),
    intChangedStatis = imgui.ImInt(0),
    inputIntChangedStatis = imgui.ImBuffer(10),
    answer_report = imgui.ImBuffer(526),
    inputAmmoBullets = imgui.ImBuffer(5),
    fdOnlinePlayer = imgui.ImInt(0),
    inputAdminId = imgui.ImBuffer(4)
}
local reports = {
    [0] = {
        nickname = '',
        id = -1,
        textP = ''
    }
}
local imBool = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local texter = imgui.ImBuffer(256)
local mep = imgui.ImInt(0)
local mepo = imgui.ImInt(0)
local prizemep = {u8'"������ �����"', u8'"������� �������"', u8'"�����"', u8'"������"', u8'"��������� ��������"', u8'"���������"', u8'"�������������"', u8'"�����"', u8'"PUBG"', u8'"�������"', u8'"��� ��� ������"', u8'"�����"'}
local prizemp = {u8'"�� �����"', u8'"�������"', u8'"VIP-CAR"', u8'"������� �� �����"', u8'"����� ���"', u8'����� �������� �� �����', u8'������', u8'������', u8'�����-�����', u8'��������'} 
local numbers = {'20+23', '34+78', '46*2' , '4*7', '52+56', '46+54', '20-8', '46-41', '7*8', '44/4' , '10+99', '412-413', '45-54', '7+5', '1+1', '888+111', '111+111'}
local word = {u8'04', u8'EKB', u8'MS', u8'Healme', u8'Kills', u8'LVL', u8'VIPCAR'}
local prizeon = {u8'"500 �������"', u8'"200 �������"', u8'"400 �������"', u8'500 ���������', u8'1337 ������� � ����������',  u8'"������ �������"', u8'"������� �� ������"', u8'"�������� ����������"', u8'"������ �� ������"', u8'"����� ������"', u8'"����� �������� �� �����"', u8'"1���"', u8'"����� ��� �� �����"', u8'"500 �������"', u8'"�������"', u8'"������"', u8'������', u8'��� �� VineWood', u8'��������� ����'}
require "lib.moonloader"
local dialogOtb = {'Ghetto', 'Goss', 'Mafia'}
local dialogOtbb = ''
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
update_state = false
local str_rand = {u8'����� � ������ �����', u8'���������� ��� �� ����� � ����� � ���������� �������', u8'��� � ������� �������', u8'���� � ������ ������ ������ ���. � ������ ��������', u8'�� ��� ����� � ����� �������', u8'������� ������ � ���������� ����������', u8"�������: ���� ����� ��� � ������ �����", u8"����� ����� �� �.Ζ ������� ������"}
local script_vers = 22
local script_vers_text = '1.22'
local update_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/update.ini'
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/EkbTool.luac'
local script_path = thisScript().path

local table_nazaz = {
    u8'��������',

    u8'�� = 10 �����',
    u8'�� = 10 �����',
    u8'�� = 5 �����',
    u8'�� = 5 �����',
    u8'������ = 15 �����',
    u8'���� ������ = 15 �����',
    u8'������������� ���-�������� �� ������� = 30 ����� + ����������',
    u8'���� = 60 �����',
    u8'���� �� �����/������ = warn -> /ban',
    u8'���� ���� = /iban',
    u8'���� � ��� = ��� �� 5 ����',
    u8'������ �� �����/������ = 5 ����� ��� -> warn',
    u8'NonRP = 10 �����',
    u8'��� �� ��������� = 1 ���� /ban',
    u8'�������������� ��� = 7 ���� /ban'
}

for _, str in ipairs(dialogArr) do
    dialogStr = dialogStr .. str .. "\n"
end

for _, str in ipairs(dialogArrr) do
    dialogStrr = dialogStrr .. str .. "\n"
end

for _, str in ipairs(dialogOtb) do
    dialogOtbb = dialogOtbb .. str .. "\n"
end

for _, str in ipairs(dialogGoss) do
    dialogGos = dialogGos .. str .. "\n"
end

for _, str in ipairs(dialogMaff) do
    dialogMaf = dialogMaf .. str .. "\n"
end

function refresh_current_report()
	table.remove(reports, 1)
end

function obnova(arg)
    sampShowDialog(212, "{FFFFFF}�{FF0000}�{000000}�{FA8072}�{8B0000}�{FF1493}�{006400}�{808000}�{FF4500}�{FF8C00}�", "�������� ��������! � /raz ������ �� ������� ������ ����� ������� �����������!\n{FFFFFF}���������� ����!\n{FF00FF}���! ������ �� ������� �������� � 10 ��� ������������ /OTV! /rhelp!\n� /nak ��������� ������� ���������!", "�������", '�������', 0)
end

function cmd_balalai2(arg)
    second_window_state.v = not second_window_state.v
    imgui.Process = second_window_state.v
end

function cmd_churka(arg)
    if #arg == 0 then
        sampShowDialog(13, '�������� �����', dialogStr, '�������', '�������', 2)
    end
end

function cmd_otbor(arg)
    if #arg == 0 then
        sampShowDialog(14, '�������� ���������', dialogOtbb, '���', '�������', 2)
    end
end

function cmd_spv(arg)
    if #arg == 0 then
        sampAddChatMessage('������� ID', -1)
    else
        lua_thread.create(function()
            sampSendChat('/slap ' .. arg)
            wait(1000)
            sampSendChat('/sp ' .. arg)
        end)
    end
end

function cmd_nakaz(arg)
    third_window_state.v = not third_window_state.v
    imgui.Process = third_window_state.v 
end

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function sampev.onServerMessage(color, text)
    if text:find('������ �� (.*)%[(%d+)%]: %{FFFFFF%}(.*)') then
        local Rnickname, Rid, RtextP = text:match('������ �� (.*)%[(%d+)%]: %{FFFFFF%}(.*)')
        reports[#reports + 1] = {nickname = Rnickname, id = Rid, textP = RtextP}
    end
    if #reports > 0 then
        if color == -6732289 then
            for k, v in pairs(reports) do
                if k == 1 then
                    if not tableOfNew.AutoReport.v then
                        if text:find('%[.%] (.*)%[(%d+)%] ��� '..reports[1].nickname..'%['..reports[1].id..'%]: (.*)') then
                            refresh_current_report()
                        end
                    end
                elseif #reports > 1 then
                    if text:find('%[.%] (.*)%[(%d+)%] ��� '..reports[k].nickname..'%['..reports[k].id..'%]: (.*)') then
                        table.remove(reports, k)
                    end
                end
            end
        end
    end
end

function cmd_basa(arg)
    lua_thread.create(function()
        if #arg == 0 then
            sampSendChat('/veh 522 3 3')
        else
        sampSendChat('/re ' .. arg)
        wait(1000)
        sampSendChat('/veh 522 1 1')
        wait(1000)
        sampSendChat('/pm ' .. arg .. " �������� ���� �� �������������")
        end
    end)
end

function cmd_woopo(arg)
    if #arg == 0 then
        sampShowDialog(209, '������� ����� �������', "\n{FFFFFF}/otb - ������� ����� \n{FF0000}/raz - c������ ������� \n{FF0000}/nap - ������� ����������� \n{FF00FF}/mep - ������� ����������� \n{00FFFF}/car[id] - ������ ������ ������ \n /sp[id] - ���������� ������(�������� � ���� � ������ ���� ����� � �/�) \n /otv - ���� ������� �� ������ \n/nak - ������� ���������", "������", '�������', 2)
    end
end

function cmd_otv(arg)
    tableOfNew.AutoReport.v = not tableOfNew.AutoReport.v
    imgui.Process = tableOfNew.AutoReport.v
end

function main()
    if not isSampLoaded() or not isSampfuncsLoaded then return end
    while not isSampAvailable() do wait(1000) end
    sampAddChatMessage('{FF0000}[�������] {00FF00}������ ����� - ����� ������ ������� - /rhelp. {4B0082}���� ������: ' .. script_vers_text, -1)
    sampRegisterChatCommand("car", cmd_basa)
    sampRegisterChatCommand('nap', cmd_churka)
    sampRegisterChatCommand("raz", cmd_balalai)
    sampRegisterChatCommand('obnova', obnova)
    sampRegisterChatCommand('otb', cmd_otbor)
    sampRegisterChatCommand('rhelp', cmd_woopo)
    sampRegisterChatCommand('nak', cmd_nakaz)
    sampRegisterChatCommand('sp', cmd_spv)
    sampRegisterChatCommand('mep', cmd_balalai2)
    sampRegisterChatCommand('otv', cmd_otv)
    imgui.SwitchContext()
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage('{00FFFF}��� ��� ��������� ����������: ' .. updateIni.info.vers_text, -1)
                update_state = true
            else
                return
            end
            os.remove(update_path)
        end
    end)
    while true do
        wait(0)
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage('{FF0000}[Ekaterinburg-ToolHelper] {00FFFF}����������! {00FF00}������ ����� /OBNOVA')
                    sampAddChatMessage('{FF0000}[Ekaterinburg-ToolHelper] {00FFFF}����������! {00FF00}������ ����� /OBNOVA')
                    sampAddChatMessage('{FF0000}[Ekaterinburg-ToolHelper] {00FFFF}����������! {00FF00}������ ����� /OBNOVA')
                    sampAddChatMessage('{FF0000}[Ekaterinburg-ToolHelper] {00FFFF}����������! {00FF00}������ ����� /OBNOVA')
                    sampAddChatMessage('{FF0000}[Ekaterinburg-ToolHelper] {00FFFF}����������! {00FF00}������ ����� /OBNOVA')
                    thisScript():reload()
                end
            end)
        end
        wait(5000)
        ran2 = math.random(1, #str_rand)
        local result, button, list, input = sampHasDialogRespond(212)
        if result then
            if button == 1 then
                sampAddChatMessage('{FF0000}�������� ���� ������� �� ���������� - @guninik')
            end
        end
        local result, button, list, input = sampHasDialogRespond(13)
        if result then
            if button == 1 then
                if list == 0 then
                    sampSendChat('/aad INFO | ��. ������/�����������, ��������� ������������� ������. ������� ������!')
                elseif list == 1 then
                    sampSendChat('/aad INFO | ��. ������, �� ������ ���������� ���� ����������� - /report.')
                elseif list == 2 then
                    sampSendChat('/aad INFO | ��. ������. �� ������ ������ ����� ������� ������ - /report.')
                end
            end
        end
        local result, button, list, input = sampHasDialogRespond(16)
        if result then
            if button == 1 then
                if list == 0 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "Rifa".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 1 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "Vagos".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 2 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "Grove".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 3 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "Aztec".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 4 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "Ballas".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                end
            end
        end
        local result, button, list, input = sampHasDialogRespond(17)
        if result then
            if button == 1 then
                if list == 0 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "���".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 1 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "���".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 2 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "���".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 3 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "�����".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 4 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "���".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 5 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "����".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 6 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "��".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 7 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "���".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 8 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "���".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                end
            end
        end
        local result, button, list, input = sampHasDialogRespond(18)
        if result then
            if button == 1 then
                if list == 0 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "LCN".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 1 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "������".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 2 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "������� �����".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 3 then
                    sampSendChat('/aad ����� | ��. ������, ������ �������� ����� �� ��������� ������ "�������".')
                    wait(1000)
                    sampSendChat('/aad ����� | ��������: +14, +10 �����, ������ ������.')
                    wait(1000)
                    sampSendChat('/aad ����� | �������� /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                end
            end
        end
        local result, button, list, input = sampHasDialogRespond(14)
        if result then
            if button == 1 then
                if list == 0 then
                    sampShowDialog(16, '�������� �������', dialogStrr, '���', '�������', 2)
                elseif list == 1 then
                    sampShowDialog(17, '�������� �������', dialogGos, '���', '�������', 2)
                elseif list == 2 then
                    sampShowDialog(18, '�������� �������', dialogMaf, '���', '�������', 2)
                end
            end
        end
    end
end

function imgui.OnDrawFrame()
    if not main_window_state.v and not second_window_state.v and not tableOfNew.AutoReport.v and not tableOfNew.tableRes.v and not third_window_state.v then
        imgui.Process = false
    end
    apply_custom_style()
    if main_window_state.v then
        imgui.SetNextWindowPos(imgui.ImVec2(500, 300), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(600, 300), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'�������', main_window_state)
        imgui.Text(u8'�������')
        imgui.Combo(u8'�����', razdacha, word, #word)
        imgui.Combo(u8'�����', razdacha_zapusk, prizeon, #prizeon)
        imgui.SameLine()
        imgui.Spinner("##spinner", 5, 3, imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]))
        if imgui.InputText(u8'������� ID ����������', text_buffer) then
        end
        if imgui.Button(u8'�������') then
            sampSendChat('/aad ������� | ��� ������ ������� "/rep' .. ' ' .. u8:decode(word[razdacha.v + 1]).. '"' .. " ��� ������� " .. u8:decode(prizeon[razdacha_zapusk.v + 1]))
        end
        imgui.SameLine()
        if imgui.Button(u8'������') then
            sampSendChat('/aad ������� | ' .. text_buffer.v .. ' WIN')
        end
        imgui.Separator()
        imgui.Text(u8'�������')
        math.randomseed(os.time())
        rand = math.random(1, 200)
        ral = math.random(1, 200)
        if imgui.Button(u8'����') then
            sampSendChat('/aad ������� | ��� ������ ����� ������ ' .. rand .. '+' .. ral .. ' ������� ' .. u8:decode(prizeon[razdacha_zapusk.v + 1]))
        end
        imgui.SameLine()
        if imgui.Button(u8'�����') then
            sampSendChat('/aad ������� | ��� ������ ����� ������ ' .. rand .. '-' .. ral .. ' ������� ' .. u8:decode(prizeon[razdacha_zapusk.v + 1]))
        end
        imgui.SameLine()
        imgui.BufferingBar("##buffer_bar", 0.7, imgui.ImVec2(390, 6), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.Button]), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]));
        imgui.Link('https://vk.com/guninik', u8'���� �������')
        imgui.Link('https://vk.com/klagem00n', u8'������ �����')
        imgui.Text(str_rand[ran2])
        imgui.End()
    end
    if second_window_state.v then
        imgui.SetNextWindowPos(imgui.ImVec2(sw /2, sh /2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(0, 0), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'���� �����������', second_window_state)
        imgui.Combo(u8'�������� ����', mep, prizemp, #prizemp)
        imgui.Combo(u8'�������� �����������', mepo, prizemep, #prizemep)
        if imgui.Button(u8'���������', imgui.ImVec2(390, 120)) then
            lua_thread.create(function()
                sampSendChat('/aad MP | ��������� ������, ������ ������ ����������� ' .. u8:decode(prizemep[mepo.v + 1]))
                wait(1000)
                sampSendChat('/aad MP | ����: ' .. u8:decode(prizemp[mep.v + 1]) .. '. ��� ���������: /gomp')
                wait(1000)
                sampSendChat('/mp')
            end)
        end
        imgui.Separator()
        imgui.InputText(u8'��������� ����', texter)
        if imgui.Button(u8'��������� �� ����� ������', imgui.ImVec2(390, 120)) then
            lua_thread.create(function()
                sampSendChat('/aad MP | ��������� ������, ������ ������ ����������� ' .. u8:decode(prizemep[mepo.v + 1]))
                wait(1000)
                sampSendChat('/aad MP | ����: ' .. u8:decode(texter.v) .. '! ��� ���������: /gomp')
                wait(1000)
                sampSendChat('/mp')
            end)
        end
        imgui.End()
    end
    if tableOfNew.AutoReport.v then
        imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(537, 450), imgui.Cond.FirstUseEver)	
        imgui.Begin(u8'����-������', tableOfNew.AutoReport, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##i_report', imgui.ImVec2(520, 30), true)		
        if #reports > 0 then
            imgui.PushTextWrapPos(500)
            imgui.TextUnformatted(u8(reports[1].nickname..'['..reports[1].id..']: '..reports[1].textP))
            imgui.PopTextWrapPos()
        end
        imgui.EndChild()
        imgui.Separator()
        imgui.PushItemWidth(520)
        imgui.InputText(u8'##answer_input_report', tableOfNew.answer_report)
        imgui.PopItemWidth()
        imgui.Text(u8'                                                          ������� �����')
        imgui.Separator()
        if imgui.Button(u8'�������� �� ID', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                if reports[1].textP:find('%d+') then
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    lua_thread.create(function()
                        local id = reports[1].textP:match('(%d+)')
                        sampSendChat('/pm '..reports[1].id..' ��������� �����, ������� ������ �� ����� ������!')
                        wait(1000)
                        sampSendChat('/re '..id)
                        refresh_current_report()
                    end)
                else
                    sampAddChatMessage('{FF0000}[������] {FF8C00}� ������� ����������� ��.', stColor)
                end
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'������ ������', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    sampSendChat('/goto '..reports[1].id)
                    wait(1000)
                    sampSendChat('/pm '..reports[1].id..' ��������� �����, ������ �������� ��� ������!')		
                    refresh_current_report()
                end)
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'�������', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    sampSendChat('/re '..reports[1].id)
                    local pID = reports[1].id
                    wait(1000)
                    sampSendChat('/pm '..pID..' ��������� �����, ������� ������ �� ����� ������!')
                    refresh_current_report()
                end)
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'���������', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    local bool = _sampSendChat(reports[1].nickname..'['..reports[1].id..']: '..reports[1].textP, 80)
                    wait(1000)
                    sampSendChat('/pm '..reports[1].id..' ��������� �����, ������� ���� ������ �������������.')
                    refresh_current_report()
                end)
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'������� ��', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    sampSendChat('/pm '..reports[1].id..' ������� ��.')
                    refresh_current_report()
                end)
            end
        end
        imgui.Separator()
        local clr = imgui.Col
        imgui.PushStyleColor(clr.Button, imgui.ImVec4(0.86, 0.09, 0.09, 0.65))
        imgui.PushStyleColor(clr.ButtonHovered, imgui.ImVec4(0.74, 0.04, 0.04, 0.65))
        imgui.PushStyleColor(clr.ButtonActive, imgui.ImVec4(0.96, 0.15, 0.15, 0.50))
        if imgui.Button(u8'������', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                imgui.OpenPopup(u8'������')
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'���.���', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 15 ����������� �������������')
                refresh_current_report()
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'���.���', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 60 ����������� ������')
                refresh_current_report()
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'����', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 5 ����')
                refresh_current_report()
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'����� ���', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 15 ����� �������������')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'��� �������', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 60 ����������� �������')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'��� �������', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 15 ����������� �������')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'���', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 5 ���')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'����.���', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/mute '..reports[1].id..' 30 ���������� ������')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'���', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/iban '..reports[1].id..' ���')
                refresh_current_report()
            end
        end
        imgui.PopStyleColor(3)
        imgui.Separator()
        if imgui.Button(u8'�� � ��', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' ��������� �����, �� ������ �������� ���� ������ � ����� ��������� ������ ��.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'�� �����', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' �� �����.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'�� ����', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' �� ����.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'���������', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    sampSendChat('/pm '..reports[1].id..' ��������� �����, ������ �������� ��� ������!')
                    wait(1000)
                    sampSendChat('/unjail '..reports[1].id)
                    refresh_current_report()
                end)
            end
        end imgui.SameLine()
        if imgui.Button(u8'�������� ����', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' �������� ���� �� ����� �������.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'��������', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' ��������� �����, ���������������� ���� ������ ���, ����� ���� ���� ���� �������/�����������.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'��������', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' ��������� �����, ������������ ������� �������� ��������.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'�.���������', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' �������� � ���������.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'�����', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' ��������� �����, ��, ��� �� ������� - �� ����� ���� ���������.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'�� ����', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' �� ����.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'��', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' ��.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'���', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' ���.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/buybiz', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /buybiz.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/gps', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /gps.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/buylead', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /buylead.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'/drecorder', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /drecorder.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/su', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /su [ID].')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/showudost', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /showudost.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/fvig', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /fvig.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/invite', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /invite.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'/clear', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /clear.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/call', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /call.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/sms', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /sms [ID] [MESSAGE].')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/togphone', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /togphone.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/business', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /business.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'/drag', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /drag [ID]')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/buyadm', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /buyadm')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/h', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /h.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/divorce', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /divorce.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/gov', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /gov.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'/recorder', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /recorder.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/find', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /find.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/mm', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /mm')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/unrent', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /unrent.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/selfie', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /selfie.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'/pgun', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /pgun.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/sellhouse', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /sellhouse')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/sellcar', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /sellcar')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/buycar', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /buycar')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/propose', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /propose')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'��������', imgui.ImVec2(100, 0)) then
            if tableOfNew.answer_report.v == '' then
                sampAddChatMessage('{FF0000}[������] {FF8C00}������� ���������� �����.', stColor)
            else
                if #reports > 0 then
                    sampSendChat('/pm '..reports[1].id..' '..u8:decode(tableOfNew.answer_report.v))
                    refresh_current_report()
                    tableOfNew.answer_report.v = ''
                end
            end
        end imgui.SameLine()
        if imgui.Button(u8'��', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    sampSendChat('/pm '..reports[1].id..' ��������� �����, ������ �������� ��� ������!')
                    wait(1000)
                    sampSendChat('/spawn '..reports[1].id)
                    refresh_current_report()
                end)
            end
        end imgui.SameLine()
        if imgui.Button(u8'���������� ���', imgui.ImVec2(100, 0)) then
            reports = {
                [0] = {
                    nickname = '',
                    id = -1,
                    textP = ''
                }
            }
        end imgui.SameLine()
        if imgui.Button(u8'������ ��', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                imgui.OpenPopup(u8'������ ������')
            end	
        end	imgui.SameLine()
        if imgui.Button(u8'����������', imgui.ImVec2(100, 0)) then
            refresh_current_report()
        end
        imgui.Separator()
        if imgui.BeginPopupModal(u8"������", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
            if imgui.Button(u8"������� ��������������", imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    sampSendChat("/pm "..reports[1].id.." ��������� �����, ��� ����������� ������������� ������� - ��������� ��� �������.")
                    refresh_current_report()
                    imgui.CloseCurrentPopup()
                end
            end
            if imgui.Button(u8"��������", imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    sampSendChat("/rmute "..reports[1].id.." 10 ������")
                    refresh_current_report()
                    imgui.CloseCurrentPopup()
                end
            end 
            if imgui.Button(u8'�������', imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"������ ������", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
            imgui.Text(u8'��������, ������� ������ ��')
            imgui.PushItemWidth(175) imgui.SliderInt('##giveHpSlider', tableOfNew.givehp, 0, 100) imgui.PopItemWidth()
            if imgui.Button(u8'������ �����', imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    lua_thread.create(function()
                        sampSendChat('/pm '..reports[1].id..' ��������� �����, ������ �������� ��� ������!')
                        wait(1000)
                        sampSendChat('/sethp '..reports[1].id..' '..tableOfNew.givehp.v)
                        refresh_current_report()
                        imgui.CloseCurrentPopup()
                    end)
                end
            end
            if imgui.Button(u8'�������', imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        imgui.End()
    end
    if third_window_state.v then
        imgui.SetNextWindowPos(imgui.ImVec2(sw /2, sh /2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(500, 500), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"##pensBar", third_window_state)
		imgui.SetWindowFontScale(1.1)
		imgui.Text(u8"������� ���������:")
		imgui.SetWindowFontScale(1.0)
		imgui.Separator()
		imgui.BeginChild("##pens")
		imgui.Columns(2, _, false)
		imgui.SetColumnWidth(-1, 255)
		imgui.Text(u8(pensTable))
		imgui.NextColumn()
		imgui.Text(u8(timesTable))
		imgui.Columns(1)
		imgui.EndChild()
		imgui.End()
    end
end


function cmd_balalai(arg)
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
end

function imgui.Link(link,name,myfunc)
    myfunc = type(name) == 'boolean' and name or myfunc or false
    name = type(name) == 'string' and name or type(name) == 'boolean' and link or link
    local size = imgui.CalcTextSize(name)
    local p = imgui.GetCursorScreenPos()
    local p2 = imgui.GetCursorPos()
    local resultBtn = imgui.InvisibleButton('##'..link..name, size)
    if resultBtn then
        if not myfunc then
            os.execute('explorer '..link)
        end
    end
    imgui.SetCursorPos(p2)
    if imgui.IsItemHovered() then
        imgui.TextColored(imgui.ImVec4(0, 0.5, 1, 1), name)
        imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y + size.y), imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.GetColorU32(imgui.ImVec4(0, 0.5, 1, 1)))
    else
        imgui.TextColored(imgui.ImVec4(0, 0.3, 0.8, 1), name)
    end
    return resultBtn
end