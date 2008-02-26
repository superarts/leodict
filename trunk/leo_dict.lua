--	dict_name = '/usr/share/stardict/dic/stardict-langdao-ec-gb-2.4.2/langdao-ec-gb.idx';

function leo_dict_init()
	--	init dictionary
	f = io.open('dict/longdao_enus2zhcn.txt');
	s = f:read('*all');
	f:close();
	--	add our very first chat command!
	SlashCmdList["LEODICT"] = leo_dict_cmd;
	SLASH_LEODICT1 = "/leodict";
	SLASH_LEODICT2 = "/ld";
end

function leo_dict_cmd(msg)
	--	this function handles our chat command
	_, _, msg, meaning = string.find(s, '\t(' .. sub .. ')\t\n(.-)\t\n');
	--	print(index);
	--	print(meaning);
	message(meaning);
end 

--	dev warp
--[[
function message(m)
	print(m);
end

test = {};
test['test'] = 'my file';

leo_dict_cmd(test['test']);
]]
