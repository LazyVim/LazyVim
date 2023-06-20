return {
  "goolord/alpha-nvim",
  opt = function(_, opts)
    local logo = [[
      [@anjokoi]
    ]]
    opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
  end,
}
