---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  version = "^19.21.0",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup {
      -- Based on https://codecompanion.olimorris.dev/configuration/adapters-http#llama-cpp-with-reasoning-format-deepseek
      adapters = {
        http = {
          ["llama.cpp"] = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "http://127.0.0.1:8088",
                api_key = "TERM",
              },
              handlers = {
                parse_message_meta = function(self, data)
                  local extra = data.extra
                  if extra and extra.reasoning_content then
                    data.output.reasoning = { content = extra.reasoning_content }
                    if data.output.content == "" then data.output.content = nil end
                  end
                  return data
                end,
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "llama.cpp",
        },
        inline = {
          adapter = "llama.cpp",
        },
        cmd = {
          adapter = "llama.cpp",
        },
        background = {
          adapter = "llama.cpp",
        },
      },
    }
  end,
}
