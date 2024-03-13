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
    
    
    <xsl:template name="distans-structure">
        <xsl:variable name="cur" select="."/>
        <xsl:variable name="falseValues" select="@sourceFalseValues"/>
        <xsl:variable name="lang" select="ancestor::doc/@lang"/>
        <xsl:variable name="Unit" select="$distansDiv/items[@lang=$lang]/item[contains($cur, '.')]/@unit"/>
        <xsl:variable name="distanceCur" select="$distansDiv/items[@lang=$lang]/item[contains($cur, '.')]"/>
        <xsl:variable name="curText" select="replace($distanceCur, '(.*)(\d[.,]\d\s?)(.*)', '$2')"/>
        <xsl:variable name="value" select="concat($curText, $Unit)"/>
        
        <table>
            <tr>
                <td colspan="2">
                    <xsl:copy-of select="." />
                </td>
            </tr>
            <tr>
                <td>
                    <p>
                        <xsl:text>Source distances: </xsl:text>
                    </p>
                    <span>
                        <xsl:attribute name="class" select="if ($falseValues) then 'source fail' else 'source'" />
                        <xsl:value-of select="$value"/>
                    </span>
                </td>
                <td>
                    <xsl:choose>
                        <xsl:when test="$falseValues">
                            <p>
                                <xsl:text>Excel distances: </xsl:text>
                            </p>
                            
                            <xsl:call-template name="valuesSplit">
                                <xsl:with-param name="preP" select="$falseValues" />
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <span>true</span>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
        </table>
    </xsl:template>
    
</xsl:stylesheet>