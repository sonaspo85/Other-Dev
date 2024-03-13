<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="xs">

	<!-- Maximum level allowed in the TOC -->
	<xsl:param name="tocMaximumLevel" select="4"/>

	<!-- Change page size to A4 -->
	<xsl:variable name="page-width">210mm</xsl:variable>
	<xsl:variable name="page-height">297mm</xsl:variable>

	<!-- This is the default, but you can set the margins individually below. -->
	<xsl:variable name="page-margins">15mm</xsl:variable>
	<xsl:variable name="page-margins-cover">0mm</xsl:variable>

	<!-- Change these if your page has different margins on different sides. -->
	<xsl:variable name="page-margin-inside" select="$page-margins"/>
	<xsl:variable name="page-margin-outside" select="$page-margins"/>
	<xsl:variable name="page-margin-top" select="$page-margins"/>
	<xsl:variable name="page-margin-bottom" select="$page-margins"/>

	<!-- The side column width is the amount the body text is indented relative to the margin. -->
	<xsl:variable name="side-col-width">0mm</xsl:variable>

	<!-- Set default font-size and line-height -->
	<xsl:variable name="default-font-size">10pt</xsl:variable>
	<!-- <xsl:variable name="default-line-height">150%</xsl:variable> -->
	<xsl:variable name="default-line-height">
		<xsl:choose>
			<xsl:when test="matches(substring-before($locale, '_'), 'hr|hu|kk|el|mk|pl|ru|sk')">140%</xsl:when>
			<xsl:otherwise>150%</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
</xsl:stylesheet>
