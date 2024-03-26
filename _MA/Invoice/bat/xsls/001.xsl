<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:idPkg="http://ns.adobe.com/AdobeInDesign/idml/1.0/packaging"
    xmlns:ast="http://www.astkorea.net/" 
    exclude-result-prefixes="xs idPkg ast" 
    version="2.0">
    
    
    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:param name="resourcdDir" />
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="srcDirs01" select="replace(replace(replace(replace($resourcdDir, ' ', '%20'), '\\', '/'), '\[', '%5B'), '\]', '%5D')" as="xs:string" />
    <xsl:variable name="srcDirs02" select="iri-to-uri(concat('file:////', $srcDirs01, '/?select=', '*.xml;recurse=yes'))" />
    <xsl:variable name="directory" select="collection($srcDirs02)" />
    
    
    <xsl:template match="@* | node()" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" mode="#current" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/">
        <roots>
            <xsl:for-each select="$directory/root">
                <xsl:copy>
                    <xsl:attribute name="filename" select="tokenize(base-uri(), '/')[last()]" />
                    <xsl:apply-templates select="@* | node()" mode="abc" />
                </xsl:copy>
            </xsl:for-each>
        </roots>
    </xsl:template>

    <xsl:template match="*[@id]" mode="abc">
        <xsl:copy>
            <xsl:if test="@id[string-length(.) &gt; 1]">
                <xsl:attribute name="tempID" select="@id" />
            </xsl:if>

            <xsl:apply-templates select="@* | node()" mode="abc"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
