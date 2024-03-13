<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    
    exclude-result-prefixes="xs ast xsi">
    
    <xsl:character-map name="tag">
        <xsl:output-character character='&gt;' string="&gt;"/>
    </xsl:character-map>
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" use-character-maps="tag" />
    
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*" priority="10">
        <xsl:variable name="depth" select="count(ancestor::*)" />
        <xsl:text>&#xA;</xsl:text>
        <xsl:for-each select="1 to $depth">
            <xsl:text>&#x9;</xsl:text>
        </xsl:for-each>
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
            <xsl:if test="count(*) &gt; 0">
                 <xsl:text>&#xA;</xsl:text>
                 <xsl:for-each select="1 to $depth">
                     <xsl:text>&#x9;</xsl:text>
                 </xsl:for-each>
             </xsl:if>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>