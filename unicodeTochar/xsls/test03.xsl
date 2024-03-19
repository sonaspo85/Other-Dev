<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/" exclude-result-prefixes="xs ast">

    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" />



    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="root">
        
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:apply-templates select="*" />
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="List">
        <xsl:text>&#xa;&#x9;</xsl:text>
        <List pos="{position()}">
            <xsl:apply-templates select="@*" />
            <xsl:apply-templates select="*" />
            <xsl:text>&#xa;&#x9;</xsl:text>
        </List>
    </xsl:template>
    
    <xsl:template match="from">
        <xsl:text>&#xa;&#x9;&#x9;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="to">
        <xsl:text>&#xa;&#x9;&#x9;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()" priority="5">
        <!--<xsl:value-of select="replace(replace(replace(replace(replace(
            ., '^(u&quot;)', ''),
            '^(u&quot;\()', ''),
            '\)$', ''),
            '(\\\\\d)', ''),
            '\\u', '&#x26;#x')" />-->
        <xsl:value-of select="replace(., 'u&quot;', '')"/>
    </xsl:template>
    
    
    <xsl:function name="ast:getName">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], '/')" />
    </xsl:function>

    <xsl:function name="ast:last">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="tokenize($str, $char)[last()]" />
    </xsl:function>

</xsl:stylesheet>
