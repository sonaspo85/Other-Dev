<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
	version="2.0">

	<!-- TryNow formatting -->
    <xsl:attribute-set name="apiname">
        <xsl:attribute name="font-family">SamsungOne 400</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="color">rgb(255,255,255)</xsl:attribute>
        <xsl:attribute name="background-color">
        	<xsl:choose>
        		<xsl:when test="@outputclass = 'invisible'">cmyk(0%,0%,0%,30%)</xsl:when>
        		<xsl:otherwise>rgb(35,184,180)</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="margin-left">1mm</xsl:attribute>
        <xsl:attribute name="padding-before">0.5mm</xsl:attribute>
        <xsl:attribute name="padding-after">0.4mm</xsl:attribute>
        <xsl:attribute name="padding-start">0.3mm</xsl:attribute>
        <xsl:attribute name="padding-end">0.1mm</xsl:attribute>
        <xsl:attribute name="axf:border-radius">2mm</xsl:attribute>
    </xsl:attribute-set>

	<xsl:attribute-set name="parmname">
        <xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="color">rgb(255,0,0)</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
	</xsl:attribute-set>

</xsl:stylesheet>