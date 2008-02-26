function ld_init()
	f = io.open('../dict/longdao_enus2zhcn.txt');
	s = f:read('*all');
	f:close();
end

function ld_find(sub)
	_, _, index, meaning = string.find(s, '\t(' .. sub .. ')\t\n(.-)\t\n');
	print(index);
	print(meaning);
end

ld_init();
ld_find('fuck');
