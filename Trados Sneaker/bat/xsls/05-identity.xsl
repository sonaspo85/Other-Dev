<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	  xmlns:sdl="http://sdl.com/FileTypes/SdlXliff/1.0"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2"
    xpath-default-namespace="urn:oasis:names:tc:xliff:document:1.2"
	  exclude-result-prefixes="xsl xs sdl xliff"
    version="2.0">

	<xsl:strip-space elements="*" />
	<xsl:preserve-space elements="source seg-source target mrk g" />
	<xsl:param name="output" as="xs:string" required="yes"/>
	<xsl:param name="externalPath" as="xs:string" required="yes" />

	<xsl:character-map name="a">
    <xsl:output-character character="&lt;" string="&amp;lt;"/>
    <xsl:output-character character="&gt;" string="&amp;gt;"/>
    <xsl:output-character character="&quot;" string="&amp;quot;"/>
	</xsl:character-map>

    <xsl:output method="xml" encoding="UTF-8" indent="no" use-character-maps="a"/>

    <xsl:template match="/">
    	<xsl:result-document href="{concat('file:////', $output)}">
    		<xsl:apply-templates />
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="@* | node()">
    	<xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/xliff/file/header/reference/external-file/@href">
    	<xsl:attribute name="href" select="concat('file://', replace($externalPath, '\\', '/'))" />
    </xsl:template>

    <xsl:template match="/xliff/file/@original">
    	<xsl:attribute name="original" select="$externalPath" />
    </xsl:template>

    <xsl:template match="/xliff/file/header/sdl:ref-files/sdl:ref-file/@o-path">
    	<xsl:attribute name="o-path" select="$externalPath" />
    </xsl:template>

    <xsl:template match="/xliff/file/header/sdl:ref-files/sdl:ref-file/@rel-path">
      <xsl:attribute name="o-path" select="$externalPath" />
    </xsl:template>

    <xsl:template match="/xliff/file/header/sdl:file-info/sdl:value[@key='SDL:OriginalFilePath']">
    	<xsl:copy>
        <xsl:apply-templates select="@*"/>
        <xsl:value-of select="$externalPath" />
      </xsl:copy>
    </xsl:template>

</xsl:stylesheet>