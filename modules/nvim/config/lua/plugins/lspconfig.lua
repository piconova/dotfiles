return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- autocompletion
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    
    -- snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",

    -- formatting
    "joechrisellis/lsp-format-modifications.nvim"
  },
  config = function()
    local lspconfig = require('lspconfig')

    -- client capabilities
    local lsp_defaults = lspconfig.util.default_config
    lsp_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lsp_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    -- keybindings
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { noremap = true, silent = true }
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'go', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
        vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, bufopts)
        -- vim.keymap.set('x', '<C-.>', vim.lsp.buf.range_code_action, bufopts)
        -- vim.keymap.set('n', '<space>f', formatting, function()
        --   vim.lsp.buf.format({ async = true })
        -- end, bufopts)

        vim.keymap.set('n', '[', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
 
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --   pattern = "*",
        --   command = "lua vim.lsp.buf.format({ async = true })" 
        -- })
      end
    })

    -- language servers
    lspconfig.pyright.setup {}
    lspconfig.clangd.setup {
      on_attach = function(client, bufnr)
        local lsp_format_modifications = require("lsp-format-modifications")
        lsp_format_modifications.attach(client, bufnr, { format_on_save = false })
      end
    }

    -- snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- autocompletion
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local select_opts = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      sources = {
        {name = 'path'},
        {name = 'buffer', keyword_length = 3},
        {name = 'nvim_lsp', keyword_length = 1},
        {name = 'luasnip', keyword_length = 2},
      },
      window = {
        documentation = cmp.config.window.bordered()
      },
      formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
          local menu_icon = {
            Text = '  ',
            Method = '  ',
            Function = '  ',
            Constructor = '  ',
            Field = '  ',
            Variable = '  ',
            Class = '  ',
            Interface = '  ',
            Module = '  ',
            Property = '  ',
            Unit = '  ',
            Value = '  ',
            Enum = '  ',
            Keyword = '  ',
            Snippet = '  ',
            Color = '  ',
            File = '  ',
            Reference = '  ',
            Folder = '  ',
            EnumMember = '  ',
            Constant = '  ',
            Struct = '  ',
            Event = '  ',
            Operator = '  ',
            TypeParameter = '  ',
          }

          item.menu = menu_icon[entry.source.name]
          return item
        end,
      },
      mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),
        ['<Esc>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp.mapping(function (fallback)
            if luasnip.expandable() then
                luasnip.expand()
            elseif cmp.visible() then
                cmp.confirm({select = true})
            elseif luasnip.jumpable(1) then
                luasnip.jump(1) 
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function (fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
      },
      -- enabled = function()
      --   -- disable completion in comments
      --   local context = require('cmp.config.context')
      --   -- keep command mode completion enabled when cursor is in a comment
      --   if vim.api.nvim_get_mode().mode == 'c' then
      --     return true
      --   else
      --     return not context.in_treesitter_capture("comment") 
      --       and not context.in_syntax_group("Comment")
      --   end
      -- end
    })
    
    -- vscode like theme
    -- gray
    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
    -- blue
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
    -- light blue
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
    -- pink
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
    -- front
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

    -- insert parenthesis after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    -- Diagnostics
    local sign = function(opts)
      vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
      })
    end

    sign({name = 'DiagnosticSignError', text = '✘'})
    sign({name = 'DiagnosticSignWarn', text = '▲'})
    sign({name = 'DiagnosticSignHint', text = '⚑'})
    sign({name = 'DiagnosticSignInfo', text = ''})

    vim.diagnostic.config({
      severity_sort = true,
      float = {
        border = 'rounded',
        source = 'always',
      },
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
      vim.lsp.handlers.hover,
      {border = 'rounded'}
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      {border = 'rounded'}
    )

  end,
}
