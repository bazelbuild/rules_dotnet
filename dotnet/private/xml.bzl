"""A minimal XML reader.

Only the subset of XML that shows up in NuGet package metadata is read:
elements and their attributes. Text content is skipped, as is anything else
that can hide a "<" from the scanner. Deliberately lenient, since the
documents are machine-generated.

Nodes are plain dicts so that they can be built up while parsing:

    {"name": str, "attrs": {str: str}, "children": [node]}
"""

_WHITESPACE = " \t\r\n"

# Ordered so that "&amp;" is substituted last, otherwise "&amp;lt;" would
# incorrectly decode to "<" instead of "&lt;".
_ENTITIES = [
    ("&lt;", "<"),
    ("&gt;", ">"),
    ("&quot;", "\""),
    ("&apos;", "'"),
    ("&amp;", "&"),
]

def _unescape(value):
    if value.find("&") == -1:
        return value

    for (entity, char) in _ENTITIES:
        value = value.replace(entity, char)

    return value

def _skip_whitespace(content, pos):
    for i in range(pos, len(content)):
        if content[i] not in _WHITESPACE:
            return i

    return len(content)

def _read_name(content, pos):
    for i in range(pos, len(content)):
        char = content[i]
        if char in _WHITESPACE or char == "=" or char == "/" or char == ">":
            return (content[pos:i], i)

    return (content[pos:], len(content))

def _read_tag(content, pos):
    """Reads a start tag beginning at the "<" found at `pos`.

    Args:
      content: The whole document.
      pos: The index of the opening "<".

    Returns:
      A tuple of (name, attributes, index after the tag, self closing).
    """
    (name, pos) = _read_name(content, pos + 1)
    attrs = {}

    # Starlark has no while loop; each pass consumes at least one attribute.
    for _ in range(len(content)):
        pos = _skip_whitespace(content, pos)
        if pos >= len(content):
            break

        if content[pos] == ">":
            return (name, attrs, pos + 1, False)

        if content.startswith("/>", pos):
            return (name, attrs, pos + 2, True)

        (attr_name, pos) = _read_name(content, pos)
        pos = _skip_whitespace(content, pos)

        # An attribute without a value is not valid XML, but being lenient
        # here is cheaper than failing on a document we do not control.
        if pos >= len(content) or content[pos] != "=":
            attrs[attr_name] = ""
            continue

        pos = _skip_whitespace(content, pos + 1)
        quote = content[pos]
        end = content.find(quote, pos + 1)
        if end == -1:
            fail("Unterminated attribute value for '{}'".format(attr_name))

        attrs[attr_name] = _unescape(content[pos + 1:end])
        pos = end + 1

    fail("Unterminated tag '{}'".format(name))

def parse(content):
    """Parses an XML document.

    Args:
      content: The document as a string.

    Returns:
      The root node, or None if the document contains no elements.
    """

    # A synthetic node so that the stack is never empty while parsing.
    root = {"attrs": {}, "children": [], "name": ""}
    stack = [root]
    pos = 0

    # Every iteration consumes at least one character of input.
    for _ in range(len(content)):
        if pos >= len(content):
            break

        start = content.find("<", pos)
        if start == -1:
            break

        if content.startswith("<!--", start):
            end = content.find("-->", start)
            pos = len(content) if end == -1 else end + 3
        elif content.startswith("<![CDATA[", start):
            end = content.find("]]>", start)
            if end == -1:
                fail("Unterminated CDATA section")
            pos = end + 3
        elif content.startswith("<?", start) or content.startswith("<!", start):
            end = content.find(">", start)
            pos = len(content) if end == -1 else end + 1
        elif content.startswith("</", start):
            end = content.find(">", start)
            if end == -1:
                fail("Unterminated end tag")
            if len(stack) > 1:
                stack.pop()
            pos = end + 1
        else:
            (name, attrs, pos, self_closing) = _read_tag(content, start)
            node = {"attrs": attrs, "children": [], "name": name}
            stack[-1]["children"].append(node)
            if not self_closing:
                stack.append(node)

    return root["children"][0] if root["children"] else None

def children(node, name):
    """Returns the direct children of `node` with the given tag name.

    Namespace prefixes on the element are ignored so that documents which
    qualify their elements still match.

    Args:
      node: The node to look in. May be None.
      name: The unprefixed tag name to match.

    Returns:
      A list of matching child nodes.
    """
    if node == None:
        return []

    return [child for child in node["children"] if local_name(child) == name]

def child(node, name):
    """Returns the first direct child of `node` named `name`, or None.

    Args:
      node: The node to look in. May be None.
      name: The unprefixed tag name to match.

    Returns:
      The first matching child node, or None.
    """
    matches = children(node, name)
    return matches[0] if matches else None

def local_name(node):
    """Returns the tag name of `node` with any namespace prefix removed.

    Args:
      node: The node to inspect.

    Returns:
      The unprefixed tag name.
    """
    name = node["name"]
    colon = name.find(":")
    return name[colon + 1:] if colon != -1 else name

def attr(node, name):
    """Returns an attribute of `node`, or "" if it is not set.

    Args:
      node: The node to inspect.
      name: The attribute name.

    Returns:
      The attribute value, or "".
    """
    return node["attrs"].get(name, "")

xml = struct(
    attr = attr,
    child = child,
    children = children,
    local_name = local_name,
    parse = parse,
)
