return {
  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      model = "codellama:13b",
      url = "http://127.0.0.1:11434",
    },
  },
  {
    "linw1995/nvim-mcp",
    build = "cargo install --path .",
    opts = {},
  },
}
