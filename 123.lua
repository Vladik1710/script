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
local sampev = require 'lib.samp.events'
local main_window_state = imgui.ImBool(false)
local dialogArr = {'������', '���������� ��', '������� ������'}
local dialogStr = ''
local dialogArrr = {'Rifa', 'Vagos', 'Aztecas', 'Groove', 'Ballas'}
local dialogStrr = ''
local dialogGoss = {'���', '���', '���', '�����', '���', '����', '��', '���', '���'}
local dialogGos = ''
local dialogMaff = {'LCN', 'Yakudza', '������� �����', '�������'}
local dialogMaf = ''
local imBool = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local numbers = {'20+23', '34+78', '46*2' , '4*7', '52+56', '46+54', '20-8', '46-41', '7*8', '44/4' , '10+99', '412-413', '45-54', '7+5', '1+1', '888+111', '111+111'}
local word = {u8'04', u8'EKB', u8'MS', u8'Healme', u8'Kills', u8'LVL', u8'VIPCAR'}
local prizeon = {u8'"500 �������"', u8'"������ �������"', u8'"������� �� ������"', u8'"�������� ����������"', u8'"������ �� ������"', u8'"����� ������"', u8'"����� �������� �� �����"', u8'"1���"', u8'"����� ���"', u8'"500 �������"', u8'"�������"', u8'"������"', u8'��������� ����'}
require "lib.moonloader"
local dialogOtb = {'Ghetto', 'Goss', 'Mafia'}
local dialogOtbb = ''
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
update_state = false
local str_rand = {'123', '123'}
local script_vers = 11
local script_vers_text = '1.11'

local update_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/update.ini'
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/123.lua'
local script_path = thisScript().path

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

function sampev.onServerMessage(color, text)
    lua_thread.create(function()
        if string.find(text, '� ������������ � ����, ������� ����� :)', 1, true) then
            wait(10000)
            sampShowDialog(212, "{FFFFFF}�{FF0000}�{000000}�{FA8072}�{8B0000}�{FF1493}�{006400}�{808000}�{FF4500}�{FF8C00}�", "�������� ��������!\n{FFFFFF}���������� ����!", "�������", '�������', 0)
        end
    end)
end

function main()
    if not isSampLoaded() or not isSampfuncsLoaded then return end
    while not isSampAvailable() do wait(1000) end
    sampAddChatMessage('[�������] ������ ����� - ����� ������ ������� - /rhelp', -1)
    sampRegisterChatCommand("car", cmd_basa)
    sampRegisterChatCommand('nap', cmd_churka)
    sampRegisterChatCommand("raz", cmd_balalai)
    sampRegisterChatCommand('otb', cmd_otbor)
    sampRegisterChatCommand('rhelp', cmd_woopo)
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage('{00FFFF}��� ��� ��������� ����������: ' .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
    while true do
        wait(0)
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage('{FF0000}������ �������� �������')
                    thisScript():reload()
                end
            end)
        end
        local result, button, list, input = sampHasDialogRespond(212)
        if result then
            if button == 1 then
                sampAddChatMessage('{FF0000}�������� ���� ����� - @guninik', -1)
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
        if main_window_state.v == false then
        imgui.Process = false
        end
    end
    wait(2000)
    ran2 = math.random(1, #str_rand)
end

function imgui.OnDrawFrame()
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

    imgui.Text('��� ����� �������� ���������!')
    imgui.End()
end

function cmd_balalai(arg)
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
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
        sampShowDialog(209, '������� ����� �������', "\n{FFFFFF}/otb - ������� ����� \n{FF0000}/raz - c������ ������� \n{00FFFF}/car[id] - ������ ������ ������ \n{FF0000}/nap - ������� �����������", "������", '�������', 2)
    end
end