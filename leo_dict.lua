--	dict_name = '/usr/share/stardict/dic/stardict-langdao-ec-gb-2.4.2/langdao-ec-gb.idx';

function leo_dict_init()
	--	init dictionary: io library not allowed in wow, disabled
	if false then
		f = io.open('dict/longdao_enus2zhcn.txt');
		dict_data = f:read('*all');
		f:close();
	end;

	SlashCmdList["LEODICT"] = leo_dict_cmd;
	SLASH_LEODICT1 = "/leodict";
	SLASH_LEODICT2 = "/ld";
end

function leo_dict_cmd(msg)
	_, _, msg, meaning = string.find(dict_data, '\t(' .. msg .. ')\t\n(.-)\t\n');
	message(msg .. ': ' .. meaning);
end 

if true then
	function message(m)
		print(m);
	end

	--	testing code
	require("dict/longdao_enus2zhcn");
	SlashCmdList = {};
	leo_dict_init();
	leo_dict_cmd('test');
end
