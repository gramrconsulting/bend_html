# Typed HTML for Bend 2: one def per element, typed attributes, end tags
# written for you. Import as `H`. Pure: no effects, so laws may depend on it.
import Base

# Values
# ======

type Attr is Data:
  Class{value: String}
  Id{value: String}
  Href{value: String}
  Src{value: String}
  Alt{value: String}
  TitleAttr{value: String}
  InputType{value: String}
  Name{value: String}
  Value{value: String}
  Placeholder{value: String}
  ForAttr{value: String}
  Rel{value: String}
  Charset{value: String}
  Content{value: String}
  Lang{value: String}
  Action{value: String}
  Method{value: String}
  Disabled{}
  Checked{}
  DataAttr{name: String, value: String}

type Node is Data:
  Elem{tag: String, attrs: List<&2, Attr>, children: List<&2, Node>}
  Void{tag: String, attrs: List<&2, Attr>}
  Txt{value: String}
  Raw{value: String}

# A list item: the only thing a ul or an ol holds.
type Li is Data:
  Li{attrs: List<&2, Attr>, children: List<&2, Node>}

# Attributes
# ==========

def cls(s: String) -> Attr:
  Class{s}

def id(s: String) -> Attr:
  Id{s}

def href(s: String) -> Attr:
  Href{s}

def src(s: String) -> Attr:
  Src{s}

def alt(s: String) -> Attr:
  Alt{s}

def title_attr(s: String) -> Attr:
  TitleAttr{s}

def type_(s: String) -> Attr:
  InputType{s}

def name(s: String) -> Attr:
  Name{s}

def value(s: String) -> Attr:
  Value{s}

def placeholder(s: String) -> Attr:
  Placeholder{s}

def for_(s: String) -> Attr:
  ForAttr{s}

def rel(s: String) -> Attr:
  Rel{s}

def charset(s: String) -> Attr:
  Charset{s}

def content(s: String) -> Attr:
  Content{s}

def lang(s: String) -> Attr:
  Lang{s}

def action(s: String) -> Attr:
  Action{s}

def method(s: String) -> Attr:
  Method{s}

def disabled() -> Attr:
  Disabled{}

def checked() -> Attr:
  Checked{}

# data-<name>="<value>"; the name is written as given.
def data(name: String, s: String) -> Attr:
  DataAttr{name, s}

# Text
# ====

def text(s: String) -> Node:
  Txt{s}

# Written as given, unescaped: the one way to put markup in from a string.
def raw(s: String) -> Node:
  Raw{s}

# Elements
# ========

def html(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"html", attrs, children}

def head(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"head", attrs, children}

def body(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"body", attrs, children}

def title(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"title", attrs, children}

def header(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"header", attrs, children}

def footer(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"footer", attrs, children}

def main_tag(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"main", attrs, children}

def nav(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"nav", attrs, children}

def section(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"section", attrs, children}

def article(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"article", attrs, children}

def aside(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"aside", attrs, children}

def div(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"div", attrs, children}

def span(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"span", attrs, children}

def p(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"p", attrs, children}

def h1(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"h1", attrs, children}

def h2(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"h2", attrs, children}

def h3(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"h3", attrs, children}

def h4(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"h4", attrs, children}

def h5(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"h5", attrs, children}

def h6(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"h6", attrs, children}

def a(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"a", attrs, children}

def strong(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"strong", attrs, children}

def em(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"em", attrs, children}

def code(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"code", attrs, children}

def pre(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"pre", attrs, children}

def blockquote(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"blockquote", attrs, children}

def table(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"table", attrs, children}

def thead(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"thead", attrs, children}

def tbody(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"tbody", attrs, children}

def tr(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"tr", attrs, children}

def th(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"th", attrs, children}

def td(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"td", attrs, children}

def form(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"form", attrs, children}

def label(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"label", attrs, children}

def button(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"button", attrs, children}

def textarea(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"textarea", attrs, children}

def select(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"select", attrs, children}

def option(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"option", attrs, children}

def figure(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"figure", attrs, children}

def figcaption(attrs: List<&2, Attr>, children: List<&2, Node>) -> Node:
  Elem{"figcaption", attrs, children}

# Void elements take no children.

def br() -> Node:
  Void{"br", []}

def hr() -> Node:
  Void{"hr", []}

def img(attrs: List<&2, Attr>) -> Node:
  Void{"img", attrs}

def input(attrs: List<&2, Attr>) -> Node:
  Void{"input", attrs}

def meta(attrs: List<&2, Attr>) -> Node:
  Void{"meta", attrs}

def link(attrs: List<&2, Attr>) -> Node:
  Void{"link", attrs}

# Without attributes
# ==================

def html_(children: List<&2, Node>) -> Node:
  Elem{"html", [], children}

def head_(children: List<&2, Node>) -> Node:
  Elem{"head", [], children}

def body_(children: List<&2, Node>) -> Node:
  Elem{"body", [], children}

def title_(children: List<&2, Node>) -> Node:
  Elem{"title", [], children}

def header_(children: List<&2, Node>) -> Node:
  Elem{"header", [], children}

def footer_(children: List<&2, Node>) -> Node:
  Elem{"footer", [], children}

def main_tag_(children: List<&2, Node>) -> Node:
  Elem{"main", [], children}

def nav_(children: List<&2, Node>) -> Node:
  Elem{"nav", [], children}

def section_(children: List<&2, Node>) -> Node:
  Elem{"section", [], children}

def article_(children: List<&2, Node>) -> Node:
  Elem{"article", [], children}

def aside_(children: List<&2, Node>) -> Node:
  Elem{"aside", [], children}

def div_(children: List<&2, Node>) -> Node:
  Elem{"div", [], children}

def span_(children: List<&2, Node>) -> Node:
  Elem{"span", [], children}

def p_(children: List<&2, Node>) -> Node:
  Elem{"p", [], children}

def h1_(children: List<&2, Node>) -> Node:
  Elem{"h1", [], children}

def h2_(children: List<&2, Node>) -> Node:
  Elem{"h2", [], children}

def h3_(children: List<&2, Node>) -> Node:
  Elem{"h3", [], children}

def h4_(children: List<&2, Node>) -> Node:
  Elem{"h4", [], children}

def h5_(children: List<&2, Node>) -> Node:
  Elem{"h5", [], children}

def h6_(children: List<&2, Node>) -> Node:
  Elem{"h6", [], children}

def a_(children: List<&2, Node>) -> Node:
  Elem{"a", [], children}

def strong_(children: List<&2, Node>) -> Node:
  Elem{"strong", [], children}

def em_(children: List<&2, Node>) -> Node:
  Elem{"em", [], children}

def code_(children: List<&2, Node>) -> Node:
  Elem{"code", [], children}

def pre_(children: List<&2, Node>) -> Node:
  Elem{"pre", [], children}

def blockquote_(children: List<&2, Node>) -> Node:
  Elem{"blockquote", [], children}

def table_(children: List<&2, Node>) -> Node:
  Elem{"table", [], children}

def thead_(children: List<&2, Node>) -> Node:
  Elem{"thead", [], children}

def tbody_(children: List<&2, Node>) -> Node:
  Elem{"tbody", [], children}

def tr_(children: List<&2, Node>) -> Node:
  Elem{"tr", [], children}

def th_(children: List<&2, Node>) -> Node:
  Elem{"th", [], children}

def td_(children: List<&2, Node>) -> Node:
  Elem{"td", [], children}

def form_(children: List<&2, Node>) -> Node:
  Elem{"form", [], children}

def label_(children: List<&2, Node>) -> Node:
  Elem{"label", [], children}

def button_(children: List<&2, Node>) -> Node:
  Elem{"button", [], children}

def textarea_(children: List<&2, Node>) -> Node:
  Elem{"textarea", [], children}

def select_(children: List<&2, Node>) -> Node:
  Elem{"select", [], children}

def option_(children: List<&2, Node>) -> Node:
  Elem{"option", [], children}

def figure_(children: List<&2, Node>) -> Node:
  Elem{"figure", [], children}

def figcaption_(children: List<&2, Node>) -> Node:
  Elem{"figcaption", [], children}

# Holding only text
# =================

def titlet(s: String) -> Node:
  Elem{"title", [], [Txt{s}]}

def pt(s: String) -> Node:
  Elem{"p", [], [Txt{s}]}

def spant(s: String) -> Node:
  Elem{"span", [], [Txt{s}]}

def h1t(s: String) -> Node:
  Elem{"h1", [], [Txt{s}]}

def h2t(s: String) -> Node:
  Elem{"h2", [], [Txt{s}]}

def h3t(s: String) -> Node:
  Elem{"h3", [], [Txt{s}]}

def h4t(s: String) -> Node:
  Elem{"h4", [], [Txt{s}]}

def h5t(s: String) -> Node:
  Elem{"h5", [], [Txt{s}]}

def h6t(s: String) -> Node:
  Elem{"h6", [], [Txt{s}]}

def strongt(s: String) -> Node:
  Elem{"strong", [], [Txt{s}]}

def emt(s: String) -> Node:
  Elem{"em", [], [Txt{s}]}

def codet(s: String) -> Node:
  Elem{"code", [], [Txt{s}]}

def pret(s: String) -> Node:
  Elem{"pre", [], [Txt{s}]}

def tht(s: String) -> Node:
  Elem{"th", [], [Txt{s}]}

def tdt(s: String) -> Node:
  Elem{"td", [], [Txt{s}]}

def labelt(s: String) -> Node:
  Elem{"label", [], [Txt{s}]}

def buttont(s: String) -> Node:
  Elem{"button", [], [Txt{s}]}

def optiont(s: String) -> Node:
  Elem{"option", [], [Txt{s}]}

def figcaptiont(s: String) -> Node:
  Elem{"figcaption", [], [Txt{s}]}

def lit(s: String) -> Li:
  Li{[], [Txt{s}]}

# Lists
# =====

def li(attrs: List<&2, Attr>, children: List<&2, Node>) -> Li:
  Li{attrs, children}

def li_(children: List<&2, Node>) -> Li:
  Li{[], children}

def li_node(i: Li) -> Node:
  match i:
    case Li{attrs, children}:
      Elem{"li", attrs, children}

def li_nodes(items: List<&2, Li>) -> List<&2, Node>:
  match items:
    case Nil{}:
      []
    case i <> rest:
      li_node(i) <> li_nodes(rest)

def ul(attrs: List<&2, Attr>, items: List<&2, Li>) -> Node:
  Elem{"ul", attrs, li_nodes(items)}

def ul_(items: List<&2, Li>) -> Node:
  ul([], items)

def ol(attrs: List<&2, Attr>, items: List<&2, Li>) -> Node:
  Elem{"ol", attrs, li_nodes(items)}

def ol_(items: List<&2, Li>) -> Node:
  ol([], items)

# Escaping
# ========

# The chars escaping is about; every other char is Plain.
type Special is Data:
  Amp{}
  Lt{}
  Gt{}
  Quot{}
  Plain{}

def special(c: Char) -> Special:
  match c:
    case '&':
      Amp{}
    case '<':
      Lt{}
    case '>':
      Gt{}
    case '"':
      Quot{}
    case _:
      Plain{}

def esc_as(k: Special, c: Char, tail: String) -> String:
  match k:
    case Amp{}:
      SCon{'&', SCon{'a', SCon{'m', SCon{'p', SCon{';', tail}}}}}
    case Lt{}:
      SCon{'&', SCon{'l', SCon{'t', SCon{';', tail}}}}
    case Gt{}:
      SCon{'&', SCon{'g', SCon{'t', SCon{';', tail}}}}
    case Quot{}:
      SCon{'&', SCon{'q', SCon{'u', SCon{'o', SCon{'t', SCon{';', tail}}}}}}
    case Plain{}:
      SCon{c, tail}

# The chars of `s` escaped, then `tail`.
def esc(s: String, tail: String) -> String:
  match s:
    case SNil{}:
      tail
    case SCon{+c, t}:
      esc_as(special(c), c, esc(t, tail))

# Safe as text and as a double-quoted attribute value.
def escape(s: String) -> String:
  esc(s, "")

# Back to the text: undoes escape. An & that starts no entity of ours stays.
def unescape(s: String) -> String:
  match s:
    case SNil{}:
      ""
    case SCon{'&', SCon{'a', SCon{'m', SCon{'p', SCon{';', rest}}}}}:
      SCon{'&', unescape(rest)}
    case SCon{'&', SCon{'l', SCon{'t', SCon{';', rest}}}}:
      SCon{'<', unescape(rest)}
    case SCon{'&', SCon{'g', SCon{'t', SCon{';', rest}}}}:
      SCon{'>', unescape(rest)}
    case SCon{'&', SCon{'q', SCon{'u', SCon{'o', SCon{'t', SCon{';', rest}}}}}}:
      SCon{'"', unescape(rest)}
    case SCon{c, rest}:
      SCon{c, unescape(rest)}

# Rendering
# =========

# Each show_ def writes its part, then `tail`.
def show_pair(name: String, value: String, tail: String) -> String:
  SCon{' ', String.append(name, SCon{'=', SCon{'"', esc(value, SCon{'"', tail})}})}

def show_attr(x: Attr, tail: String) -> String:
  match x:
    case Class{v}:
      show_pair("class", v, tail)
    case Id{v}:
      show_pair("id", v, tail)
    case Href{v}:
      show_pair("href", v, tail)
    case Src{v}:
      show_pair("src", v, tail)
    case Alt{v}:
      show_pair("alt", v, tail)
    case TitleAttr{v}:
      show_pair("title", v, tail)
    case InputType{v}:
      show_pair("type", v, tail)
    case Name{v}:
      show_pair("name", v, tail)
    case Value{v}:
      show_pair("value", v, tail)
    case Placeholder{v}:
      show_pair("placeholder", v, tail)
    case ForAttr{v}:
      show_pair("for", v, tail)
    case Rel{v}:
      show_pair("rel", v, tail)
    case Charset{v}:
      show_pair("charset", v, tail)
    case Content{v}:
      show_pair("content", v, tail)
    case Lang{v}:
      show_pair("lang", v, tail)
    case Action{v}:
      show_pair("action", v, tail)
    case Method{v}:
      show_pair("method", v, tail)
    case Disabled{}:
      String.append(" disabled", tail)
    case Checked{}:
      String.append(" checked", tail)
    case DataAttr{n, v}:
      show_pair(String.append("data-", n), v, tail)

def show_attrs(xs: List<&2, Attr>, tail: String) -> String:
  match xs:
    case Nil{}:
      tail
    case x <> rest:
      show_attr(x, show_attrs(rest, tail))

def show_open(tag: String, attrs: List<&2, Attr>, tail: String) -> String:
  SCon{'<', String.append(tag, show_attrs(attrs, SCon{'>', tail}))}

def show_nodes(ns: List<&2, Node>, tail: String) -> String:
  match ns:
    case Nil{}:
      tail
    case Txt{s} <> rest:
      esc(s, show_nodes(rest, tail))
    case Raw{s} <> rest:
      String.append(s, show_nodes(rest, tail))
    case Void{tag, attrs} <> rest:
      show_open(tag, attrs, show_nodes(rest, tail))
    case Elem{+tag, attrs, children} <> rest:
      show_open(tag, attrs, show_nodes(children, SCon{'<', SCon{'/', String.append(tag, SCon{'>', show_nodes(rest, tail)})}}))

def render(n: Node) -> String:
  show_nodes([n], "")

def render_all(ns: List<&2, Node>) -> String:
  show_nodes(ns, "")

# A whole page, with its doctype.
def document(n: Node) -> String:
  String.append("<!DOCTYPE html>", render(n))
