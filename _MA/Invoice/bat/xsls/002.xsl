<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:idPkg="http://ns.adobe.com/AdobeInDesign/idml/1.0/packaging"
    xmlns:ast="http://www.astkorea.net/" 
    exclude-result-prefixes="xs idPkg ast" 
    version="2.0">
    
    
    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="*"/>
    
    
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="roots">
        <xsl:variable name="var0">
            <xsl:copy>
                <xsl:for-each select="descendant::*[@tempID]">
                    <xsl:copy>
                        <xsl:apply-templates select="@*"/>
                    </xsl:copy>
                </xsl:for-each>
            </xsl:copy>
        </xsl:variable>

        <roots>
            <xsl:for-each-group select="$var0/roots/*" group-by="@tempID">
                <group>
                    <xsl:apply-templates select="current-group()" />
                </group>
            </xsl:for-each-group>
        </roots>
    </xsl:template>
    
</xsl:stylesheet>
