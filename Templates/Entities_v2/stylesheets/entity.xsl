<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:ef="http://www.entity-form.org">


  <xsl:output method="html" version="1.0" encoding="UTF-8" />


  <xsl:variable name="rootNodeName" select="name(/*)" />


  <xsl:variable name="entityType" select="/ef:entity/ef:entity-type" />


  <xsl:variable name="title">
    <xsl:value-of select="concat($rootNodeName,' (', $entityType,')')" />
  </xsl:variable>


  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta charset="utf-8"/>
        <title><xsl:value-of select="$title" /></title>
        <link rel="shortcut icon" href="./icons/notepad.svg" />
        <style>
          .entity-form { padding:20px; }
          .entity-form .field { padding: 4px; margin:1px; background: #eee; }
          .entity-form .field label { display:inline-block; width:120px; margin-left:5px; }
          .entity-form .field input { display:inline-block; }
          .entity-form .text label {
                  display:block;
          }
          textarea { resize: none; }
        </style>
        <script src="./scripts/entity-form.js"></script>
      </head>
      <body>
        <h1><xsl:value-of select="$title" /></h1>
        <hr />
        <form class="entity-form" id="entityForm">
          <xsl:apply-templates />
        </form>
          <footer>
            <hr />
            <p align="middle">
              <a href="./icons/credits.html" target="_blank">credits for icons</a>
            </p>
          </footer>
      </body>
    </html>
  </xsl:template>


  <xsl:template match="text()|@*" />


  <xsl:template match="comment()">
    <!-- <p>comment: <i><xsl:value-of select="."/></i></p> -->
  </xsl:template>


  <xsl:template match="ef:entity | ef:ip-address">
    <!-- <p>skip <b><xsl:value-of select="name()" /></b></p> -->
    <xsl:apply-templates />
  </xsl:template>


  <!-- A rule for debugging purposes. Should be commented out after development and testing! -->
  <!-- <xsl:template match="*">
      <p>WARNING: Unmatched element: <xsl:value-of select="name()" /> := <xsl:value-of select="." /></p>
    <xsl:apply-templates />
  </xsl:template> -->


  <xsl:template match="ef:name">
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_name"' />
      <xsl:with-param name="tooltip" select='"The name of this entity."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="ef:model">
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_model"' />
      <xsl:with-param name="tooltip" select='"The model name of this entity."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="ef:entity-type">
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_type"' />
      <xsl:with-param name="tooltip" select='"The type of this entity (e.g. router, switch, NAS, computer)."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="ef:ipv4">
    <br />
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_ip"' />
      <xsl:with-param name="tooltip" select='"The IP address of this entity (either as IPv4 or IPv6)."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="ef:ipv6">
    <br />
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_ip"' />
      <xsl:with-param name="tooltip" select='"The IP address of this entity (either as IPv4 or IPv6)."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="ef:mac-address">
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_mac"' />
      <xsl:with-param name="tooltip" select='"The mac address of this entity."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="ef:url">
    <br />
    <xsl:call-template name="insertTextFieldWithButton">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_url"' />
      <xsl:with-param name="tooltip" select='"The URL to the administration console of this entity."' />
      <xsl:with-param name="length" select='"80"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="ef:description">
    <br />
    <xsl:call-template name="insertTextArea">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_description"' />
      <xsl:with-param name="tooltip" select='"Additional informations for this entity which are not provided in the fields above."' />
      <xsl:with-param name="columns" select='"80"' />
      <xsl:with-param name="rows" select='"8"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template name="insertTextField">
    <xsl:param name="label" />
    <xsl:param name="value" />
    <xsl:param name="formName" />
    <xsl:param name="idName" />
    <xsl:param name="tooltip" />
    <xsl:param name="length" />
    <div class="field">
      <label for="{$idName}" title="{$tooltip}"><xsl:value-of select="$label"/>:</label>
      <input form="{$formName}" type="text" id="{$idName}" name="{$idName}" size="{$length}" value="{$value}" />
    </div>
  </xsl:template>


  <xsl:template name="insertTextFieldWithButton">
    <xsl:param name="label" />
    <xsl:param name="value" />
    <xsl:param name="formName" />
    <xsl:param name="idName" />
    <xsl:param name="tooltip" />
    <xsl:param name="length" />
    <div class="field">
      <label for="{$idName}" title="{$tooltip}"><xsl:value-of select="$label"/>:</label>
      <input form="{$formName}" type="text" id="{$idName}" name="{$idName}" size="{$length}" value="{$value}" />
      <button form="entityForm" type="button" name="open_url" onClick="openURL(this)" title="Tries to open the specified URL in a new tab."><img src="./icons/link39.svg" width="16" height="16" border="0" alt="open URL"></img></button>
    </div>
  </xsl:template>


  <xsl:template name="insertTextArea">
    <xsl:param name="label" />
    <xsl:param name="value" />
    <xsl:param name="formName" />
    <xsl:param name="idName" />
    <xsl:param name="tooltip" />
    <xsl:param name="columns" />
    <xsl:param name="rows" />
    <div class="text" title="{$tooltip}">
      <label for="entity_description"><xsl:value-of select="$label"/>:</label>
      <textarea form="{$formName}" rows="{$rows}" cols="{$columns}" id="{$idName}" name="{$idName}">
        <xsl:value-of select="$value"/>
      </textarea>
    </div>
  </xsl:template>


</xsl:stylesheet>
