local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- JS, TS, JSX, TSX
for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
	ls.add_snippets(lang, {
		s("cl", { t("console.log("), i(1), t(");") }),
		s("afunc", {
			t("const "),
			i(1, "fn"),
			t(" = async ("),
			i(2),
			t({ ") => {", "\t" }),
			i(3, "// TODO"),
			t({ "", "}" }),
		}),
		s("for", {
			t("for (let "),
			i(1, "i"),
			t(" = "),
			i(2, "0"),
			t("; "),
			i(1),
			t(" < "),
			i(3, "len"),
			t("; "),
			i(1),
			t({ "++) {", "\t" }),
			i(4, "// do stuff"),
			t({ "", "}" }),
		}),

		s("while", {
			t("while ("),
			i(1, "condition"),
			t({ ") {", "\t" }),
			i(2, "// loop body"),
			t({ "", "}" }),
		}),
		s("ue", {
			t({ "useEffect(() => {", "\t" }),
			i(1, ""),
			t({ "", "}, [" }),
			i(2, ""),
			t("]);"),
		}),
		s("us", {
			t("const ["),
			i(1, "state"),
			t(", set"),
			i(2, "State"),
			t("] = useState("),
			i(3, ""),
			t(");"),
		}),
		s("comp", {
			t("const "),
			i(1, "Component"),
			t({ " = () => {", "\t" }),
			t("return ("),
			t({ "", "\t\t" }),
			i(2, "<div></div>"),
			t({ "", "\t);", "};" }),
		}),
		s("try", {
			t({ "try {", "\t" }),
			i(1, "// risky business"),
			t({ "", "} catch (err) {", "\tconsole.error(err);" }),
			t({ "", "}" }),
		}),
	})
end

-- Python
ls.add_snippets("python", {
	s("pr", { t("print("), i(1), t(")") }),
	s("def", {
		t("def "),
		i(1, "func"),
		t("("),
		i(2),
		t({ "):", "\t" }),
		i(3, "pass"),
	}),
	s("class", {
		t("class "),
		i(1, "ClassName"),
		t({ ":", "\t" }),
		i(2, "def __init__(self):"),
		t({ "", "\t\t" }),
		i(3, "pass"),
	}),
	s("main", {
		t({ 'if __name__ == "__main__":', "\t" }),
		i(1, "main()"),
	}),
	s("for", {
		t("for "),
		i(1, "item"),
		t(" in "),
		i(2, "iterable"),
		t({ ":", "\t" }),
		i(3, "pass"),
	}),
	s("while", {
		t("while "),
		i(1, "condition"),
		t({ ":", "\t" }),
		i(2, "pass"),
	}),
	s("try", {
		t({ "try:", "\t" }),
		i(1, "pass"),
		t({ "", "except " }),
		i(2, "Exception"),
		t({ " as e:", "\t" }),
		i(3, "print(e)"),
	}),

	s("adef", {
		t("async def "),
		i(1, "func"),
		t("("),
		i(2),
		t({ "):", "\t" }),
		i(3, "pass"),
	}),
})
