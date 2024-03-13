<?xml version="1.0"?>
<xsl:stylesheet 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

	<xsl:attribute-set name="xref" use-attribute-sets="common.link">
        <xsl:attribute name="color">inherit</xsl:attribute>
		<!-- <xsl:attribute name="border-bottom">
            <xsl:choose>
                <xsl:when test="ancestor-or-self::*[contains(@type, 'note')]">0.5pt solid rgb(120,120,120)</xsl:when>
                <xsl:otherwise>0.5pt solid rgb(0,0,0)</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute> -->
        <xsl:attribute name="text-decoration">underline</xsl:attribute>
        <xsl:attribute name="axf:text-underline-position">-0.25em</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>
