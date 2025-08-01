local wk = require("which-key")

local M = {}

function M.setup()
  wk.add({
    {
      "<leader>hr",
      function()
        require("plugins.hurl.core").run_hurl_file()
      end,
      desc = "Run Hurl file",
    },
    {
      "<leader>ht",
      function()
        require("plugins.hurl.core").run_hurl_test()
      end,
      desc = "Run Hurl file (test mode)",
    },
    {
      "<leader>hv",
      function()
        require("plugins.hurl.core").run_hurl_verbose()
      end,
      desc = "Run Hurl file (verbose)",
    },
    {
      "<leader>hT",
      function()
        require("plugins.hurl.core").run_hurl_test_verbose()
      end,
      desc = "Run Hurl file (test + verbose)",
    },
    {
      "<leader>hf",
      function()
        require("plugins.hurl.ui").cycle_output_format()
      end,
      desc = "Cycle Hurl output format",
    },
  })
end

return M