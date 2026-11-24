# Proofs of LAWS.bend. `bend PROOF.bend` checks them.
import Base
import ./LAWS.bend as Laws
import ./html.bend as H

# Examples
# ========

def Laws.renders_a_page():
  {==}

def Laws.renders_text_helpers():
  {==}

def Laws.renders_form_attributes():
  {==}

def Laws.renders_a_document():
  {==}

# Escaping
# ========

def Laws.classifies_special_chars():
  {==}

# Escaping one char adds no markup.
law esc_as_no_markup:
  for k: H.Special
  for c: Char
  for tail: String
  for e: {H.special(c) == k : H.Special}
  {Laws.has_markup(H.esc_as(k, c, tail)) == Laws.has_markup(tail) : Bool}

def esc_as_no_markup(k, c, tail, e):
  match k:
    case H.Amp{}:
      {==}
    case H.Lt{}:
      {==}
    case H.Gt{}:
      {==}
    case H.Quot{}:
      {==}
    case H.Plain{}:
      %e : {Laws.has_markup(SCon{c, tail}) == (Laws.is_markup(_) || Laws.has_markup(tail)) : Bool}
      {==}

law esc_no_markup:
  for s: String
  for +tail: String
  {Laws.has_markup(H.esc(s, tail)) == Laws.has_markup(tail) : Bool}

def esc_no_markup(s, tail):
  match s:
    case SNil{}:
      {==}
    case SCon{+c, +t}:
      %esc_no_markup(t, tail) : {Laws.has_markup(H.esc_as(H.special(c), c, H.esc(t, tail))) == _ : Bool}
      esc_as_no_markup(H.special(c), c, H.esc(t, tail), {==})

def Laws.escaped_has_no_markup(s):
  esc_no_markup(s, "")

def Laws.text_is_escaped(s):
  {==}

# Appending after one escaped char is escaping onto what follows.
law esc_as_app:
  for k: H.Special
  for c: Char
  for x: String
  for y: String
  {String.append(H.esc_as(k, c, x), y) == H.esc_as(k, c, String.append(x, y)) : String}

def esc_as_app(k, c, x, y):
  match k:
    case H.Amp{}:
      {==}
    case H.Lt{}:
      {==}
    case H.Gt{}:
      {==}
    case H.Quot{}:
      {==}
    case H.Plain{}:
      {==}

law esc_app:
  for s: String
  for +tail: String
  {H.esc(s, tail) == String.append(H.esc(s, ""), tail) : String}

def esc_app(s, tail):
  match s:
    case SNil{}:
      {==}
    case SCon{+c, +t}:
      %Equal.sym(String, String.append(H.esc_as(H.special(c), c, H.esc(t, "")), tail), H.esc_as(H.special(c), c, String.append(H.esc(t, ""), tail)), esc_as_app(H.special(c), c, H.esc(t, ""), tail)) : {H.esc_as(H.special(c), c, H.esc(t, tail)) == _ : String}
      %esc_app(t, tail) : {H.esc_as(H.special(c), c, H.esc(t, tail)) == H.esc_as(H.special(c), c, _) : String}
      {==}

def Laws.attribute_value_is_escaped(s):
  Equal.cong(String, String, x => String.append("<div class=\"", x), H.esc(s, "\"></div>"), String.append(H.esc(s, ""), "\"></div>"), esc_app(s, "\"></div>"))

# Unescaping one escaped char gives the char. One case per escaped char
# (& < > "), and one per set of chars sharing the bits that tell them apart
# from those, lowest bit first, as bend_json's gen_tree.py makes them.
law unesc_char:
  for c: Char
  for tail: String
  {H.unescape(H.esc_as(H.special(c), c, tail)) == SCon{c, H.unescape(tail)} : String}

def unesc_char(c, tail):
  match c:
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{False{}, t}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, t}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, t}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, t}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WNil{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WNil{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, t}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, t}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WNil{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WNil{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, t}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{False{}, WCon{True{}, t}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, t}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WNil{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WNil{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, WCon{True{}, t}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{True{}, t}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, t}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, t}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WNil{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, WNil{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{False{}, WCon{True{}, t}}}}}}}}}}:
      {==}
    case Chr{U32{WCon{False{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, WCon{True{}, t}}}}}}}}}:
      {==}
    case Chr{U32{WCon{True{}, t}}}:
      {==}

def Laws.escaping_loses_nothing(s):
  match s:
    case SNil{}:
      {==}
    case SCon{+c, +t}:
      %Laws.escaping_loses_nothing(t) : {H.unescape(H.esc_as(H.special(c), c, H.esc(t, ""))) == SCon{c, _} : String}
      unesc_char(c, H.esc(t, ""))

def Laws.unescapes():
  {==}

# Lists
# =====

law li_nodes_are_li:
  for items: List<&2, H.Li>
  {Laws.all_li(H.li_nodes(items)) == True{} : Bool}

def li_nodes_are_li(items):
  match items:
    case Nil{}:
      {==}
    case H.Li{attrs, children} <> rest:
      li_nodes_are_li(rest)

def Laws.ul_holds_only_li(attrs, items):
  li_nodes_are_li(items)

def Laws.ol_holds_only_li(attrs, items):
  li_nodes_are_li(items)
