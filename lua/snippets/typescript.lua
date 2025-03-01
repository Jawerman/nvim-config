local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

function filename_matches(pattern)
  local filename = vim.fn.expand("%:t")
  return filename:match(pattern)
end

function is_test()
  return filename_matches("%.spec%.ts$")
end

ls.add_snippets("typescript", {
  s(
    {
      trig = "desc",
      condition = is_test,
      name = "describe",
      dexc = "describe('when...', => {});",
    },
    fmt(
      [[
      describe('{}', () => {{
        {}
      }});
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    {
      trig = "it",
      condition = is_test,
      name = "it",
      dexc = "test it",
    },
    fmt(
      [[
      it('{}', () => {{
        {}
      }});
    ]],
      { i(1), i(0) }
    )
  ),
  s(
    {
      trig = "be",
      condition = is_test,
      name = "beforeEach",
      dexc = "beforeEach(() => {});",
    },
    fmt(
      [[
        beforeEach(() => {{
          {}
        }});
        ]],
      { i(0) }
    )
  ),
  s(
    {
      trig = "ae",
      condition = is_test,
      name = "afterEach",
      dexc = "afterEach(() => {});",
    },
    fmt(
      [[
        afterEach(() => {{
          {}
        }});
        ]],
      { i(0) }
    )
  ),
})
