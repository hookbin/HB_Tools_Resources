Emoticons_Settings = {
    ["CHAT_MSG_OFFICER"] = true, -- 1
    ["CHAT_MSG_GUILD"] = true, -- 2
    ["CHAT_MSG_PARTY"] = true, -- 3
    ["CHAT_MSG_PARTY_LEADER"] = true, -- dont count, tie to 3
    ["CHAT_MSG_PARTY_GUIDE"] = true, -- dont count, tie to 3
    ["CHAT_MSG_RAID"] = true, -- 4
    ["CHAT_MSG_RAID_LEADER"] = true, -- dont count, tie to 4
    ["CHAT_MSG_RAID_WARNING"] = true, -- dont count, tie to 4
    ["CHAT_MSG_SAY"] = true, -- 5
    ["CHAT_MSG_YELL"] = true, -- 6
    ["CHAT_MSG_WHISPER"] = true, -- 7
    ["CHAT_MSG_WHISPER_INFORM"] = true, -- dont count, tie to 7
    ["CHAT_MSG_CHANNEL"] = true, -- 8
    ["CHAT_MSG_BN_WHISPER"] = true, -- 9
    ["CHAT_MSG_BN_WHISPER_INFORM"] = true, -- dont count, tie to 9
    ["CHAT_MSG_BN_CONVERSATION"] = true, -- 10
    ["CHAT_MSG_INSTANCE_CHAT"] = true, -- 11
    ["CHAT_MSG_INSTANCE_CHAT_LEADER"] = true, -- dont count, tie to 11
    ["MAIL"] = true,
    ["MinimapPos"] = 45,
    ["MINIMAPBUTTON"] = true,
    ["LARGEEMOTES"] = true,
    ["CHECKALLFAVOURITES"] = true,
    ["FAVEMOTES"] = {}
};

local origsettings = {
    ["CHAT_MSG_OFFICER"] = true,
    ["CHAT_MSG_GUILD"] = true,
    ["CHAT_MSG_PARTY"] = true,
    ["CHAT_MSG_PARTY_LEADER"] = true,
    ["CHAT_MSG_PARTY_GUIDE"] = true,
    ["CHAT_MSG_RAID"] = true,
    ["CHAT_MSG_RAID_LEADER"] = true,
    ["CHAT_MSG_RAID_WARNING"] = true,
    ["CHAT_MSG_SAY"] = true,
    ["CHAT_MSG_YELL"] = true,
    ["CHAT_MSG_WHISPER"] = true,
    ["CHAT_MSG_WHISPER_INFORM"] = true,
    ["CHAT_MSG_BN_WHISPER"] = true,
    ["CHAT_MSG_BN_WHISPER_INFORM"] = true,
    ["CHAT_MSG_BN_CONVERSATION"] = true,
    ["CHAT_MSG_CHANNEL"] = true,
    ["CHAT_MSG_INSTANCE_CHAT"] = true,
    ["MAIL"] = true,
    ["MinimapPos"] = 45,
    ["MINIMAPBUTTON"] = true,
    ["LARGEEMOTES"] = true,
    ["CHECKALLFAVOURITES"] = true,
    ["FAVEMOTES"] = {}
};
local defaultpack = {
	-- Extends
	['黄阿姨'] = "Interface\\AddOns\\HB_Tools_Resources\\extends\\10001.tga:LARGE",
	['兔子'] = "Interface\\AddOns\\HB_Tools_Resources\\extends\\10002.tga:LARGE",
};
local emoticons = {
	-- Extends
	["黄阿姨"] = "黄阿姨",
	["兔子"] = "兔子"
};

local dropdown_options = {
    [01] = {
        "黄阿姨", "兔子"
    },
};

local ItemTextFrameSetText = ItemTextPageText.SetText;

-- Call this in a mod's initialization to move the minimap button to its saved position (also used in its movement)
-- ** do not call from the mod's OnLoad, VARIABLES_LOADED or later is fine. **
function stripChars(str)
    local tableAccents = {}
    tableAccents["À"] = "A"
    tableAccents["Á"] = "A"
    tableAccents["Â"] = "A"
    tableAccents["Ã"] = "A"
    tableAccents["Ä"] = "A"
    tableAccents["Å"] = "A"
    tableAccents["Æ"] = "AE"
    tableAccents["Ç"] = "C"
    tableAccents["È"] = "E"
    tableAccents["É"] = "E"
    tableAccents["Ê"] = "E"
    tableAccents["Ë"] = "E"
    tableAccents["Ì"] = "I"
    tableAccents["Í"] = "I"
    tableAccents["Î"] = "I"
    tableAccents["Ï"] = "I"
    tableAccents["Ð"] = "D"
    tableAccents["Ñ"] = "N"
    tableAccents["Ò"] = "O"
    tableAccents["Ó"] = "O"
    tableAccents["Ô"] = "O"
    tableAccents["Õ"] = "O"
    tableAccents["Ö"] = "O"
    tableAccents["Ø"] = "O"
    tableAccents["Ù"] = "U"
    tableAccents["Ú"] = "U"
    tableAccents["Û"] = "U"
    tableAccents["Ü"] = "U"
    tableAccents["Ý"] = "Y"
    tableAccents["Þ"] = "P"
    tableAccents["ß"] = "s"
    tableAccents["à"] = "a"
    tableAccents["á"] = "a"
    tableAccents["â"] = "a"
    tableAccents["ã"] = "a"
    tableAccents["ä"] = "a"
    tableAccents["å"] = "a"
    tableAccents["æ"] = "ae"
    tableAccents["ç"] = "c"
    tableAccents["è"] = "e"
    tableAccents["é"] = "e"
    tableAccents["ê"] = "e"
    tableAccents["ë"] = "e"
    tableAccents["ì"] = "i"
    tableAccents["í"] = "i"
    tableAccents["î"] = "i"
    tableAccents["ï"] = "i"
    tableAccents["ð"] = "eth"
    tableAccents["ñ"] = "n"
    tableAccents["ò"] = "o"
    tableAccents["ó"] = "o"
    tableAccents["ô"] = "o"
    tableAccents["õ"] = "o"
    tableAccents["ö"] = "o"
    tableAccents["ø"] = "o"
    tableAccents["ù"] = "u"
    tableAccents["ú"] = "u"
    tableAccents["û"] = "u"
    tableAccents["ü"] = "u"
    tableAccents["ý"] = "y"
    tableAccents["þ"] = "p"
    tableAccents["ÿ"] = "y"
    local normalisedString = ''
    local normalisedString = str:gsub("[%z\1-\127\194-\244][\128-\191]*",
                                      tableAccents)
    return normalisedString
end

function MyMod_MinimapButton_Reposition()
    MyMod_MinimapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 -
                                     (80 * cos(Emoticons_Settings["MinimapPos"])),
                                 (80 * sin(Emoticons_Settings["MinimapPos"])) -
                                     52)
end

-- Only while the button is dragged this is called every frame
function MyMod_MinimapButton_DraggingFrame_OnUpdate()

    local xpos, ypos = GetCursorPosition()
    local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom()
    MyMod_MinimapButton:SetToplevel(true)
    xpos = xmin - xpos / UIParent:GetScale() + 70 -- get coordinates as differences from the center of the minimap
    ypos = ypos / UIParent:GetScale() - ymin - 70

    Emoticons_Settings["MinimapPos"] = math.deg(math.atan2(ypos, xpos)) -- save the degrees we are relative to the minimap center
    MyMod_MinimapButton_Reposition() -- move the button
end

-- Put your code that you want on a minimap button click here.  arg1="LeftButton", "RightButton", etc
function MyMod_MinimapButton_OnClick()
    L_ToggleDropDownMenu(1, nil, EmoticonMiniMapDropDown,
                           MyMod_MinimapButton, 0, 0);
end

function ItemTextPageText.SetText(self, msg, ...)
    if (Emoticons_Settings["MAIL"] and msg ~= nil) then
        msg = Emoticons_RunReplacement(msg);
    end
    ItemTextFrameSetText(self, msg, ...);
end

local OpenMailBodyTextSetText = OpenMailBodyText.SetText;
function OpenMailBodyText.SetText(self, msg, ...)
    if (Emoticons_Settings["MAIL"] and msg ~= nil) then
        msg = Emoticons_RunReplacement(msg);
    end
    OpenMailBodyTextSetText(self, msg, ...);
end

function Emoticons_LoadMiniMapDropdown(self, level, menuList)
    local info = L_UIDropDownMenu_CreateInfo();
    info.isNotRadio = true;
    info.notCheckable = true;
    info.notClickable = false;
    if (level or 1) == 1 then
        for k, v in ipairs(dropdown_options) do
            if (Emoticons_Settings["FAVEMOTES"][k]) then
                info.hasArrow = true;
                info.text = v[1];
                info.value = false;
                info.menuList = k;
                L_UIDropDownMenu_AddButton(info);
            end
        end
    else
        first = true;
        for ke, va in ipairs(dropdown_options[menuList]) do
            if (first) then
                first = false;
            else
                -- print(ke.." "..va);
                info.text = "|T" .. defaultpack[va] .. "|t " .. va;
                info.value = va;
                info.func = Emoticons_Dropdown_OnClick;
                L_UIDropDownMenu_AddButton(info, level);
            end
        end
    end
end

function Emoticons_Dropdown_OnClick(self, arg1, arg2, arg3)
    if (ACTIVE_CHAT_EDIT_BOX ~= nil) then
        ACTIVE_CHAT_EDIT_BOX:Insert(self.value);
    end
end

local sm = SendMail;
function SendMail(recipient, subject, msg, ...)
    sm(recipient, subject, msg, ...);
end

local scm = SendChatMessage;
function SendChatMessage(msg, ...)
    scm(msg, ...);
end

local bnsw = BNSendWhisper;
function BNSendWhisper(id, msg, ...)
    bnsw(id, msg, ...);
end

function Emoticons_UpdateChatFilters()
    for k, v in pairs(Emoticons_Settings) do
        if k ~= "MAIL" then
            if (v) then
                ChatFrame_AddMessageEventFilter(k, Emoticons_MessageFilter)
            else
                ChatFrame_RemoveMessageEventFilter(k, Emoticons_MessageFilter);
            end
        end
    end
end

function Emoticons_MessageFilter(self, event, msg, ...)
    msg = Emoticons_RunReplacement(msg);

    return false, msg, ...
end

function Emoticons_OnEvent(self, event, ...)
    if (event == "ADDON_LOADED" and select(1, ...) == "HB_Tools_Resources") then
        for k, v in pairs(origsettings) do
            if (Emoticons_Settings[k] == nil) then
                Emoticons_Settings[k] = v;
            end
        end
        Emoticons_UpdateChatFilters();
        Emoticons_SetMinimapButton(Emoticons_Settings["MINIMAPBUTTON"]);
        Emoticons_SetLargeEmotes(Emoticons_Settings["LARGEEMOTES"]);
        MyMod_MinimapButton_Reposition();
    end
end

function Emoticons_OptionsWindow_OnShow(self)
    for k, v in pairs(Emoticons_Settings) do
        local cb = getglobal("EmoticonsOptionsControlsPanel" .. k);

        if (cb ~= nil) then cb:SetChecked(Emoticons_Settings[k]); end
    end

    if Emoticons_Settings["MINIMAPBUTTON"] then
        getglobal("$showMinimapButtonButton"):SetChecked(true);
    end

    if Emoticons_Settings["LARGEEMOTES"] then
        getglobal("$showLargeEmotesButton"):SetChecked(true);
    end

    favall = CreateFrame("CheckButton", "favall_GlobalName",
                         EmoticonsOptionsControlsPanel, "UIRadioButtonTemplate");
    if Emoticons_Settings["CHECKALLFAVOURITES"] then
        getglobal("favall_GlobalName"):SetChecked(true);
        for n, m in ipairs(Emoticons_Settings["FAVEMOTES"]) do
            Emoticons_Settings["FAVEMOTES"][n] = true;
        end
    else
        getglobal("favall_GlobalName"):SetChecked(false);
    end
    favall:SetPoint("TOPLEFT", 17, -240);
    getglobal(favall:GetName() .. "Text"):SetText("Check all");
    favall.tooltip = "Check all boxes below.";
    getglobal("favall_GlobalName"):SetScript("OnClick", function(self)
        if (self:GetChecked()) then
            if getglobal("favnone_GlobalName"):GetChecked() then
                getglobal("favnone_GlobalName"):SetChecked(false);
            end
            self:SetChecked(true);
            for n, m in ipairs(Emoticons_Settings["FAVEMOTES"]) do
                Emoticons_Settings["FAVEMOTES"][n] = true;
                if not getglobal("favCheckButton_" .. dropdown_options[n][1]):GetChecked() then
                    getglobal("favCheckButton_" .. dropdown_options[n][1]):SetChecked(true);
                end
            end
            Emoticons_Settings["CHECKALLFAVOURITES"] = true;
        else
            -- Emoticons_Settings["FAVEMOTES"][a] = false;
        end
    end);

    favnone = CreateFrame("CheckButton", "favnone_GlobalName",
                          favall_GlobalName, "UIRadioButtonTemplate");
    if not Emoticons_Settings["CHECKALLFAVOURITES"] then
        getglobal("favnone_GlobalName"):SetChecked(true);
        for n, m in ipairs(Emoticons_Settings["FAVEMOTES"]) do
            Emoticons_Settings["FAVEMOTES"][n] = false;
        end
    else
        getglobal("favnone_GlobalName"):SetChecked(false);
    end
    favnone:SetPoint("TOPLEFT", 110, 0);
    getglobal(favnone:GetName() .. "Text"):SetText("Uncheck all");
    favnone.tooltip = "Uncheck all boxes below.";
    getglobal("favnone_GlobalName"):SetScript("OnClick", function(self)
        if (self:GetChecked()) then
            if (getglobal("favall_GlobalName"):GetChecked() == true) then
                getglobal("favall_GlobalName"):SetChecked(false);
            end
            self:SetChecked(true);
            for n, m in ipairs(Emoticons_Settings["FAVEMOTES"]) do
                Emoticons_Settings["FAVEMOTES"][n] = false;
                if getglobal("favCheckButton_" .. dropdown_options[n][1]):GetChecked() then
                    getglobal("favCheckButton_" .. dropdown_options[n][1]):SetChecked(false);
                end
            end
            Emoticons_Settings["CHECKALLFAVOURITES"] = false;
        else
            -- Emoticons_Settings["FAVEMOTES"][a] = false;
        end
    end);

    favframe = CreateFrame("Frame", "favframe_GlobalName", favall_GlobalName);
    favframe:SetPoint("TOPLEFT", 0, -24);
    favframe:SetSize(590, 175);

    first = true;
    itemcnt = 0
    for a, c in ipairs(dropdown_options) do

        if first then
            favCheckButton = CreateFrame("CheckButton",
                                         "favCheckButton_" .. c[1],
                                         favframe_GlobalName,
                                         "ChatConfigCheckButtonTemplate");
            first = false;
            favCheckButton:SetPoint("TOPLEFT", 0, 0);
        else
            -- favbuttonlist=loadstring("favCheckButton_"..anchor);

            favCheckButton = CreateFrame("CheckButton",
                                         "favCheckButton_" .. c[1],
                                         favframe_GlobalName,
                                         "ChatConfigCheckButtonTemplate");
            favCheckButton:SetParent("favCheckButton_" .. anchor);
            if ((itemcnt % 10) ~= 0) then
                favCheckButton:SetPoint("TOPLEFT", 0, -16);
            else
                favCheckButton:SetPoint("TOPLEFT", 110, 9 * 16);
            end
        end
        itemcnt = itemcnt + 1;
        anchor = c[1];

        -- code=[[print("favCheckButton_"..b[1]..":SetText(b[1])")]];

        getglobal(favCheckButton:GetName() .. "Text"):SetText(c[1]);
        if (getglobal("favCheckButton_" .. c[1]):GetChecked() ~=
            Emoticons_Settings["FAVEMOTES"][a]) then
            getglobal("favCheckButton_" .. c[1]):SetChecked(
                Emoticons_Settings["FAVEMOTES"][a]);
        end
        favCheckButton.tooltip = "Checked boxes will show in the dropdownlist.";
        favCheckButton:SetScript("OnClick", function(self)
            if (self:GetChecked()) then
                Emoticons_Settings["FAVEMOTES"][a] = true;
            else
                Emoticons_Settings["FAVEMOTES"][a] = false;
            end
        end);

    end
end

function Emoticons_RunReplacement(msg)
    -- remember to watch out for |H|h|h's

    local outstr = "";
    local origlen = string.len(msg);
    local startpos = 1;
    local endpos;

    while (startpos <= origlen) do
        endpos = origlen;
        local pos = string.find(msg, "|H", startpos, true);
        if (pos ~= nil) then endpos = pos; end
        outstr = outstr ..
                     Emoticons_InsertEmoticons(string.sub(msg, startpos, endpos)); -- run replacement on this bit
        startpos = endpos + 1;
        if (pos ~= nil) then
            endpos = string.find(msg, "|h", startpos, true);
            if (endpos == nil) then endpos = origlen; end
            if (startpos < endpos) then
                outstr = outstr .. string.sub(msg, startpos, endpos); -- don't run replacement on this bit
                startpos = endpos + 1;
            end
        end
    end

    return outstr;
end

function Emoticons_SetMinimapButton(state)
    Emoticons_Settings["MINIMAPBUTTON"] = state;
    if (state) then
        MyMod_MinimapButton:Show();
    else
        MyMod_MinimapButton:Hide();
    end
end

function Emoticons_SetLargeEmotes(state)
    Emoticons_Settings["LARGEEMOTES"] = state;
end

function Emoticons_InsertEmoticons(msg)
    local normal = '28:28'
    local large = '64:64'
    local xlarge = '128:128'
    local xxlarge = '256:256'
    for k, v in pairs(emoticons) do
        if (string.find(msg, k, 1, true)) then
            -- Get the size of the emote, if not a standard size
            size = string.match(defaultpack[v], ":(.*)")

            -- Make a copy of the file path so we don't modify the original value
            path_and_size = defaultpack[v]

            -- Check if the user has large emotes enabled. 
            -- If not, replace the size with the standard size of 28:28,
            -- else set it to the standard large size of 64:64
            if not Emoticons_Settings["LARGEEMOTES"] then
                if ( size == 'LARGE' or size == 'XLARGE' or size == 'XXLARGE' ) then
                    path_and_size = string.gsub(defaultpack[v], size, normal)
                end
            else
                if ( size == 'LARGE' ) then
                    path_and_size = string.gsub(defaultpack[v], size, large)
                elseif ( size == 'XLARGE' ) then
                    path_and_size = string.gsub(defaultpack[v], size, xlarge)
                elseif ( size == 'XXLARGE') then
                    path_and_size = string.gsub(defaultpack[v], size, xxlarge)
                end
            end

            msg = string.gsub(msg, "(%s)" .. k .. "(%s)",
                              "%1|T" .. path_and_size .. "|t%2");
            msg = string.gsub(msg, "(%s)" .. k .. "$",
                              "%1|T" .. path_and_size .. "|t");
            msg = string.gsub(msg, "^" .. k .. "(%s)",
                              "|T" .. path_and_size .. "|t%1");
            msg = string.gsub(msg, "^" .. k .. "$",
                              "|T" .. path_and_size .. "|t");
            msg = string.gsub(msg, "(%s)" .. k .. "(%c)",
                              "%1|T" .. path_and_size .. "|t%2");
            msg = string.gsub(msg, "(%s)" .. k .. "(%s)",
                              "%1|T" .. path_and_size .. "|t%2");
        end
    end

    return msg;
end

function Emoticons_SetType(chattype, state)
    if (state) then
        state = true;
    else
        state = false;
    end
    if (chattype == "CHAT_MSG_RAID") then
        Emoticons_Settings["CHAT_MSG_RAID_LEADER"] = state;
        Emoticons_Settings["CHAT_MSG_RAID_WARNING"] = state;
    end
    if (chattype == "CHAT_MSG_PARTY") then
        Emoticons_Settings["CHAT_MSG_PARTY_LEADER"] = state;
        Emoticons_Settings["CHAT_MSG_PARTY_GUIDE"] = state;
    end
    if (chattype == "CHAT_MSG_WHISPER") then
        Emoticons_Settings["CHAT_MSG_WHISPER_INFORM"] = state;
    end
    if (chattype == "CHAT_MSG_INSTANCE_CHAT") then
        Emoticons_Settings["CHAT_MSG_INSTANCE_CHAT_LEADER"] = state;
    end
    if (chattype == "CHAT_MSG_BN_WHISPER") then
        Emoticons_Settings["CHAT_MSG_BN_WHISPER_INFORM"] = state;
    end

    Emoticons_Settings[chattype] = state;
    Emoticons_UpdateChatFilters();
end

b = CreateFrame("Button", "TestButton", ChatFrame1, "UIPanelButtonTemplate");

function Emoticons_RegisterPack(name, newEmoticons, pack)
    for k, v in pairs(newEmoticons) do
        emoticons[k] = v
    end

    for k, v in pairs(pack) do
        defaultpack[k] = v
    end
end