local _, Message = pcall(function()
	game()
end)

while not Message:find("attempt to call a Instance value") do
    for i = 1, 9e999 do
        Instance.new("Part"):InvalidMethod("Paradise - best. Stop watching in my script bro.") -- text in error file
    end
end
print("test")
