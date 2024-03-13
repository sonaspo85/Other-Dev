<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <xsl:template name="insertBodyStaticContents">
        <xsl:call-template name="insertBodyOddFooter"/>
    </xsl:template>

    <xsl:template name="insertTocStaticContents">
    </xsl:template>

    <xsl:template name="insertBodyOddFooter">
        <fo:static-content flow-name="odd-body-footer">
            <fo:block xsl:use-attribute-sets="__body__odd__footer">
                <fo:inline xsl:use-attribute-sets="__body__odd__footer__pagenum">
                	<xsl:text>- </xsl:text>
                    <fo:page-number/>
                    <xsl:text> -</xsl:text>
                </fo:inline>
            </fo:block>
        </fo:static-content>
    </xsl:template>

</xsl:stylesheet>