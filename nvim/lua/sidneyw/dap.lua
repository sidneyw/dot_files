require("dap-go").setup()
require("nvim-dap-virtual-text").setup()
require("dapui").setup()

vim.cmd [[ nnoremap <silent> <leader>dt :lua require'dap'.toggle_breakpoint()<CR> ]]
vim.cmd [[ nnoremap <silent> <leader>dc :lua require('dap').continue()<CR> ]]
vim.cmd [[ nnoremap <silent> <leader>td :lua require('dap-go').debug_test()<CR> ]]
vim.cmd [[ nnoremap <silent> <leader>dv :lua require'telescope'.extensions.dap.variables{}<CR> ]]
vim.cmd [[ nnoremap <silent> <leader>do :lua require('dapui').toggle()<CR> ]]
