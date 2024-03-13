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
    <xsl:preserve-space elements="div li p cmd"/>

	<xsl:template match="/">
		<xsl:variable name="filename" select="concat('../../2_HTML/container/', $LV_name,'/xml/CategoryData', '.xml')" />
		<xsl:result-document href="{$filename}">
			<xsl:apply-templates />
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="@LV_name">
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="CategoryData">
		<xsl:if test="parent::CategoryData">
			<xsl:value-of select="ast:indent(1)" />
		</xsl:if>
		<xsl:copy>
			<xsl:apply-templates />
			<xsl:value-of select="if ( parent::CategoryData ) then ast:indent(1) else '&#xA;'" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="group">
		<xsl:value-of select="ast:indent(2)" />
		<xsl:copy>
			<xsl:apply-templates select="@* except @outputclass" />
			<xsl:apply-templates select="node()" />
			<xsl:value-of select="ast:indent(2)" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="chapter | subchapter">
		<xsl:value-of select="ast:indent(3)" />
		<xsl:if test="name()='subchapter'"><xsl:text>&#x9;</xsl:text></xsl:if>
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="ancestor::group[@outputclass='troubleshooting']">
					<xsl:apply-templates select="@*" />
					<xsl:for-each select="current()//*[@class='ts-heading']">
						<xsl:value-of select="ast:indent(4)"/>
						<xsl:if test="ancestor::subchapter"><xsl:text>&#x9;</xsl:text></xsl:if>
						<page>
							<xsl:attribute name="url" select="ancestor::page/@url"/>
							<xsl:attribute name="style" select="@class"/>
							<xsl:attribute name="title" select="normalize-space(.)"/>
							<xsl:attribute name="id" select="@id"/>
						</page>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="@* | node()" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="ast:indent(3)" />
			<xsl:if test="name()='subchapter'"><xsl:text>&#x9;</xsl:text></xsl:if>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="page">
		<xsl:value-of select="ast:indent(4)"/>
		<xsl:if test="ancestor::subchapter"><xsl:text>&#x9;</xsl:text></xsl:if>
		<page>
			<xsl:apply-templates select="@*"/>
			<xsl:if test="div/div/section">
				<xsl:apply-templates select="div/div/section"/>
				<xsl:value-of select="ast:indent(4)"/>
				<xsl:if test="ancestor::subchapter"><xsl:text>&#x9;</xsl:text></xsl:if>
			</xsl:if>
		</page>
	</xsl:template>

	<xsl:template match="section">
		<xsl:value-of select="if ( ancestor::section ) then ast:indent(6) else ast:indent(5)" />
		<xsl:if test="ancestor::subchapter"><xsl:text>&#x9;</xsl:text></xsl:if>
		<section>
			<xsl:attribute name="id" select="*[1]/@id"/>
			<xsl:apply-templates select="@* except @id"/>
			<xsl:if test="section">
				<xsl:apply-templates select="section"/>
				<xsl:value-of select="if ( ancestor::section ) then ast:indent(6) else ast:indent(5)" />
				<xsl:if test="ancestor::subchapter"><xsl:text>&#x9;</xsl:text></xsl:if>
			</xsl:if>
		</section>
	</xsl:template>

	<xsl:template match="h1 | h2 | h3 | p | img | table | div">
	</xsl:template>

	<xsl:function name="ast:indent">
		<xsl:param name="depth" />
		<xsl:text>&#xA;</xsl:text>
		<xsl:for-each select="1 to $depth">
			<xsl:text>&#x9;</xsl:text>
		</xsl:for-each>
	</xsl:function>

</xsl:stylesheet>