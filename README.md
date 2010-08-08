# AxeML

AxeML is a notation for Nokogiri XML documents inspired by [SXML](http://okmij.org/ftp/Scheme/SXML.html).

## Syntax

A document is represented by an array, possibly nested. The first
element of each array must be a symbol indicating the node
name. Further elements may either be strings or numbers which are
treated as the node's content, hashes representing this node's
attributes or further arrays which are then made into child nodes by
the same rules.

The syntax can be described by the following rammar:

    node       ::= [node-name, (node | attributes | content) ...]
    node-name  ::= Symbol
    attributes ::= Hash
    content    ::= String | Fixnum | Float


## Example

    AxeML.transform([:ul, { :class => 'menu' },
                     [:li, [:a, { :href => '/foo' }, 'foo']],
                     [:li, [:a, { :href => '/bar' }, 'bar']]]).to_s

    =>

    <?xml version="1.0"?>
    <ul class="menu">
      <li>
	<a href="/foo">foo</a>
      </li>
      <li>
	<a href="/bar">bar</a>
      </li>
    </ul>

## Copyright

Copyright (c) 2010 Moritz Heidkamp. See LICENSE for details.
