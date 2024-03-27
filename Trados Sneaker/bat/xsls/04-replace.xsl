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
	<xsl:param name="xml" as="xs:string" required="yes"/>
    <xsl:output method="xml" encoding="UTF-8" byte-order-mark="yes" indent="no" use-character-maps="a"/>
	<xsl:strip-space elements="*" />
	<xsl:preserve-space elements="seg-source target mrk g" />

	<xsl:variable name="target" select="document($xml)"/>

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

	<xsl:template match="target//replace">
		<xsl:variable name="i" select="xs:integer(substring-after(@pid, '#'))" />
		<xsl:variable name="pid" select="@pid" />
		<xsl:variable name="mrks" select="ancestor::target/preceding-sibling::seg-source[1]//mrk" />
		<mrk xmlns="urn:oasis:names:tc:xliff:document:1.2">
			<xsl:apply-templates select="$mrks[$i]/@*" />
			<xsl:apply-templates select="$target/body/p[@pid=$pid]/node()" />
		</mrk>
	</xsl:template>

	<xsl:template match="processing-instruction('AST')">
		<xsl:variable name="value" select="." />
		<xsl:choose>
			<xsl:when test="$value='8232'">
				<xsl:text>&#xA;</xsl:text>
			</xsl:when>
			<xsl:when test="starts-with($value, 't')">
				<xsl:variable name="count" select="substring-after($value, 't')" />
				<xsl:for-each select="1 to xs:integer($count)">
					<xsl:text>&#x9;</xsl:text>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="starts-with($value, 's')">
				<xsl:variable name="count" select="substring-after($value, 's')" />
				<xsl:for-each select="1 to xs:integer($count)">
					<xsl:text>&#x20;</xsl:text>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:function name="gom:getName">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], $char)" />
	</xsl:function>

</xsl:stylesheet>