dict_name = '/usr/share/stardict/dic/stardict-langdao-ec-gb-2.4.2/langdao-ec-gb.idx';

dict_file = io.open(dict_name, 'rb');
dict_data = dict_file:read("*all");
dict_file:close();

function leo_dict_init()
	-- add our very first chat command!
	SlashCmdList["LEODICT"] = leo_dict_cmd;
	SLASH_LEODICT1 = "/leodict";
	SLASH_LEODICT2 = "/ld";
end

function leo_dict_cmd(msg)
	-- this function handles our chat command
	message(msg);
end 

--	dev warp

function message(m)
	print(m);
end

test = {};
test['test'] = 'my file';

leo_dict_cmd(test['test']);

