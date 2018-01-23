<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">


  <xsl:output method="html" version="1.0" encoding="UTF-8" />


  <xsl:template match="/">
    <html>
      <head>
        <title>
          Requirement <xsl:value-of select="requirement/id/text()" />
        </title>
        <style type="text/css">
          td {
            text-align:left;
            vertical-align:top;
          }
          table {
            border-collapse: collapse;
            width: 95%;
          }
        </style>
      </head>
      <body>
        <table border="3">
          <xsl:apply-templates />
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="id/text()">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;" width="20%">
        <b>ID</b>
      </td>
      <td>
        <xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="name/text()">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;">
        <b>Name</b>
      </td>
      <td>
        <xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="purpose/text()">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;">
        <b>Purpose</b>
      </td>
      <td>
        <xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="scope/text()">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;">
        <b>Scope</b>
      </td>
      <td>
        <xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="priority/text()">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;">
        <b>Priority</b>
      </td>
      <td>
        <xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="status/text()">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;">
        <b>Status</b>
      </td>
      <td>
        <xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="parents">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;">
        <b>Parents</b>
      </td>
      <td>
        <ul>
          <xsl:apply-templates />
        </ul>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="parent">
    <li>
      <a href="{concat(text(),'.xml')}">
        <xsl:value-of select="text()" />
      </a>
    </li>
  </xsl:template>

  <xsl:template match="children">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;">
        <b>Children</b>
      </td>
      <td>
        <ul>
          <xsl:apply-templates />
        </ul>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="child">
    <li>
      <a href="{concat(text(),'.xml')}">
        <xsl:value-of select="text()" />
      </a>
    </li>
  </xsl:template>

  <xsl:template match="authors">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;">
        <b>Authors</b>
      </td>
      <td>
        <ul>
          <xsl:apply-templates />
        </ul>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="author/text()">
    <li>
      <xsl:value-of select="." />
    </li>
  </xsl:template>

  <xsl:template match="description/text()">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;">
        <b>Description</b>
      </td>
      <td>
        <xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="comment/text()">
    <tr>
      <td style="background-color: #808080; color: #FFFFFF;">
        <b>Comment</b>
      </td>
      <td>
        <xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
