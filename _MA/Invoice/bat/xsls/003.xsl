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

    <xsl:template match="group[parent::roots]">
        <xsl:choose>
            <xsl:when test="count(child::*) &gt; 1">
                <xsl:variable name="var0">
                    <xsl:element name="{local-name(child::*[1])}">
                        <xsl:apply-templates select="*[1]/@*" />

                        <xsl:apply-templates select="*[2]" />
                    </xsl:element>
                </xsl:variable>

                <xsl:for-each select="$var0/*">
                    <xsl:variable name="childTwo" select="child::*[1]" />

                    <xsl:copy>
                        <xsl:for-each select="@*">
                            <xsl:variable name="name" select="local-name()" />
                            <xsl:choose>
                                <xsl:when test="string-length(.) eq 0">
                                    <xsl:attribute name="{$name}">
                                        <xsl:value-of select="$childTwo/@*[matches(local-name(), $name)]" />
                                    </xsl:attribute>
                                </xsl:when>
                            
                                <xsl:otherwise>
                                    <xsl:attribute name="{$name}" select="." />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:copy>
                </xsl:for-each>
            </xsl:when>
        
            <xsl:otherwise>
                <xsl:apply-templates select="node()" />
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>
