function leo_dict_init()
	--	setup command binding
	SlashCmdList["LEODICT"] = leo_dict_cmd;
	SLASH_LEODICT1 = "/leodict";
	SLASH_LEODICT2 = "/ld";
end

--	add line warp
function leo_dict_warp(s, count)
	ret = '';
	pos = 0;

	repeat
		head_space, tail_space = string.find(s, ' ', pos + count + 1);
		head_enter, tail_enter = string.find(s, '\n', pos + 1);

		if (head_space ~= nil) and (head_enter ~= nil) then
			if head_enter <= head_space then
				sub = string.sub(s, pos, tail_enter - 1);	-- .. 'ENTER';
				pos = tail_enter;
			else
				sub = string.sub(s, pos, head_space) .. '\n';
				pos = tail_space;
			end
		else
			sub = string.sub(s, pos, -1);
			pos = nil;
		end

		ret = ret .. sub;
		--	print('warp', head_space, tail_space, head_enter, tail_enter, sub, pos, string.len(s));
	--	until pos + count >= string.len(s);
	until pos == nil;

	return ret;
end

function leo_dict_cmd(msg)
	if msg == '-show' then
		leo_dict_core:Show();
	elseif msg == '-hide' then
		leo_dict_core:Hide();
	else
		_, _, _, meaning = string.find(dict_data, '\t(' .. msg .. ')\t\n(.-)\t\n');
		meaning = leo_dict_warp(meaning, 30);

		if meaning ~= nil then
			s = '- ' .. msg .. ' -\n' .. meaning;
		else
			s = 'Not found: ' .. msg;
		end

		leo_dict_data:SetText(s);
		--	message(msg .. ': ' .. meaning);
	end
end 
