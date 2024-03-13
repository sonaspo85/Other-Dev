<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	<xsl:output method="xml" encoding="UTF-8" indent="no" />
	<xsl:strip-space elements="*"/>
	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

	<xsl:template match="p[matches(@class, '(Heading)(\d+)(_?\-?\d?.*)?')][not(matches(@class, 'Heading1_Hidden'))]">
		<xsl:variable name="h_Num" select="number(replace(@class, '(Heading)(\d+)(_?\-?\d?.*)?', '$2'))" />

		<xsl:call-template name="change_h">
			<xsl:with-param name="cur" select="." />
			<xsl:with-param name="h_Num" select="$h_Num" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="change_h">
		<xsl:param name="cur" />
		<xsl:param name="h_Num" />

		<xsl:variable name="H_plus" select="$h_Num+1" />
		<xsl:variable name="id_insert">
			<xsl:choose>
				<xsl:when test="@id">
					<xsl:value-of select="@id" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('d', generate-id())" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:element name="{concat('h',$H_plus)}">
			<xsl:attribute name="class" select="@class" />
			<xsl:attribute name="id" select="$id_insert" />
			<xsl:apply-templates select="@* except @class" />
			<xsl:apply-templates select="node()" />
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>