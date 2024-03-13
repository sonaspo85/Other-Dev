<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    version="2.0">

	<xsl:attribute-set name="base-font">
		<xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
		<xsl:attribute name="line-height"><xsl:value-of select="$default-line-height"/></xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="common.title">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="substring-before($locale, '_') = 'ko'">SamsungOneKorean 600</xsl:when>
				<xsl:otherwise>SamsungOne 600</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__fo__root" use-attribute-sets="base-font">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="substring-before($locale, '_') = 'ko'">SamsungOneKorean 400</xsl:when>
				<xsl:otherwise>SamsungOne 400</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="xml:lang" select="translate($locale, '_', '-')"/>
		<xsl:attribute name="writing-mode" select="$writing-mode"/>
	</xsl:attribute-set>

</xsl:stylesheet>
