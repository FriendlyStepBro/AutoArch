vim.keymap.set("n", "<A-S-c>", ":lua ToggleMouse()<CR>", { noremap = true, silent = true })

function _G.ToggleMouse()
	local mouse_state = vim.o.mouse
	if mouse_state == "a" then
		vim.opt.mouse = ""
		print("Mouse disabled")
	else
		vim.opt.mouse = "a"
		print("Mouse enabled")
	end
end

-- return ToggleMouse()
