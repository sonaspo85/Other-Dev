<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <xsl:template match="*[contains(@class,' ui-d/uicontrol ')]">
        <xsl:apply-templates select="." mode="inlineTextOptionalKeyref">
            <xsl:with-param name="copyAttributes" as="element()"><wrapper xsl:use-attribute-sets="uicontrol"/></xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>

</xsl:stylesheet>