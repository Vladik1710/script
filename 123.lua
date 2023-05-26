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
local main_window_state = imgui.ImBool(false)
local dialogArr = {'������', '���������� ��', '������� ������'}
local dialogStr = ''
local dialogArrr = {'Rifa', 'Vagos', 'Aztecas', 'Groove', 'Ballas'}
local dialogStrr = ''
local imBool = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local numbers = {'20+23', '34+78', '46*2' , '4*7', '52+56', '46+54', '20-8', '46-41', '7*8', '44/4' , '10+99', '412-413', '45-54', '7+5', '1+1', '888+111', '111+111'}
local word = {u8'04', u8'EKB', u8'MS', u8'Healme', u8'Kills', u8'LVL', u8'VIPCAR'}
local prizeon = {u8'"500 �������"', u8'"������ �������"', u8'"������� �� ������"', u8'"�������� ����������"', u8'"������ �� ������"', u8'"����� ������"', u8'"����� �������� �� �����"', u8'"1���"', u8'"����� ���"', u8'"500 �������"', u8'"�������"', u8'"������"', u8'��������� ����'}
require "lib.moonloader"

local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
update_state = false

local script_vers = 1
local script_vers_text = '1.00'

local update_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/update.ini'
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/123.lua'
local script_path = thisScript().path

function main()
    if not isSampLoaded() or not isSampfuncsLoaded then return end
    while not isSampAvailable() do wait(1000) end
    sampAddChatMessage('[�������] ������ �����', -1)
    sampRegisterChatCommand('nap', cmd_churka)
    sampRegisterChatCommand("raz", cmd_balalai)
    sampRegisterChatCommand('otb', cmd_otbor)
    sampRegisterChatCommand('piz', cmd_checkop)
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage('{00FFFF}��� ��� ��������� ����������: ' .. updateIni.info.vers_text, -1)
                update_state = true
            else
                sampAddChatMessage('{00FFFF}��� ��� �� ��������� ������', -1)
            end
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
        local result, button, list, input = sampHasDialogRespond(14)
        if result then
            if button == 1 then
                if list == 0 then
                    sampSendChat('/aad ����� | ������ ������� ����� �� ����� "Rifa" �������� /gomp.')
                elseif list == 1 then
                    sampSendChat('/aad ����� | ������ ������� ����� �� ����� "Vagos" �������� /gomp.')
                elseif list == 2 then
                    sampSendChat('/aad ����� | ������ ������� ����� �� ����� "Aztecas" �������� /gomp.')
                elseif list == 3 then
                    sampSendChat('/aad ����� | ������ ������� ����� �� ����� "Groove" �������� /gomp.')
                elseif list == 4 then
                    sampSendChat('/aad ����� | ������ ������� ����� �� ����� "Ballas" �������� /gomp.')
                end
            end
        end
        if main_window_state.v == false then
        imgui.Process = false
        end
    end
end

for _, str in ipairs(dialogArr) do
    dialogStr = dialogStr .. str .. "\n"
end

for _, str in ipairs(dialogArrr) do
    dialogStrr = dialogStrr .. str .. "\n"
end

function imgui.OnDrawFrame()
    imgui.SetNextWindowPos(imgui.ImVec2(500, 300), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowSize(imgui.ImVec2(600, 300), imgui.Cond.FirstUseEver)
    imgui.Begin(u8'�������', main_window_state)
    imgui.Text(u8'�������')
    imgui.Combo(u8'�����', razdacha, word, #word)
    imgui.Combo(u8'�����', razdacha_zapusk, prizeon, #prizeon)
    imgui.Text(u8'�� ���')
    imgui.SameLine()
    if imgui.ToggleButton("Test##1", imBool) then
	end
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
        sampShowDialog(14, '�������� �������', dialogStrr, '���', '�������', 2)
    end
end

function cmd_checkop(arg)
    if imBool.v == false then
        sampAddChatMessage('������', -1)
    else
        sampAddChatMessage('�����', -1)
    end
end

