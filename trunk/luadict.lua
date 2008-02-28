require('dict/langdao-ec-gb');
require('leo_dict');

--	init dictionary: io library not allowed in wow, disabled
if false then
	f = io.open('dict/longdao_enus2zhcn.txt');
	dict_data = f:read('*all');
	f:close();
end;

--	wow warp layer
leo_dict_core = {};
leo_dict_core.Show = function (self)
	print("CORE: show");
end;
leo_dict_core.Hide = function (self)
	print("CORE: hide");
end;

leo_dict_data = {};
leo_dict_data.SetText = function (self, s)
	print(s);
end

SlashCmdList = {};

--	test code
leo_dict_init();
leo_dict_cmd('test');
