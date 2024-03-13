<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="xs ast xsi functx">
    
    
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    <xsl:strip-space elements="*"/>
    
    <xsl:template name="compareExcelpackageP">
        <xsl:param name="specCheck" />
        <xsl:param name="cur" />
        <xsl:param name="lang" />
        <xsl:param name="valuesId" />
        
        <xsl:variable name="packItemCompare">
            <xsl:choose>
                <xsl:when test="$valuesId = $excelPackageMode/spec/@item and 
                                $excelPackageMode/spec[@item = $valuesId]/@supportstatus = 'Y'">
                    <xsl:value-of select="'true '"/>
                </xsl:when>
                
                <xsl:otherwise>
                    <xsl:value-of select="'false '"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="falseValues">
            <xsl:variable name="Cnt" select="count($excelPackageMode/spec)"/>
            
            <xsl:variable name="collect">
                <xsl:for-each select="$excelPackageMode/spec/@item">
                    <spec>
                        <xsl:apply-templates select="parent::*/@*" />
                        <xsl:value-of select="."/>
                    </spec>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:choose>
                <xsl:when test="$excelPackageMode/spec[@item != $valuesId]">
                    <xsl:call-template name="survive">
                        <xsl:with-param name="target" select="$collect/*" />
                        <xsl:with-param name="source" select="$valuesId" />
                        <xsl:with-param name="pos" select="count($cur/preceding-sibling::*)+1" />
                        <xsl:with-param name="cnt" select="$Cnt" />
                        <xsl:with-param name="cur" select="$cur" />
                    </xsl:call-template>
                </xsl:when>
                <!--<xsl:when test="$valuesId != $excelPackageMode/spec/@item and  
                                $excelPackageMode/spec[@item != $valuesId]">
                    <xsl:call-template name="survive">
                        <xsl:with-param name="target" select="$collect/*" />
                        <xsl:with-param name="source" select="$valuesId" />
                        <xsl:with-param name="pos" select="count($cur/preceding-sibling::*)+1" />
                        <xsl:with-param name="cnt" select="$Cnt" />
                    </xsl:call-template>
                </xsl:when>-->
            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="matches($packItemCompare, 'false')">
                <xsl:attribute name="compBool" select="'false'" />
                <xsl:attribute name="sourceFalseValues">
                    <xsl:value-of select="$falseValues"/>
                </xsl:attribute>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:attribute name="compBool" select="'true'" />
                <xsl:attribute name="sameExcelValues" select="$excelPackageMode/spec[@item = $valuesId]/@division" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>