<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    xmlns:fo="some:fo" 
    exclude-result-prefixes="xs ast fo">
    <xsl:strip-space elements="*"/>

    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    
    <xsl:template name="createRegistP">
        <xsl:param name="lang" />
        <xsl:param name="cur" />
        
        <xsl:copy>
            <xsl:attribute name="class" select="'regNum'" />
            <xsl:apply-templates select="@* except @class" />
            
            <!--<xsl:variable name="booleanValues">
                <xsl:choose>
                    <xsl:when test="matches(., $registDiv/items[@lang=$lang]/item)">
                        <xsl:value-of select="'true '"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'false '"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:if test="not(matches($booleanValues, 'false'))">
                <xsl:variable name="languageAttr" select="$registDiv/items[@lang=$lang]/item[contains($cur, '.')]/@*"/>
                <xsl:attribute name="class" select="'regNum'" />
                <xsl:apply-templates select="$languageAttr" />
            </xsl:if>
            
            <xsl:variable name="registValues">
                <xsl:call-template name="registValCall">
                    <xsl:with-param name="cur" select="$cur" />
                    <xsl:with-param name="standard" select="$registDiv/items[@lang=$lang]/item[contains($cur, '.')]" as="xs:string" />
                </xsl:call-template>
            </xsl:variable>
            
            <xsl:attribute name="values">
                <xsl:value-of select="$registValues"/>
            </xsl:attribute>-->
            <xsl:variable name="languageAttr" select="$excelRegistMode/spec[matches($cur, @value)]/@*"/>
            <xsl:apply-templates select="$languageAttr" />
            <xsl:apply-templates select="node()" />
        </xsl:copy>
    </xsl:template>
    
    
    <!--<xsl:template name="registValCall">
        <xsl:param name="cur" />
        <xsl:param name="standard" />
        
        <xsl:variable name="plus" select="concat($standard, '(\s)?(PMKG)(.*)?(\d\d\d\d)(.*)')"/>
        
        <xsl:analyze-string select="$cur" regex="{$plus}">
            <xsl:matching-substring>
                <xsl:value-of select="replace($cur, '(.*)?(PMKG.*?\d\d\d\d)(\s?)(.*)', '$2')" />
            </xsl:matching-substring>
            <xsl:non-matching-substring>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>-->
</xsl:stylesheet>