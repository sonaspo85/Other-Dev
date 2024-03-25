<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:sdl="http://sdl.com/FileTypes/SdlXliff/1.0"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2"
    xpath-default-namespace="urn:oasis:names:tc:xliff:document:1.2"
    xmlns:gom="http://www.astkorea.net/gom"
	exclude-result-prefixes="xsl xs sdl xliff gom"
    version="2.0">

	<xsl:character-map name="a"> 
		<xsl:output-character character="&lt;" string="&amp;lt;"/>
		<xsl:output-character character="&gt;" string="&amp;gt;"/>
		<xsl:output-character character="&quot;" string="&amp;quot;"/>
	</xsl:character-map>

	<xsl:param name="output" as="xs:string" required="yes"/>
    <xsl:output method="xml" encoding="UTF-8" byte-order-mark="yes" indent="no" use-character-maps="a"/>
	<xsl:strip-space elements="*" />
	<xsl:preserve-space elements="seg-source target mrk g" />

	<xsl:template match="/">
		<xsl:result-document method="xml" href="file:////{$output}">
			<xsl:apply-templates />
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="target">
		<xsl:copy>
			<xsl:apply-templates select="preceding-sibling::seg-source/node()" />
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>