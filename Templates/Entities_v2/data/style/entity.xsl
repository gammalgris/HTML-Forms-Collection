<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">


  <xsl:output method="html" version="1.0" encoding="UTF-8" />


  <xsl:variable name="rootNodeName" select="name(/*)" />


  <xsl:variable name="entityType" select="/entity/entity-type" />


  <xsl:variable name="title">
    <xsl:value-of select="concat($rootNodeName,' (', $entityType,')')" />
  </xsl:variable>


  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta charset="utf-8"/>
        <title><xsl:value-of select="$title" /></title>
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
      </head>
      <body>
        <h1><xsl:value-of select="$title" /></h1>
        <hr />
        <form class="entity-form" id="entityForm">
          <xsl:apply-templates />
        </form>
          <footer>
            <hr />
          </footer>
      </body>
    </html>
  </xsl:template>


  <xsl:template match="text()|@*" />


  <xsl:template match="comment()">
    <!-- <p>comment: <i><xsl:value-of select="."/></i></p> -->
  </xsl:template>


  <xsl:template match="entity | ip-address | subnet-mask">
    <!-- <p>skip <b><xsl:value-of select="name()" /></b></p> -->
    <xsl:apply-templates />
  </xsl:template>


  <!-- A rule for debugging purposes. Should be commented out after development and testing! -->
  <!-- <xsl:template match="*">
      <p>WARNING: Unmatched element: <xsl:value-of select="name()" /> := <xsl:value-of select="." /></p>
    <xsl:apply-templates />
  </xsl:template> -->


  <xsl:template match="name">
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_name"' />
      <xsl:with-param name="tooltip" select='"The name of this entity."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="entity-type">
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_type"' />
      <xsl:with-param name="tooltip" select='"The type of this entity (e.g. router, switch, NAS, computer)."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="model">
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_model"' />
      <xsl:with-param name="tooltip" select='"The model name of this entity."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="serial-no">
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_sn"' />
      <xsl:with-param name="tooltip" select='"The serial number of this entity."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="mac-address">
    <br />
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_mac"' />
      <xsl:with-param name="tooltip" select='"The mac address of this entity."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="ipv4">
    <br />
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_ip"' />
      <xsl:with-param name="tooltip" select='"The IP address of this entity (as IPv4 address)."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="ipv6">
    <br />
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_ip"' />
      <xsl:with-param name="tooltip" select='"The IP address of this entity (as IPv6 address)."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="subnet-bitmask">
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_subnet"' />
      <xsl:with-param name="tooltip" select='"The subnet mask for this IP address (bitmask notation)."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="subnet-cidr">
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_subnet"' />
      <xsl:with-param name="tooltip" select='"The subnet mask for this IP address (CIDR notation)."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="firmware-version">
    <br />
    <xsl:call-template name="insertTextField">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_firmware"' />
      <xsl:with-param name="tooltip" select='"The firmware version of this entity."' />
      <xsl:with-param name="length" select='"40"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="url">
    <br />
    <xsl:call-template name="insertURL">
      <xsl:with-param name="label" select="local-name()" />
      <xsl:with-param name="value" select="text()" />
      <xsl:with-param name="formName" select='"entityForm"' />
      <xsl:with-param name="idName" select='"entity_url"' />
      <xsl:with-param name="tooltip" select='"The URL to the administration console of this entity."' />
      <xsl:with-param name="length" select='"80"' />
    </xsl:call-template>
  </xsl:template>


  <xsl:template match="description">
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


  <xsl:template name="insertURL">
    <xsl:param name="label" />
    <xsl:param name="value" />
    <xsl:param name="formName" />
    <xsl:param name="idName" />
    <xsl:param name="tooltip" />
    <xsl:param name="length" />
    <div class="field">
      <label for="{$idName}" title="{$tooltip}"><xsl:value-of select="$label"/>:</label>
      <a href="{$value}"><xsl:value-of select="$value"/></a>
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
