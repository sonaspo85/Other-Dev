<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    exclude-result-prefixes="opentopic-index opentopic opentopic-i18n opentopic-func dita-ot xs ot-placeholder"
    version="2.0">

    <xsl:template match="/" name="rootTemplate">
        <xsl:call-template name="validateTopicRefs"/>
        <fo:root xsl:use-attribute-sets="__fo__root">
            <axf:document-info xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions" name="pagelayout" value="SinglePage"/>
            <xsl:call-template name="createMetadata"/>
            <xsl:call-template name="createLayoutMasters"/>
            <xsl:if test="substring-before($locale, '_') != 'my'">
            	<xsl:call-template name="createBookmarks"/>
            </xsl:if>
            <xsl:apply-templates select="*" mode="generatePageSequences"/>
        </fo:root>
    </xsl:template>

</xsl:stylesheet>
