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
    
    <xsl:template name="compareExcelproductP">
        <xsl:param name="specCheck" />
        <xsl:param name="cur" />
        <xsl:param name="lang" />
        <xsl:param name="valuesId" />
        <xsl:param name="flwP" />
        
        <xsl:variable name="prodItemCompare">
            <xsl:choose>
                <xsl:when test="$valuesId = $excelProductMode/spec/@item and 
                                $excelProductMode/spec[@item = $valuesId]/@values != $flwP">
                    <xsl:value-of select="'false '"/>
                </xsl:when>
                
                <xsl:when test="$valuesId = $excelProductMode/sars/spec/@item and 
                                $excelProductMode/spec[@item = $valuesId]/@values = $flwP">
                    <xsl:value-of select="'true '"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="falseValues">
            <xsl:variable name="collect">
                <xsl:for-each select="$excelProductMode/spec[@item = $valuesId]">
                    <xsl:choose>
                        <xsl:when test="@values != $flwP">
                            <xsl:value-of select="concat(@item, '&#x23F5; ', @value)" />
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:value-of select="$collect"/>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="matches($prodItemCompare, 'false')">
                <xsl:attribute name="compBool" select="'false'" />
                <xsl:attribute name="sourceFalseValues" select="if (string-length($falseValues) &gt; 0) then $falseValues else 'productSpecException'" />
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:attribute name="compBool" select="'true'" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>