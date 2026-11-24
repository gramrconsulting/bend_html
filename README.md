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
div span p h1`..`h6 a strong em code pre blockquote table thead tbody tr th td
form label button textarea select option figure figcaption`. `main` is
`main_tag`, since `main` names a program's entry.

Text helpers: `titlet pt spant h1t`..`h6t strongt emt codet pret tht tdt labelt
buttont optiont figcaptiont`, and `lit` for a list item.

A `ul` or an `ol` holds `H.Li` items only: `H.li(attrs, children)`, `H.li_(children)`
or `H.lit(text)`.

## Attributes and text

| Def | Writes |
|---|---|
| `cls id href src alt title_attr type_ name value placeholder for_ rel charset content lang action method` | `name="value"`, the value escaped |
| `disabled() checked()` | the bare name |
| `data(name, value)` | `data-name="value"` |
| `text(s)` | `s` escaped |
| `raw(s)` | `s` as given: the one way to write markup from a string |

`render(node)`, `render_all(nodes)`, `document(node)` (with `<!DOCTYPE html>`),
`escape(s)` and `unescape(s)`. Escaping turns `& < > "` into entities.

## Laws

`LAWS.bend` states them, `PROOF.bend` proves them. For every string or list:

- `escaped_has_no_markup`: escaped text holds no `<`, `>` or `"`, so it cannot open a tag or end an attribute.
- `text_is_escaped`, `attribute_value_is_escaped`: text and attribute values are written escaped.
- `escaping_loses_nothing`: `unescape(escape(s)) == s`.
- `ul_holds_only_li`, `ol_holds_only_li`: every child of a `ul` or an `ol` is an `li`.

The rest are examples: a page, the text helpers, form attributes, a document.

```bash
./check.sh    # bend PROOF.bend must print ALL PROOFS CHECK
```

`unesc_char` in `PROOF.bend` has 120 cases: one per escaped char and one per set
of chars that share the bits telling them apart, as `bend_json`'s `gen_tree.py` makes them.

## Limits

- `raw` and the name in `data(name, value)` are written as given: never pass them untrusted text.
- No `script` or `style` elements: their content is not HTML-escaped text. Use `raw` with care.
- Only lists have a content model; a `tr` outside a `table` passes the checker.
- `bend PROOF.bend --verdict`, the second check by the kernel proven in Lean, has not been run.
