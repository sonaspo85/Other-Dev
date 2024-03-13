<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:attribute-set name="cmdname">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="substring-before($locale, '_') = 'ko'">SamsungOneKorean 600</xsl:when>
				<xsl:otherwise>SamsungOne 600</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="color">rgb(0,84,166)</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="varname">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="substring-before($locale, '_') = 'ko'">inherit</xsl:when>
				<xsl:otherwise>SamsungOne 600</xsl:otherwise>			
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="color">
			<xsl:choose>
				<xsl:when test="substring-before($locale, '_') != 'ko'">rgb(0,129,150)</xsl:when>
				<xsl:otherwise>inherit</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>