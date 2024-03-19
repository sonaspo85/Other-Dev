<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/" exclude-result-prefixes="xs ast">

    <xsl:character-map name="a">
        <xsl:output-character character="&amp;" string="&amp;amp;" />
    </xsl:character-map>
    <xsl:output encoding="UTF-8" method="xml" />
    
    <xsl:key name="chRoot" match="root/CH-root/List" use="from" />
    <xsl:variable name="chRootVar" select="root/CH-root/List" />
    <xsl:variable name="ChangeFile" select="document(concat('file:////', 'E:/Dev_tool/unicodeTochar/Paragraph_Variable.xml'))"/>
    <xsl:param name="checkLang" />
    
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/">
        <root>
            <xsl:text>&#xa;</xsl:text>
            <xsl:for-each select="$ChangeFile/root/listitem/item[@LV_name = 'ENG']">
                <xsl:text>&#x9;</xsl:text>
                <xsl:element name="paragraph">
                    <xsl:attribute name="id" select="parent::*/@ID" />
                    <xsl:apply-templates select="node()" />
                </xsl:element>
                <xsl:text>&#xa;</xsl:text>
            </xsl:for-each>
        </root>
    </xsl:template>
    
    <xsl:template match="text()" priority="5">
        <xsl:analyze-string select="." regex="(~~)">
            <xsl:matching-substring>
                <next />
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    <xsl:function name="ast:last">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="tokenize($str, $char)[last()]" />
    </xsl:function>

</xsl:stylesheet>
