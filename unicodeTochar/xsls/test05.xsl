<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/" exclude-result-prefixes="xs ast">

    

    <xsl:character-map name="a">
        <xsl:output-character character="&amp;" string="&amp;" />
    </xsl:character-map>
    
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" />

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="pos">
        <xsl:variable name="cur" select="number(.)" />
        <!--<xsl:variable name="F-pos">
            <xsl:sequence select="parent::to/preceding-sibling::from[1]/b[$cur]" />
        </xsl:variable>-->
        
        <xsl:variable name="F-pos">
            <xsl:value-of select="concat('$', $cur)"/>
        </xsl:variable>

        <xsl:apply-templates select="$F-pos"/>
    </xsl:template>
    
    <xsl:template match="b">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="text()" priority="5">
        <xsl:variable name="aaa">
            <xsl:value-of select="replace(replace(replace(replace(replace(replace(replace(replace(replace(
                                ., '\\u', '&#x26;#x'),
                                '\|', ';|'),
                                '(\w+)\)', '$1;)'),
                                '([^\|\[\-\(])(&#x26;#x)', '$1;$2'),
                                '(\w+)$', '$1;'),
                                '(\w+)(\-)(&#x26;#)', '$1;$2$3'),
                                '(\w+)(\]\))', '$1;$2'),
                                '(\w+)(\]\+)(;)', '$1;$2'),
                                '(\$\d)(;)', '$1')" />
            <!--<xsl:value-of select="replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
                ., '\\u', '&#x26;#x'),
                '\|', ';|'),
                '(\w+)\)', '$1;)'),
                '([^\|\[\-\(])(&#x26;#x)', '$1;$2'),
                '(\w+)$', '$1;'),
                '(\w+)(\-)(&#x26;#)', '$1;$2$3'),
                '(\w+)(\]\))', '$1;$2'),
                '(\w+)(\]\+)(;)', '$1;$2'),
                '(\$\d)(;)', '$1'),
                '\?=', '^'),
                ';\|;', '|')" />-->
        </xsl:variable>
        <xsl:value-of select="$aaa"/>
    </xsl:template>
    
    <xsl:template match="*[matches(name(), '(from|to)')]">
        <xsl:copy>
            <xsl:attribute name="pos" select="parent::*/@pos" />
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:function name="ast:last">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="tokenize($str, $char)[last()]" />
    </xsl:function>

</xsl:stylesheet>
