function leo_dict_init()
	--	init dictionary: io library not allowed in wow, disabled
	if false then
		f = io.open('dict/longdao_enus2zhcn.txt');
		dict_data = f:read('*all');
		f:close();
	end;

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
			s = msg .. ': ' .. meaning;
		else
			s = 'Not found: ' .. msg;
		end

		leo_dict_data:SetText(s);
		--	message(msg .. ': ' .. meaning);
	end
end 

--	for local testing
if false then
	function message(m)
		print(m);
	end

	require("dict/longdao_enus2zhcn");
	SlashCmdList = {};
	leo_dict_init();
	leo_dict_cmd('test');
end
