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

# Lists, for every list of items
# ==============================

def all_li(ns: List<&2, H.Node>) -> Bool:
  match ns:
    case Nil{}:
      True{}
    case H.Elem{tag, attrs, children} <> rest:
      String.eq(tag, "li") && all_li(rest)
    case _ <> rest:
      False{}

def holds_only_li(n: H.Node) -> Bool:
  match n:
    case H.Elem{tag, attrs, children}:
      all_li(children)
    case _:
      False{}

law ul_holds_only_li:
  for attrs: List<&2, H.Attr>
  for items: List<&2, H.Li>
  {holds_only_li(H.ul(attrs, items)) == True{} : Bool}

law ol_holds_only_li:
  for attrs: List<&2, H.Attr>
  for items: List<&2, H.Li>
  {holds_only_li(H.ol(attrs, items)) == True{} : Bool}

# Tables, for every table
# =======================

def is_cell(+tag: String) -> Bool:
  String.eq(tag, "th") || String.eq(tag, "td")

def is_section(+tag: String) -> Bool:
  String.eq(tag, "thead") || String.eq(tag, "tbody") || String.eq(tag, "tfoot")

def all_cells(ns: List<&2, H.Node>) -> Bool:
  match ns:
    case Nil{}:
      True{}
    case H.Elem{tag, attrs, children} <> rest:
      is_cell(tag) && all_cells(rest)
    case _ <> rest:
      False{}

def all_rows(ns: List<&2, H.Node>) -> Bool:
  match ns:
    case Nil{}:
      True{}
    case H.Elem{tag, attrs, children} <> rest:
      String.eq(tag, "tr") && all_cells(children) && all_rows(rest)
    case _ <> rest:
      False{}

def all_sections(ns: List<&2, H.Node>) -> Bool:
  match ns:
    case Nil{}:
      True{}
    case H.Elem{tag, attrs, children} <> rest:
      is_section(tag) && all_rows(children) && all_sections(rest)
    case _ <> rest:
      False{}

def well_formed_table(n: H.Node) -> Bool:
  match n:
    case H.Elem{tag, attrs, children}:
      String.eq(tag, "table") && all_sections(children)
    case _:
      False{}

# A table holds thead, tbody or tfoot; they hold tr; a tr holds th or td.
law table_is_well_formed:
  for attrs: List<&2, H.Attr>
  for sections: List<&2, H.Section>
  {well_formed_table(H.table(attrs, sections)) == True{} : Bool}

law renders_a_table:
  {H.render(H.table([H.cls("t")], [H.thead_([H.tr_([H.tht("Name"), H.tht("Age")])]), H.tbody_([H.tr_([H.tdt("Ada"), H.td([H.cls("n")], [H.text("36")])])])])) == "<table class=\"t\"><thead><tr><th>Name</th><th>Age</th></tr></thead><tbody><tr><td>Ada</td><td class=\"n\">36</td></tr></tbody></table>" : String}

# Style and script, for every text
# ================================

law classifies_guarded_chars:
  {[H.near('<'), H.near('/'), H.near('!'), H.near('a'), H.near('\\')] == [H.LtChar{}, H.Shut{}, H.Shut{}, H.Else{}, H.Else{}] : List<&2, H.Near>}

def is_shut(k: H.Near) -> Bool:
  match k:
    case H.Shut{}:
      True{}
    case _:
      False{}

# Whether `s` holds a < followed by / or !; `after_lt`: the char before was <.
def closes(s: String, after_lt: Bool) -> Bool:
  match s:
    case SNil{}:
      False{}
    case SCon{+c, t}:
      (after_lt && is_shut(H.near(c))) || closes(t, H.is_lt(H.near(c)))

# Guarded text holds no </ or <!, so it cannot close a style or script element.
law guarded_text_cannot_close:
  for s: String
  {closes(H.guard(s, False{}, ""), False{}) == False{} : Bool}

law style_text_is_guarded:
  for +s: String
  {H.render(H.style_(s)) == String.append("<style>", String.append(H.guard(s, False{}, ""), "</style>")) : String}

law script_text_is_guarded:
  for +s: String
  {H.render(H.script_(s)) == String.append("<script>", String.append(H.guard(s, False{}, ""), "</script>")) : String}

law renders_style_and_script:
  {H.render_all([H.style_("a::after { content: \"</style>\" }"), H.script([H.src("a.js")], ""), H.script_("if (a < b) x = \"<!--\";"), H.p([H.style_attr("color: red")], [])]) == "<style>a::after { content: \"<\\/style>\" }</style><script src=\"a.js\"></script><script>if (a < b) x = \"<\\!--\";</script><p style=\"color: red\"></p>" : String}
