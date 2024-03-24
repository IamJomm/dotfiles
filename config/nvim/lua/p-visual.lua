return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = { enabled = false },
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({
				actions = {
					open_file = { quit_on_open = true },
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"BurntSushi/ripgrep",
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
			background_colour = "#000000",
			render = "wrapped-compact",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename" },
					lualine_c = { "diagnostics" },
					lualine_x = { "diff", "branch" },
					lualine_y = { "filetype" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
	{
		-- originally authored by @AdamWhittingham
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = function()
			local path_ok, plenary_path = pcall(require, "plenary.path")
			if not path_ok then
				return
			end

			local dashboard = require("alpha.themes.dashboard")
			local cdir = vim.fn.getcwd()
			local if_nil = vim.F.if_nil

			local nvim_web_devicons = {
				enabled = true,
				highlight = true,
			}

			local function get_extension(fn)
				local match = fn:match("^.+(%..+)$")
				local ext = ""
				if match ~= nil then
					ext = match:sub(2)
				end
				return ext
			end

			local function icon(fn)
				local nwd = require("nvim-web-devicons")
				local ext = get_extension(fn)
				return nwd.get_icon(fn, ext, { default = true })
			end

			local function file_button(fn, sc, short_fn, autocd)
				short_fn = short_fn or fn
				local ico_txt
				local fb_hl = {}

				if nvim_web_devicons.enabled then
					local ico, hl = icon(fn)
					local hl_option_type = type(nvim_web_devicons.highlight)
					if hl_option_type == "boolean" then
						if hl and nvim_web_devicons.highlight then
							table.insert(fb_hl, { hl, 0, #ico })
						end
					end
					if hl_option_type == "string" then
						table.insert(fb_hl, { nvim_web_devicons.highlight, 0, #ico })
					end
					ico_txt = ico .. "  "
				else
					ico_txt = ""
				end
				local cd_cmd = (autocd and " | cd %:p:h" or "")
				local file_button_el = dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. cd_cmd .. " <CR>")
				local fn_start = short_fn:match(".*[/\\]")
				if fn_start ~= nil then
					table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
				end
				file_button_el.opts.hl = fb_hl
				return file_button_el
			end

			local default_mru_ignore = { "gitcommit" }

			local mru_opts = {
				ignore = function(path, ext)
					return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
				end,
				autocd = false,
			}

			--- @param start number
			--- @param cwd string? optional
			--- @param items_number number? optional number of items to generate, default = 10
			local function mru(start, cwd, items_number, opts)
				opts = opts or mru_opts
				items_number = if_nil(items_number, 10)

				local oldfiles = {}
				for _, v in pairs(vim.v.oldfiles) do
					if #oldfiles == items_number then
						break
					end
					local cwd_cond
					if not cwd then
						cwd_cond = true
					else
						cwd_cond = vim.startswith(v, cwd)
					end
					local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
					if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
						oldfiles[#oldfiles + 1] = v
					end
				end
				local target_width = 35

				local tbl = {}
				for i, fn in ipairs(oldfiles) do
					local short_fn
					if cwd then
						short_fn = vim.fn.fnamemodify(fn, ":.")
					else
						short_fn = vim.fn.fnamemodify(fn, ":~")
					end

					if #short_fn > target_width then
						short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
						if #short_fn > target_width then
							short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
						end
					end

					local shortcut = tostring(i + start - 1)

					local file_button_el = file_button(fn, shortcut, short_fn, opts.autocd)
					tbl[i] = file_button_el
				end
				return {
					type = "group",
					val = tbl,
					opts = {},
				}
			end

			local header = {
				type = "text",
				val = {
					[[										  ]],
					[[    _   __           _    ______        ]],
					[[   / | / /__  ____  | |  / /  _/___ ___ ]],
					[[  /  |/ / _ \/ __ \ | | / // // __ `__ \]],
					[[ / /|  /  __/ /_/ / | |/ // // / / / / /]],
					[[/_/ |_/\___/\____/  |___/___/_/ /_/ /_/ ]],
					[[                                        ]],
				},
				opts = {
					position = "center",
					hl = "Type",
					-- wrap = "overflow";
				},
			}

			local section_mru = {
				type = "group",
				val = {
					{
						type = "text",
						val = "Recent files",
						opts = {
							hl = "SpecialComment",
							shrink_margin = false,
							position = "center",
						},
					},
					{ type = "padding", val = 1 },
					{
						type = "group",
						val = function()
							return { mru(0, cdir) }
						end,
						opts = { shrink_margin = false },
					},
				},
			}

			local buttons = {
				type = "group",
				val = {
					{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
					{ type = "padding", val = 1 },
					dashboard.button("e", "  New file", "<cmd>ene<CR>"),
					dashboard.button("SPC f f", "󰈞  Find file"),
					dashboard.button("SPC f g", "󰊄  Live grep"),
					dashboard.button("c", "  Configuration", "<cmd>cd ~/.config/nvim/ <CR>"),
					dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
					dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
				},
				position = "center",
			}

			local config = {
				layout = {
					{ type = "padding", val = 2 },
					header,
					{ type = "padding", val = 2 },
					buttons,
					{ type = "padding", val = 2 },
					section_mru,
				},
				opts = {
					margin = 5,
					setup = function()
						vim.api.nvim_create_autocmd("DirChanged", {
							pattern = "*",
							group = "alpha_temp",
							callback = function()
								require("alpha").redraw()
							end,
						})
					end,
				},
			}

			return config
		end,
	},
}
