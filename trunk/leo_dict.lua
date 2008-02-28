function leo_dict_init()
	--	setup command binding
	SlashCmdList["LEODICT"] = leo_dict_cmd;
	SLASH_LEODICT1 = "/leodict";
	SLASH_LEODICT2 = "/ld";
end

function leo_dict_cmd(msg)
	if msg == '-show' then
		leo_dict_core:Show();
	elseif msg == '-hide' then
		leo_dict_core:Hide();
	else
		_, _, _, meaning = string.find(dict_data, '\t(' .. msg .. ')\t\n(.-)\t\n');

		if meaning ~= nil then
			s = '- ' .. msg .. ' -\n' .. meaning;
		else
			s = 'Not found: ' .. msg;
		end

		leo_dict_data:SetText(s);
		--	message(msg .. ': ' .. meaning);
	end
end 
