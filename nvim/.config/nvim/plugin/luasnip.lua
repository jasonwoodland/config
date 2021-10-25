local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")

ls.config.set_config({
  updateevents = "TextChanged,TextChangedI",
})

local jsts = {
  s('log', {
    t('console.log('),
    i(1),
    t(');'),
    i(0),
  }),

  s({trig='rs', name='useState'}, {
    t('const ['),
    i(1),
    t(', set'),
    l(l._1:gsub('^%l', string.upper), 1),
    t('] = useState'),
    i(2),
    t('('),
    i(3),
    t(');'),
    i(0),
  })
}

ls.snippets = {
  javascriptreact = jsts,
  typescriptreact = jsts,
}
