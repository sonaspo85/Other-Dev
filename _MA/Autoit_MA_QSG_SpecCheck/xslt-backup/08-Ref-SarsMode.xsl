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
    
    
    <xsl:template name="sars-structure">
        <xsl:if test="ancestor::Table[@class='sars']">
            <xsl:choose>
                <xsl:when test="ancestor::tr[@pos &gt; 1]">
                    <xsl:variable name="preP" select="parent::td/preceding-sibling::*[1]/p[@sourceFalseValues != 'BandandmodeException' and @sourceFalseValues]"/>
                    <span>
                        <xsl:attribute name="class" select="if ($preP) then 'source fail' else 'source'" />
                        <xsl:apply-templates select="node()" />
                    </span>
                    
                    <xsl:choose>
                        <xsl:when test="$preP">
                            <xsl:call-template name="valuesSplit">
                                <xsl:with-param name="preP" select="$preP/@sourceFalseValues" />
                            </xsl:call-template>
                        </xsl:when>
                        
                        <xsl:otherwise>
                            <span>
                                <xsl:attribute name="class" select="'data-xlsx'" />
                                <xsl:value-of select="parent::td/preceding-sibling::*[1]/p/@sameExcelValues"/>
                            </span>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <span>
                        <xsl:attribute name="class" select="'data-xlsx'" />
                        <xsl:value-of select="parent::td/preceding-sibling::*[1]/p/@sameExcelValues"/>
                    </span>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        
        <xsl:if test="parent::doc">
            <xsl:variable name="preP" select="@sourceFalseValues"/>
            <xsl:variable name="lang" select="parent::doc/@lang"/>
            <xsl:variable name="cur" select="."/>
            
            <xsl:variable name="sameValues" select="$sarDiv/items[@lang=$lang]/item[matches($cur, .)]"/>
            <xsl:variable name="plus" select="concat($sameValues, '(\s+?)(\d+)([.,])?(\d+)(\s)(W/kg)')"/>
            
            <table>
                <tr>
                    <td colspan="2">
                        <xsl:value-of select="." />
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>
                            <xsl:text>Source distances: </xsl:text>
                        </p>
                        <span>
                            <xsl:attribute name="class" select="if ($preP) then 'source fail' else 'source'" />
                            <xsl:analyze-string select="." regex="{$plus}">
                                <xsl:matching-substring>
                                    <xsl:value-of select="regex-group(2)"/>
                                    <xsl:value-of select="regex-group(3)"/>
                                    <xsl:value-of select="regex-group(4)"/>
                                    <xsl:value-of select="regex-group(5)"/>
                                    <xsl:value-of select="regex-group(6)"/>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                        </span>
                    </td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="$preP">
                                <p>
                                    <xsl:text>Excel distances: </xsl:text>
                                </p>
                                
                                <xsl:call-template name="valuesSplit">
                                    <xsl:with-param name="preP" select="$preP" />
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <span>true</span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
            </table>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>