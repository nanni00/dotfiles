return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "ibhagwan/fzf-lua",
    },

    -- by typing <leader>v it seems that no command is available
    -- if we are not on a python file or this has not typed yet
    ft = "python", -- Load when opening Python files
    keys = {
      { "<leader>cvs", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
    },
    opts = { -- this can be an empty lua table - just showing below for clarity.
      search = {
        poetry = false,
        pyenv = false,
        anaconda = false,

        custom_mnt_search = {
          command = "fd 'miniconda3/envs/.+/bin/python$' --full-path '/home/nanni/mnt/' --color never -E '(data|dbms|libs|projects|pkgs)'",
        },
      }, -- if you add your own searches, they go here.
      options = {
        search_timeout = 8,
      }, -- if you add plugin options, they go here.
    },

    config = function(_, opts)
      require("venv-selector").setup(opts)
    end,
  },

  -- molten configuration
  --
  -- quarto (+otter) + image + jupytext + molten
  {
    "jmbuhr/otter.nvim",
    ft = { "markdown", "quarto", "norg" },
  },

  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    ft = { "quarto", "markdown" },
    dev = false,

    opts = {
      lspFeatures = {
        languages = { "python", "rust" },
        chunks = "all",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = {
        hover = "H",
        definition = "gd",
        rename = "<leader>rn",
        references = "gr",
        format = "<leader>gf",
      },

      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
  },

  {
    "GCBallesteros/jupytext.nvim",
    config = true,
    opts = {
      lazy = false,
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
  },

  {
    "benlubas/molten-nvim",
    dependencies = {
      "3rd/image.nvim",
      "GCBallesteros/jupytext.nvim",
      "quarto-dev/quarto-nvim",
    },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,

    config = function()
      vim.g.molten_virt_text_output = true

      -- automatically import output chunks from a jupyter notebook
      -- tries to find a kernel that matches the kernel in the jupyter notebook
      -- falls back to a kernel that matches the name of the active venv (if any)
      -- local imb = function(e) -- init molten buffer
      --   vim.schedule(function()
      --     local kernels = vim.fn.MoltenAvailableKernels()
      --     local try_kernel_name = function()
      --       local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
      --       return metadata.kernelspec.name
      --     end
      --     local ok, kernel_name = pcall(try_kernel_name)
      --     if not ok or not vim.tbl_contains(kernels, kernel_name) then
      --       kernel_name = nil
      --       local venv = os.getenv("VIRTUAL_ENV")
      --       if venv ~= nil then
      --         kernel_name = string.match(venv, "/.+/(.+)")
      --       end
      --     end
      --     if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
      --       vim.cmd(("MoltenInit %s"):format(kernel_name))
      --     end
      --     vim.cmd("MoltenImportOutput")
      --   end)
      -- end

      -- automatically import output chunks from a jupyter notebook
      -- vim.api.nvim_create_autocmd("BufAdd", {
      --   pattern = { "*.ipynb" },
      --   callback = imb,
      -- })
      --
      -- -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
      -- vim.api.nvim_create_autocmd("BufEnter", {
      --   pattern = { "*.ipynb" },
      --   callback = function(e)
      --     if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
      --       imb(e)
      --     end
      --   end,
      -- })

      -- automatically export output chunks to a jupyter notebook on write
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.ipynb" },
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
          end
        end,
      })

      -- change the configuration when editing a python file
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.py",
        callback = function(e)
          if string.match(e.file, ".otter.") then
            return
          end
          if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
            vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
            vim.fn.MoltenUpdateOption("virt_text_output", false)
          else
            vim.g.molten_virt_lines_off_by_1 = false
            vim.g.molten_virt_text_output = false
          end
        end,
      })

      -- Undo those config changes when we go back to a markdown or quarto file
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.qmd", "*.md", "*.ipynb" },
        callback = function(e)
          if string.match(e.file, ".otter.") then
            return
          end
          if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
            vim.fn.MoltenUpdateOption("virt_text_output", true)
          else
            vim.g.molten_virt_lines_off_by_1 = true
            vim.g.molten_virt_text_output = true
          end
        end,
      })

      vim.keymap.set("n", "<leader>cMi", ":MoltenInit<CR>", { silent = true, desc = "Initialize Molten" })
      vim.keymap.set(
        "n",
        "<leader>cMr",
        ":MoltenEvaluateOperator<CR>",
        { silent = true, desc = "Run operator selection" }
      )
      vim.keymap.set("n", "<leader>cMrl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Evaluate line" })
      vim.keymap.set("n", "<leader>cMrr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "Re-evaluate cell" })
      vim.keymap.set(
        "v",
        "<leader>cMrv",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        { silent = true, desc = "Evaluate visual selection" }
      )

      vim.keymap.set("n", "<leader>cMd", ":MoltenDelete<CR>", { silent = true, desc = "Delete cell" })
      vim.keymap.set("n", "<leader>cMh", ":MoltenHideOutput<CR>", { silent = true, desc = "Hide output" })
      vim.keymap.set(
        "n",
        "<leader>cMo",
        ":noautocmd MoltenEnterOutput<CR>",
        { silent = true, desc = "Show/enter output" }
      )

      vim.keymap.set("n", "<leader>cMb", ":MoltenOpenInBrowser<CR>", { desc = "Open output in browser", silent = true })

      vim.keymap.set("n", "<leader>cMn", ":MoltenNext<CR>", { silent = true, desc = "Molten next cell" })
      vim.keymap.set("n", "<leader>cMp", ":MoltenPrev<CR>", { silent = true, desc = "Molten prev cell" })

      vim.keymap.set("n", "<leader>cMr", ":MoltenRestart<CR>", { silent = true, desc = "Restart" })

      -- Provide a command to create a blank new Python notebook
      -- note: the metadata is needed for Jupytext to understand how to parse the notebook.
      -- if you use another language than Python, you should change it in the template.
      local default_notebook = [[
          {
            "cells": [
             {
              "cell_type": "markdown",
              "metadata": {},
              "source": [
                ""
              ]
             }
            ],
            "metadata": {
             "kernelspec": {
              "display_name": "Python 3",
              "language": "python",
              "name": "python3"
             },
             "language_info": {
              "codemirror_mode": {
                "name": "ipython"
              },
              "file_extension": ".py",
              "mimetype": "text/x-python",
              "name": "python",
              "nbconvert_exporter": "python",
              "pygments_lexer": "ipython3"
             }
            },
            "nbformat": 4,
            "nbformat_minor": 5
          }
        ]]

      local function new_notebook(filename)
        local path = filename .. ".ipynb"
        local file = io.open(path, "w")
        if file then
          file:write(default_notebook)
          file:close()
          vim.cmd("edit " .. path)
        else
          print("Error: Could not open new notebook file for writing.")
        end
      end

      vim.api.nvim_create_user_command("NewNotebook", function(opts)
        new_notebook(opts.args)
      end, {
        nargs = 1,
        complete = "file",
      })
    end,
  },
}
