# Readme


## Purpose

This template was made to write down requirements in a structured text file (i.e. XML).
The main goals aimed for are

1) easy handling, even without tools
2) easy tracking of changes with built-in capabilities of a modern CVS
3) easy to read (i.e. prettifying via xslt)
4) managing dependencies (i.e. linking requirements)
5) using a flat structure
6) easy searching for phrases or key words (i.e. by means of the OS)


## Special Characters / Formatting

Requirements may contain descriptions which span several lines. Opening the document in a
browser will result in the underlying XML file being transformed into a HTML document (see
XSLT transformation). The browser will ignore new lines as specified in the XML file. Thus
the XML text nodes have to be enriched by certain formatting expressions (see below).
These should be kept at a minimum because they add some cryptic bloat. It's advised to keep
these in seperate line, seperated from the text. This should make it easier to read diffs.

* &lt;br&gt; - force a new line
* &lt;ul&gt; or &lt;ol&gt; - start a list (unordered or ordered)
* &lt;/ul&gt; or &lt;/ul&gt; - end a list
* &lt;li&gt; - start a list item
* &lt;/li&gt; - end a list item
* &lt;h1&gt; - start a head line
* &lt;/h1&gt; - stop a head line

In theory all tags and attributes that are allowed in HTML could be used. Use them by your
own discretion. Still make sure that the underlying XML document remains legible without tools.


## Structuring

The requirements can be put into a single directory or distributed among different directories.
In any case each folder should contain the sub folders 'structure' (i.e. containing a XML schema
file with the structure definition) and 'style' (i.e. containing a XSLT file which formats the
XML file when opened in a browser).
