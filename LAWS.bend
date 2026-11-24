# The laws of this project: each is an open claim here, proven in PROOF.bend.
import Base
import ./html.bend as H

# Examples
# ========

def page() -> H.Node:
  H.div([H.cls("card"), H.id("main")], [
    H.h1_([H.text("Hello")]),
    H.p_([H.text("1 < 2 & 3"), H.br()]),
    H.img([H.src("cat.png"), H.alt("A \"cat\"")]),
    H.ul_([
      H.li_([H.a([H.href("/a")], [H.text("A")])]),
      H.lit("B")]),
    H.raw("<b>as given</b>")])

law renders_a_page:
  {H.render(page()) == "<div class=\"card\" id=\"main\"><h1>Hello</h1><p>1 &lt; 2 &amp; 3<br></p><img src=\"cat.png\" alt=\"A &quot;cat&quot;\"><ul><li><a href=\"/a\">A</a></li><li>B</li></ul><b>as given</b></div>" : String}

law renders_text_helpers:
  {H.render_all([H.h1t("Title"), H.pt("a < b"), H.ol_([H.lit("one"), H.lit("two")])]) == "<h1>Title</h1><p>a &lt; b</p><ol><li>one</li><li>two</li></ol>" : String}

law renders_form_attributes:
  {H.render(H.form([H.action("/save"), H.method("post")], [H.input([H.type_("checkbox"), H.name("ok"), H.checked(), H.disabled(), H.data("id", "7")])])) == "<form action=\"/save\" method=\"post\"><input type=\"checkbox\" name=\"ok\" checked disabled data-id=\"7\"></form>" : String}

law renders_a_document:
  {H.document(H.html([H.lang("da")], [H.body_([])])) == "<!DOCTYPE html><html lang=\"da\"><body></body></html>" : String}

# Escaping, for every string
# ==========================

law classifies_special_chars:
  {[H.special('&'), H.special('<'), H.special('>'), H.special('"'), H.special('a'), H.special('\'')] == [H.Amp{}, H.Lt{}, H.Gt{}, H.Quot{}, H.Plain{}, H.Plain{}] : List<&2, H.Special>}

# A char that can open or close a tag or end a quoted attribute value.
def is_markup(k: H.Special) -> Bool:
  match k:
    case H.Lt{}:
      True{}
    case H.Gt{}:
      True{}
    case H.Quot{}:
      True{}
    case _:
      False{}

def has_markup(s: String) -> Bool:
  match s:
    case SNil{}:
      False{}
    case SCon{+c, t}:
      is_markup(H.special(c)) || has_markup(t)

# Escaped text has no <, > or ": it cannot open a tag or end an attribute.
law escaped_has_no_markup:
  for s: String
  {has_markup(H.escape(s)) == False{} : Bool}

law text_is_escaped:
  for s: String
  {H.render(H.text(s)) == H.escape(s) : String}

law attribute_value_is_escaped:
  for +s: String
  {H.render(H.div([H.cls(s)], [])) == String.append("<div class=\"", String.append(H.escape(s), "\"></div>")) : String}

# Unescaping what escape wrote gives the string back: escaping loses nothing.
law escaping_loses_nothing:
  for s: String
  {H.unescape(H.escape(s)) == s : String}

law unescapes:
  {H.unescape("a &lt;b&gt; &amp; &quot;c&quot; & d &x;") == "a <b> & \"c\" & d &x;" : String}
