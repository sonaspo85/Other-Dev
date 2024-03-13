<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    
    exclude-result-prefixes="xs ast xsi">

    <xsl:strip-space elements="*"/>
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    
    <xsl:template name="electro-structure">
        <xsl:choose>
            <xsl:when test="parent::td[@pos = 3]">
                <xsl:variable name="preP" select="@sourceFalseValues"/>
                <span>
                    <xsl:attribute name="class" select="if ($preP) then 'source fail' else 'source'" />
                    <xsl:apply-templates select="node()" />
                </span>
                
                <xsl:choose>
                    <xsl:when test="$preP">
                        <xsl:call-template name="valuesSplit">
                            <xsl:with-param name="preP" select="@sourceFalseValues" />
                        </xsl:call-template>
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <span>
                            <xsl:attribute name="class" select="'data-xlsx'" />
                            <xsl:value-of select="@sameExcelValues"/>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:attribute name="class" select="'data-xlsx'" />
                    <xsl:value-of select="@sameExcelValues"/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>