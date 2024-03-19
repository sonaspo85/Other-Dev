<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/" exclude-result-prefixes="xs ast">
    
    
    <xsl:character-map name="a">
        <xsl:output-character character="&amp;" string="&amp;" />
    </xsl:character-map>
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml"  />
    
   
    <xsl:variable name="ChangeFile" select="document(concat(ast:getPath(base-uri(.), '/'), '/output5.xml'))/root/List"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="root">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()"/>
        
            <xsl:text>&#xa;&#x9;</xsl:text>
            <CH-root>
                <xsl:apply-templates select="$ChangeFile" />
                <xsl:text>&#xa;&#x9;</xsl:text>
            </CH-root>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="List">
        <xsl:text>&#xa;&#x9;&#x9;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="@*, node()"/>
            <xsl:text>&#x9;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*[matches(name(), '(from|to)')]">
        <xsl:text>&#x9;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:value-of select="." disable-output-escaping="yes"/>
        </xsl:copy>
    </xsl:template>

    <xsl:function name="ast:getPath">
        <xsl:param name="str"/>
        <xsl:param name="char"/>
        <xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], $char)" />
    </xsl:function>

    <xsl:function name="ast:last">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="tokenize($str, $char)[last()]" />
    </xsl:function>

</xsl:stylesheet>
