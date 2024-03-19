<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/" exclude-result-prefixes="xs ast">

    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" />
    
    
    <xsl:key name="chRoot" match="root/CH-root/List" use="from" />
    <xsl:variable name="chRootVar" select="root/CH-root/List" />
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()" priority="5">
        <xsl:analyze-string select="." regex="/(&#x61;&#x62;&#x63;&#x64;([&#x66;-&#x75;])&#x7A;?)/g">
            <xsl:matching-substring>
                <a>
                    <xsl:value-of select="."/>
                </a>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <b>
                    <xsl:value-of select="."/>
                </b>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    <xsl:function name="ast:last">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="tokenize($str, $char)[last()]" />
    </xsl:function>

</xsl:stylesheet>
