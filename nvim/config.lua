require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "go"},


  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  foldmethod=expr,

  indent = {
    enable = true
  },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


require'lspconfig'.clangd.setup{}
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('go').setup({
  -- other setups ....
   lsp_cfg = {
     capabilities = capabilities,
    -- other setups
  },
})
local cfg = require'go.lsp'.config()
require('lspconfig').gopls.setup(cfg)




local null_ls = require("null-ls")
local eslint = require("eslint")

null_ls.setup()

eslint.setup({
  bin = 'eslint', -- or `eslint_d`
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
      types = { "directive", "problem", "suggestion", "layout" },
    },
    disable_rule_comment = {
      enable = true,
      location = "separate_line", -- or `same_line`
    },
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "type", -- or `save`
  },
})

lspconfig = require("lspconfig")
lspconfig.eslint.setup({
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

lspconfig.tsserver.setup({})

--local prettier = require("prettierd")

--prettier.setup({
--  bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
--  filetypes = {
--    "css",
--    "graphql",
--    "html",
--    "javascript",
--    "javascriptreact",
--    "json",
--    "less",
--    "markdown",
--    "scss",
--    "typescript",
--    "typescriptreact",
--    "yaml",
--  },
--})

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    -- other formatters ...
  }
})

config = function()
    local lsp_zero = require("lsp-zero")
    lsp_zero.format_on_save({
        format_opts = {
            async = true,
            timeout_ms = 10000,
        },
        servers = {
            ['clangd'] = { 'c', 'cpp' },
        }
    })
end
