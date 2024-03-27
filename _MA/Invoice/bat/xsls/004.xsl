<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:idPkg="http://ns.adobe.com/AdobeInDesign/idml/1.0/packaging"
    xmlns:ast="http://www.astkorea.net/" 
    exclude-result-prefixes="xs idPkg ast" 
    version="2.0">
    
    <xsl:param name="tempDir" />
    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="srcDirs01" select="replace(replace(replace(replace(concat($tempDir, '/003.xml'), ' ', '%20'), '\\', '/'), '\[', '%5B'), '\]', '%5D')" as="xs:string" />
    <xsl:variable name="srcDirs02" select="document(iri-to-uri($srcDirs01))" />
    

    <xsl:variable name="threeF0">
        <roots>
            <xsl:for-each select="$srcDirs02/roots/*[@tempID]">
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
            </xsl:for-each>
        </roots>
    </xsl:variable>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
        
    </xsl:template>

    <xsl:template match="*[@tempID]">
        <xsl:variable name="srctempid" select="@tempID" />

        <xsl:copy>
            <xsl:choose>
                <xsl:when test="$srctempid = $threeF0/roots/*[@tempID]/@tempID">
                    <xsl:apply-templates select="$threeF0/roots/*[@tempID][@tempID = $srctempid]/@*[not(matches(name(.), 'tempID'))]" />
                    
                    <xsl:apply-templates select="node()" />
                </xsl:when>
            
                <xsl:otherwise>
                    <xsl:apply-templates select="@*, node()" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="roots">
        <xsl:apply-templates />
    </xsl:template>
    
</xsl:stylesheet>
