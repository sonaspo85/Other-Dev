<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/"
    exclude-result-prefixes="xs ast"
    version="2.0">

	<xsl:variable name="LV_name" select="/CategoryData/@LV_name"/>

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="no" />
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="div li p cmd note"/>

	<xsl:template match="/">
		<xsl:apply-templates select="//page" />
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="page">
		<xsl:variable name="filename" select="concat('../../2_HTML/container/', $LV_name, '/contents/', @url)" />
		<xsl:result-document href="{$filename}">
			<xsl:apply-templates select="div"/>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="div[parent::page]">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
			<script src="js/current.js">&#xFEFF;</script>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="section">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="a">
		<xsl:choose>
			<xsl:when test="not(node())">
				<xsl:copy>
					<xsl:apply-templates select="@*"/>
					<xsl:text>&#xFEFF;</xsl:text>
				</xsl:copy>
			</xsl:when>
		
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>