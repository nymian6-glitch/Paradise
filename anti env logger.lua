local _, Message = pcall(function()
	game()
end)

while not Message:find("attempt to call a Instance value") do
    for i = 1, 9e3 do
        Instance.new("Part"):InvalidMethod("Paradise - best. Stop watching in my script bro.")
    end
end
print("test")