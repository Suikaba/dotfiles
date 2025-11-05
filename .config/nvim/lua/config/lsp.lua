vim.lsp.enable({
    --- See https://github.com/neovim/nvim-lspconfig/blob/master/lsp/*
    "lua_ls",
    "clangd",
})


-- keybindings memo
-- <C-w>d : show diagnostic message
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local buf = args.buf

    if client:supports_method("textDocument/definition") then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
    end

    if client:supports_method("textDocument/hover") then
      vim.keymap.set("n", "<Leader>k",
        function() vim.lsp.buf.hover({ border = "single" }) end,
        { buffer = buf, desc = "Show hover documentation" })
    end

    if client:supports_method("textDocument/completion") then
      -- Use CTRL-space to trigger LSP completion manually.
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)

      if client.server_capabilities.completionProvider then
        -- Trigger autocompletion on every keypress. May be slow!
        local tmp_chars = {}; for i = 32, 126 do table.insert(tmp_chars, string.char(i)) end
        local trigger_chars = tmp_chars
        local additional_chars = { '.', ':', '->', '::' }
        for _, char in ipairs(additional_chars) do
          table.insert(trigger_chars, char)
        end
        client.server_capabilities.completionProvider.triggerCharacters = trigger_chars
      end

      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
        convert = function (item)
          return { abbr = item.label:gsub('%b()', '') }
        end,
      })
    end
  end,
})
