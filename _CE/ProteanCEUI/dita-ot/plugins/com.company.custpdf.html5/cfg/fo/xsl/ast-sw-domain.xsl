<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

	<xsl:template match="*[contains(@class,' sw-d/varname ')]">
		<xsl:variable name="orig">
			<xsl:apply-templates select="." mode="inlineTextOptionalKeyref">
				<xsl:with-param name="copyAttributes" as="element()"><wrapper xsl:use-attribute-sets="varname"/></xsl:with-param>
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@outputclass='vd-icon'">
				<xsl:apply-templates select="$orig" mode="vd-icon"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$orig"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="@* | node()" mode="vd-icon">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" mode="vd-icon"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="fo:inline" mode="vd-icon">
		<xsl:copy>
			<xsl:apply-templates select="@* except @font-family" mode="vd-icon"/>
			<xsl:attribute name="font-family">VD_Icon</xsl:attribute>
			<xsl:apply-templates select="node()" mode="vd-icon"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>