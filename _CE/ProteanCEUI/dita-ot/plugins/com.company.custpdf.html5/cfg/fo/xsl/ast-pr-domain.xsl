<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0"
    exclude-result-prefixes="xs">

    <xsl:template match="*[contains(@class,' pr-d/apiname ')]">
        <xsl:text>&#x20;</xsl:text>
       	<fo:inline font-size="9.27pt" color="rgb(255,255,255)" margin-left="1mm" padding-before="0.5mm" padding-after="0.5mm" axf:border-radius="5pt" keep-together.within-line="always">
    		<xsl:choose>
    			<xsl:when test="@outputclass = 'invisible'">
    				<xsl:attribute name="background-color">rgb(178,178,178)</xsl:attribute>
    			</xsl:when>
    			<xsl:otherwise>
    				<xsl:attribute name="background-color">rgb(35,184,180)</xsl:attribute>
    			</xsl:otherwise>
    		</xsl:choose>
    		<xsl:value-of select="."/>
    	</fo:inline>
     </xsl:template>

</xsl:stylesheet>
