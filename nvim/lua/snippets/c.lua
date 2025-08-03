local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

return {
  -- “func” snippet: return-type name(args) { body }
  s("func", {
    i(1, "int"), t(" "),
    i(2, "name"), t("("),
    i(3, "void"), t({ ") {", "\t" }),
    i(4, "// body"),
    t({ "", "}" }),
  }),
  -- “func” snippet: return-type name(args) { body }
  s('if', {
    t("if "),
    i(2, "name"), t("{"),
    i(3, "void"), t({ ") {", "\t" }),
    i(4, "// body"),
    t({ "", "}" }),
  }),
}

