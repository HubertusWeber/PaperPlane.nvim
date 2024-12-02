--[[
  PaperPlane.nvim - A simple Neovim plugin to open the corresponding PDF file of the current buffer.
--]]

local M = {}

-- Default configuration settings
M.config = {
	output_directory = "~/Output", -- The default directory where PDFs are located
	command = "open", -- The default system command to open PDFs ('open' for macOS, 'xdg-open' for Linux)
}

-- Setup function that allows users to override default configurations
function M.setup(user_config)
	-- Merge user-provided config with the default config
	-- vim.tbl_extend('force', ...) overwrites entries in the first table with entries from the second
	M.config = vim.tbl_extend("force", M.config, user_config or {})
end

-- Core function to open the PDF file
function M.open_pdf()
	-- Get the current file's name with extension (e.g., 'document.tex')
	local filename = vim.fn.expand("%:t")

	-- Replace the file's extension with '.pdf' to get the PDF filename
	-- vim.fn.fnamemodify(filename, ':r') removes the extension from the filename
	local pdf_filename = vim.fn.fnamemodify(filename, ":r") .. ".pdf"

	-- Construct the full path to the PDF in the output directory
	-- vim.fn.expand(...) expands any '~' to the home directory
	local output_pdf = vim.fn.expand(M.config.output_directory .. "/" .. pdf_filename)

	-- Construct the full path to the PDF in the current file's directory
	-- vim.fn.expand('%:p:h') gets the directory of the current file
	local current_pdf = vim.fn.expand("%:p:h") .. "/" .. pdf_filename

	-- Check if the PDF exists in the output directory
	-- vim.fn.filereadable(...) returns 1 if the file exists and is readable, 0 otherwise
	if vim.fn.filereadable(output_pdf) == 1 then
		-- Open the PDF using the specified command
		-- vim.fn.jobstart(...) runs the command asynchronously
		vim.fn.jobstart({ M.config.command, output_pdf }, { detach = true })

	-- If not found in the output directory, check the current directory
	elseif vim.fn.filereadable(current_pdf) == 1 then
		-- Open the PDF from the current directory
		vim.fn.jobstart({ M.config.command, current_pdf }, { detach = true })

	-- If the PDF is not found in either location
	else
		-- Inform the user that the PDF was not found
		print("PDF not found.")
	end
end

-- Function to create the OpenPDF command in Neovim
function M.setup_command()
	-- vim.api.nvim_create_user_command(...) creates a new user command
	vim.api.nvim_create_user_command("OpenPDF", function()
		-- When :OpenPDF is called, execute the open_pdf function
		M.open_pdf()
	end, {})
end

M.setup_command()
return M
