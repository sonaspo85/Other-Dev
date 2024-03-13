<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
    exclude-result-prefixes="xs son xsi aid"
    version="2.0">

    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="*"/>

	<xsl:variable name="merged_file" select="document(concat(son:getpath(base-uri(.), '/'), '/merged.xml'))" />
	
	<xsl:template match="/">
		<xsl:variable name="filename" select="concat(son:getpath(base-uri(.), '/'), '/xml', '/01-merged.xml')" />

		<xsl:variable name="merged_file1">
			<xsl:apply-templates select="$merged_file/*" />
		</xsl:variable>
		
		<xsl:result-document href="{$filename}" method="xml">
			<xsl:copy-of select="$merged_file1" />
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="*">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*">
		<xsl:attribute name="{local-name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>

	<xsl:function name="son:getpath">
		<xsl:param name="arg1" />
		<xsl:param name="arg2" />
		<xsl:value-of select="string-join(tokenize($arg1, $arg2)[position() ne last()], $arg2)" />
	</xsl:function>

	<xsl:function name="son:last">
		<xsl:param name="arg1" />
		<xsl:param name="arg2" />
		<xsl:copy-of select="tokenize($arg1, $arg2)[last()]" />
	</xsl:function>
	
</xsl:stylesheet>