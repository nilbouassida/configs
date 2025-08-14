local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

return {
  -- Function: fn name(args) -> ReturnType { body }
  s("fn", {
    t("fn "), i(1, "name"), t("("), i(2), t(")"),
    t(" -> "), i(3, "ReturnType"), t({ " {", "\t" }),
    i(4, "// body"),
    t({ "", "}" }),
  }),

  -- Main function: fn main() { ... }
  s("main", {
    t({ "fn main() {", "\t" }),
    i(1, "// body"),
    t({ "", "}" }),
  }),

  -- let binding
  s("let", {
    t("let "), i(1, "var"), t(": "), i(2, "Type"),
    t(" = "), i(3, "value"), t(";"),
  }),

  -- let mutable binding
  s("letm", {
    t("let mut "), i(1, "var"), t(": "), i(2, "Type"),
    t(" = "), i(3, "value"), t(";"),
  }),

  -- const binding
  s("const", {
    t("const "), i(1, "NAME"), t(": "), i(2, "Type"),
    t(" = "), i(3, "value"), t(";"),
  }),

  -- static binding
  s("static", {
    t("static "), i(1, "NAME"), t(": "), i(2, "Type"),
    t(" = "), i(3, "value"), t(";"),
  }),

  -- If statement
  s("if", {
    t("if "), i(1, "condition"), t({ " {", "\t" }),
    i(2, "// body"),
    t({ "", "}" }),
  }),

  -- If / else statement
  s("ife", {
    t("if "), i(1, "condition"), t({ " {", "\t" }),
    i(2, "// if body"),
    t({ "", "} else {", "\t" }),
    i(3, "// else body"),
    t({ "", "}" }),
  }),

  -- Struct
  s("struct", {
    t("struct "), i(1, "Name"), t({ " {", "\t" }),
    i(2, "field: Type"),
    t({ "", "}" }),
  }),

  -- Impl block
  s("impl", {
    t("impl "), i(1, "Name"), t({ " {", "\t" }),
    i(2, "// methods"),
    t({ "", "}" }),
  }),

  -- For loop
  s("for", {
    t("for "), i(1, "item"), t(" in "), i(2, "iterable"),
    t({ " {", "\t" }),
    i(3, "// body"),
    t({ "", "}" }),
  }),

  -- While loop
  s("while", {
    t("while "), i(1, "condition"), t({ " {", "\t" }),
    i(2, "// body"),
    t({ "", "}" }),
  }),

  -- Match statement
  s("match", {
    t("match "), i(1, "value"), t({ " {", "\t" }),
    i(2, "Pattern"), t(" => "), i(3, "// body"),
    t({ ",", "\t_ => {}", "" }),
    t("}"),
  }),
}

