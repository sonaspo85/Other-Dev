<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:ast="http://www.astkorea.net/"
    exclude-result-prefixes="xs ast"
    version="2.0">

	<xsl:variable name="LV_name" select="/CategoryData/@LV_name"/>

	<xsl:output method="xml" version="1.0" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:strip-space elements="*" />
    <xsl:preserve-space elements="div li p cmd"/>

	<xsl:template match="/">
		<xsl:variable name="filename" select="concat('../../2_HTML/container/', $LV_name, '/jsons/search', '.js')" />
		<xsl:result-document href="{$filename}">
			<xsl:text>var search=[</xsl:text>
			<xsl:apply-templates select="//page" />
			<xsl:text>]</xsl:text>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="*">
		<xsl:apply-templates />
		<xsl:text>&#x20;</xsl:text>
	</xsl:template>

	<xsl:template match="img">
		<xsl:choose>
			<xsl:when test="@alt">
				<xsl:choose>
					<xsl:when test="@alt='Next'">
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@alt" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@class='break'">
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="p/span">
		<xsl:value-of select="text()" />
	</xsl:template>

	<xsl:template match="span/span">
	</xsl:template>

	<xsl:template match="div[starts-with(@id, 'smart-ui')]">
	</xsl:template>

	<xsl:template match="page[@search='no']">
	</xsl:template>

	<xsl:template match="page">
		<xsl:variable name="body">
			<xsl:apply-templates select="div/div" />
		</xsl:variable>
		<xsl:variable name="title">
			<xsl:apply-templates select="@title" />
		</xsl:variable>
		<xsl:variable name="toc_id">
			<xsl:apply-templates select="@id" />
		</xsl:variable>

		<xsl:text>&#xA;</xsl:text>
		<xsl:text>{"body":"</xsl:text><xsl:value-of select="normalize-space(replace(replace($body, '&quot;', ''), '\(\s+', '('))" /><xsl:text>",&#xA;</xsl:text>
		<xsl:text>&#x9;&#x9;"title":"</xsl:text><xsl:value-of select="normalize-space(replace(replace($title, '&quot;', ''), '\(\s+', ')'))" /><xsl:text>",&#xA;</xsl:text>
		<xsl:text>&#x9;&#x9;"toc_id":"</xsl:text><xsl:value-of select="$toc_id" />
		<xsl:text>"}</xsl:text>
		<xsl:if test="following::page">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:function name="ast:indent">
		<xsl:param name="depth" />
		<xsl:text>&#xA;</xsl:text>
		<xsl:for-each select="1 to $depth">
			<xsl:text>&#x9;</xsl:text>
		</xsl:for-each>
	</xsl:function>

	<xsl:function name="ast:getPath">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], '/')" />
	</xsl:function>

	<xsl:function name="ast:getName">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="tokenize($str, $char)[last()]" />
	</xsl:function>

</xsl:stylesheet>
