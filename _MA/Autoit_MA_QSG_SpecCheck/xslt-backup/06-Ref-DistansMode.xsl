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
    
    
    <xsl:template name="createDistanceP">
        <xsl:param name="lang" />
        <xsl:param name="cur" />
        
        <xsl:copy>
            <xsl:attribute name="class" select="'distance'" />
            <xsl:apply-templates select="@* except @class" />
            
            <xsl:variable name="booleanValues">
                <xsl:choose>
                    <xsl:when test="matches(., $distansDiv/items[@lang=$lang]/item)">
                        <xsl:value-of select="'true '"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'false '"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="twips">
                <twips>
                    <xsl:choose>
                       <xsl:when test="matches(., $distansDiv/items[@lang=$lang]/item)">
                           <xsl:variable name="Unit" select="$distansDiv/items[@lang=$lang]/item[contains($cur, '.')]/@unit"/>
                           <xsl:variable name="distanceCur" select="$distansDiv/items[@lang=$lang]/item[contains($cur, '.')]"/>
                           <xsl:variable name="curText" select="replace($distanceCur, '(.*)(\d[.,]\d\s?)(.*)', '$2')"/>
                           
                           
                           <xsl:if test="matches(., concat('\d[.,]\d\s?', $Unit))">
                               <xsl:variable name="value" select="concat($curText, $Unit)"/>
                               <twip>
                                   <xsl:call-template name="convert-to-twips">
                                       <xsl:with-param name="value" select="$value"/>
                                       <xsl:with-param name="Unit" select="$Unit" />
                                   </xsl:call-template>
                                   
                               </twip>
                           </xsl:if>
                       </xsl:when>
                    </xsl:choose>
                </twips>
            </xsl:variable>
            
            <xsl:if test="not(matches($booleanValues, 'false'))">
                <xsl:variable name="languageAttr" select="$distansDiv/items[@lang=$lang]/item[contains($cur, '.')]/@*"/>
                <xsl:attribute name="class" select="'distance'" />
                <xsl:apply-templates select="$languageAttr" />
                
                <xsl:attribute name="distansValue" select="concat($twips//twip, ' mm')" />
            </xsl:if>
            <xsl:copy-of select="$distansDiv/items[@lang=$lang]/item[contains($cur, '.')]/node()" />
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>