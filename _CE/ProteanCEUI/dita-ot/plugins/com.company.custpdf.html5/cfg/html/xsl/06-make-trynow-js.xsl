<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/"
    exclude-result-prefixes="xs ast"
    version="2.0">

	<xsl:variable name="LV_name" select="/CategoryData/@LV_name"/>

    <xsl:output method="text" encoding="UTF-8" />
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="div li p cmd"/>

	<xsl:template match="/">
		<xsl:variable name="filename" select="concat('../../2_HTML/container/', $LV_name, '/js/trynow', '.js')" />
		<xsl:result-document href="{$filename}">
			<xsl:text>var tryNowUrlInfo = {};</xsl:text>
			<xsl:apply-templates select="//span[matches(@class, '^C_TryNow(\-Invisible)?$')]" />
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="span[matches(@class, '^C_TryNow(\-Invisible)?$')]">
		<xsl:variable name="basename" select="ancestor::page/@url" />
		<xsl:text>&#xA;</xsl:text>
		<xsl:text>tryNowUrlInfo['</xsl:text><xsl:value-of select="@data-trynow"/><xsl:text>'] = '</xsl:text><xsl:value-of select="concat($basename, '#', @id)" /><xsl:text>';</xsl:text>
	</xsl:template>

</xsl:stylesheet>