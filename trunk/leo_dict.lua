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
