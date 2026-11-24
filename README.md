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
    H.ul_([H.lit("one"), H.lit("two")])])
```

`H.render(page())` gives `<div class="card"><h1>Hello</h1><p>1 &lt; 2<br></p><ul><li>one</li><li>two</li></ul></div>`.

```bash
./check.sh    # bend PROOF.bend must print ALL PROOFS CHECK
```
