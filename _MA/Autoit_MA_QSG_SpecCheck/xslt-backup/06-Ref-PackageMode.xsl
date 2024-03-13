<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    exclude-result-prefixes="xs ast">
    <xsl:strip-space elements="*"/>

    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    
    <xsl:template name="createPackageP">
        <xsl:param name="specCheck" />
        <xsl:param name="lang" />
        <xsl:param name="cur" />
        
        <xsl:copy>
            <xsl:apply-templates select="@* except @class" /> 
                
            <xsl:variable name="booleanValues">
                <xsl:call-template name="booleanCheck">
                    <xsl:with-param name="specCheck" select="$specCheck" />
                    <xsl:with-param name="specDiv" select="$packageDiv/items[@lang=$lang]/item" />
                    <xsl:with-param name="cur" select="." />
                    <xsl:with-param name="lang" select="false()" />
                </xsl:call-template>
            </xsl:variable>
            
            <xsl:if test="not(matches($booleanValues, 'false'))">
                <xsl:variable name="languageAttr" select="$packageDiv/items[@lang=$lang]/item[. = $cur]/@*"/>
                <xsl:attribute name="class" select="'packages'" />
                <xsl:apply-templates select="$languageAttr" />
            </xsl:if>
            
            <xsl:if test="matches($booleanValues, 'false')">
                <xsl:attribute name="class" select="'packages'" />
                <xsl:attribute name="id">
                    <xsl:value-of select="'no match languages file'"/>
                </xsl:attribute>
            </xsl:if>
            
            <xsl:apply-templates select="node()" />
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>