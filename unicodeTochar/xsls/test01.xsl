<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/" exclude-result-prefixes="xs ast">

    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" />

    <xsl:param name="filename" />
    <xsl:param name="text-uri" as="xs:string" select="concat('file:////', replace($filename, '\\', '/'))"/>
    
    <xsl:param name="text-encoding" as="xs:string" select="'UTF-8'" />
    <xsl:variable name="text" select="unparsed-text($text-uri, $text-encoding)" />

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>


    <xsl:template match="/">
        <root ddd="{$text-uri}" sourcename="{$filename}">
            <xsl:variable name="aaa" select="replace(replace($text, '\n+', ''), '&#xD;', '')"/>
            <xsl:for-each select="$text">
                <xsl:call-template name="textReplace">
                    <xsl:with-param name="cur" select="$aaa" />
                </xsl:call-template>
            </xsl:for-each>
        </root>
    </xsl:template>

    <xsl:template name="textReplace">
        <xsl:param name="cur" />

        <xsl:analyze-string select="." regex="(rules\s=\s\[\s+)(\{{)(.*)([\s+\]]+)?(for rule)">
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)" />
                <xsl:value-of select="regex-group(2)" />
                <xsl:value-of select="regex-group(3)" />
                <xsl:value-of select="regex-group(4)" />
            </xsl:matching-substring>
            <xsl:non-matching-substring>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
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
