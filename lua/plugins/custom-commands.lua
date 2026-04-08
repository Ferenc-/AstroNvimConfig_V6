vim.api.nvim_create_user_command("RemoveTrailingWhitespaces", ':%s/\\s\\+$', {})

return {}
