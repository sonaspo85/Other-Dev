<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    exclude-result-prefixes="xs ast">
    <xsl:strip-space elements="*"/>

    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    
    <xsl:template name="createProductP">
        <xsl:param name="specCheck" />
        <xsl:param name="lang" />
        <xsl:param name="cur" />
        <xsl:param name="byLocation" />
        
        <xsl:copy>
            <xsl:apply-templates select="@* except @class" /> 
            <xsl:choose>
                <xsl:when test="count(parent::td/preceding-sibling::td)+1 = $byLocation">
                    <xsl:variable name="booleanValues">
                        <xsl:call-template name="booleanCheck">
                            <xsl:with-param name="specCheck" select="$specCheck" />
                            <xsl:with-param name="specDiv" select="$productDiv/items[@lang=$lang]/item" />
                            <xsl:with-param name="cur" select="." />
                            <xsl:with-param name="lang" select="false()" />
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:if test="not(matches($booleanValues, 'false'))">
                        <xsl:variable name="languageAttr" select="$productDiv/items[@lang=$lang]/item[. = $cur]/@*"/>
                        <xsl:attribute name="class" select="'productSpec'" />
                        <xsl:apply-templates select="$languageAttr" />
                    </xsl:if>

                    <xsl:apply-templates select="node()" />
                </xsl:when>
                
                <xsl:otherwise>
                    <xsl:variable name="preP" select="$cur/parent::*/preceding-sibling::*[1]/*" />
                    <xsl:variable name="prePidextract" select="$productDiv/items[@lang=$lang]/item[. = $preP]/@id"/>
                    <xsl:variable name="sourceTextConvert">
                        <xsl:call-template name="TextConvertCall">
                            <xsl:with-param name="cur" select="$cur" />
                            <xsl:with-param name="prePID" select="$prePidextract" />
                        </xsl:call-template>
                    </xsl:variable>
                    
                    <xsl:attribute name="values">
                        <xsl:value-of select="$sourceTextConvert"/>
                    </xsl:attribute>
                    
                    <xsl:apply-templates select="node()" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>