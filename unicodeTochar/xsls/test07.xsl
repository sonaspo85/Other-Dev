<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/" exclude-result-prefixes="xs ast">

    <xsl:character-map name="a">
        <xsl:output-character character="&amp;" string="&amp;amp;" />
    </xsl:character-map>
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" />
    
    <xsl:key name="chRoot" match="root/CH-root/List" use="from" />
    <xsl:variable name="chRootVar" select="root/CH-root/List" />
    <xsl:variable name="ChangeFile" select="document(concat('file:////', 'E:/Dev_tool/unicodeTochar/output55.xml'))/root/List"/>
    <xsl:param name="checkLang" />
    
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()[ancestor::item[matches(@LV_name, $checkLang)]]">
        <xsl:variable name="cur" select="."/>

        <xsl:call-template name="changeTxt">
            <xsl:with-param name="cur" select="$cur" />
            <xsl:with-param name="limit" select="count($chRootVar)" as="xs:integer" />
            <xsl:with-param name="startPos" select="1" as="xs:integer" />
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="changeTxt">
        <xsl:param name="cur" />
        <xsl:param name="limit" />
        <xsl:param name="startPos" />
        
        
        
        <xsl:variable name="str0">
            <xsl:for-each select="$chRootVar/from">
                <xsl:sequence select="." />
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:variable name="str1">
            <xsl:for-each select="$chRootVar/to">
                <xsl:sequence select="." />
            </xsl:for-each>
        </xsl:variable>
            
        <xsl:analyze-string select="$cur" regex="{$str0/from[$startPos]}">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., $str0/from[$startPos], $str1/to[$startPos])"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:choose>
                    <xsl:when test="$startPos &lt; $limit">
                        <xsl:call-template name="changeTxt">
                            <xsl:with-param name="cur" select="." />
                            <xsl:with-param name="limit" select="$limit" as="xs:integer" />
                            <xsl:with-param name="startPos" select="$startPos + 1" as="xs:integer" />
                        </xsl:call-template>
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <xsl:value-of select="replace(., $str0/from[$limit], $str1/to[$limit])"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:non-matching-substring>
        </xsl:analyze-string>

    </xsl:template>
    
    <xsl:template match="CH-root" />
        
    
    
    <xsl:function name="ast:last">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="tokenize($str, $char)[last()]" />
    </xsl:function>

</xsl:stylesheet>
