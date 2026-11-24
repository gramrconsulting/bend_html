# bend_html

Typed HTML for Bend 2: one def per element, typed attributes, end tags
written for you, text and attribute values always escaped. Pure Bend with no
effects, so your own laws may depend on it.

```python
import Base
import ../bend_html/html.bend as H

def page() -> H.Node:
  H.div([H.cls("card")], [
    H.h1t("Hello"),
    H.p_([H.text("1 < 2"), H.br()]),
    H.img([H.src("cat.png"), H.alt("A cat")]),
    H.ul_([H.lit("one"), H.li_([H.a([H.href("/two")], [H.text("two")])])])])
```

`H.render(page())` gives
`<div class="card"><h1>Hello</h1><p>1 &lt; 2<br></p><img src="cat.png" alt="A cat"><ul><li>one</li><li><a href="/two">two</a></li></ul></div>`.

The checker refuses markup that is not HTML: a `p` inside a `ul` (`expected : H.Li`),
children given to `br`, a misspelt attribute (`expected : a defined name`), a bare
string as a child (`expected : H.Node`).

## Elements

| Form | Example | For |
|---|---|---|
| `tag(attrs, children)` | `H.div([H.cls("a")], [..])` | every element below |
| `tag_(children)` | `H.div_([..])` | the same, no attributes |
| `tagt(text)` | `H.h1t("Hi")` | one escaped text child, no attributes |
| `void(attrs)` | `H.img([H.src("a.png")])` | `img input meta link`; `H.br()` and `H.hr()` take nothing |

Elements: `html head body title header footer main_tag nav section article aside
div span p h1`..`h6 a strong em code pre blockquote
form label button textarea select option figure figcaption`. `main` is
`main_tag`, since `main` names a program's entry.

Text helpers: `titlet pt spant h1t`..`h6t strongt emt codet pret labelt
buttont optiont figcaptiont`, and `lit` for a list item.

A `ul` or an `ol` holds `H.Li` items only: `H.li(attrs, children)`, `H.li_(children)`
or `H.lit(text)`.

A table is typed the same way: `table` holds sections (`thead tbody tfoot`), a section
holds rows (`tr`), a row holds cells (`th td`, or `tht tdt` for text). Each has a `_` form.

```python
H.table_([
  H.thead_([H.tr_([H.tht("Name"), H.tht("Age")])]),
  H.tbody_([H.tr_([H.tdt("Ada"), H.tdt("36")])])])
```

## Attributes and text

| Def | Writes |
|---|---|
| `cls id href src alt title_attr type_ name value placeholder for_ rel charset content lang action method` | `name="value"`, the value escaped |
| `style_attr(css)` | `style="css"`, escaped |
| `disabled() checked()` | the bare name |
| `data(name, value)` | `data-name="value"` |
| `text(s)` | `s` escaped |
| `raw(s)` | `s` as given: the one way to write markup from a string |
| `style(attrs, css)`, `style_(css)` | `<style>css</style>`, guarded |
| `script(attrs, js)`, `script_(js)` | `<script>js</script>`, guarded |

CSS and JavaScript are not HTML, so they are not escaped: `a < b` stays as it is.
They are guarded instead: a `\` goes between `<` and a following `/` or `!`, so
`"</style>"` in the text becomes `"<\/style>"` and cannot close the element. In
CSS and JavaScript strings `\/` and `\!` mean `/` and `!`.

`render(node)`, `render_all(nodes)`, `document(node)` (with `<!DOCTYPE html>`),
`escape(s)` and `unescape(s)`. Escaping turns `& < > "` into entities.

## Laws

`LAWS.bend` states them, `PROOF.bend` proves them. For every string or list:

- `escaped_has_no_markup`: escaped text holds no `<`, `>` or `"`, so it cannot open a tag or end an attribute.
- `text_is_escaped`, `attribute_value_is_escaped`: text and attribute values are written escaped.
- `escaping_loses_nothing`: `unescape(escape(s)) == s`.
- `ul_holds_only_li`, `ol_holds_only_li`: every child of a `ul` or an `ol` is an `li`.
- `table_is_well_formed`: a table holds only sections, a section only rows, a row only cells.
- `guarded_text_cannot_close`: guarded text holds no `</` or `<!`, so it cannot close a `style` or `script` element.
- `style_text_is_guarded`, `script_text_is_guarded`: their text is written guarded.

The rest are examples: a page, the text helpers, form attributes, a document, a table, style and script.

```bash
./check.sh    # bend PROOF.bend must print ALL PROOFS CHECK
```

`unesc_char` in `PROOF.bend` has 120 cases: one per escaped char and one per set
of chars that share the bits telling them apart, as `bend_json`'s `gen_tree.py` makes them.

## Limits

- `raw` and the name in `data(name, value)` are written as given: never pass them untrusted text.
- The constructors `H.Elem`, `H.Void`, `H.Txt` and `H.Raw` are public: a tag name given to `H.Elem` or `H.Void` is written as given.
- Guarding changes `</` and `<!` outside strings too, which valid CSS and JavaScript only have in comments and regular expressions.
- The CSS or JavaScript itself is not checked: never pass untrusted text to `style` or `script`.
- Only lists and tables have a content model; a `div` inside a `p` passes the checker.
- `bend PROOF.bend --verdict`, the second check by the kernel proven in Lean, has not been run.
