﻿<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8" />
    <xsl:strip-space elements="*" />
    <xsl:preserve-space elements="p li" />

    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="body">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="h1 | h2 | h3 | h4 | p">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="ol[*[name()='ul'][@class='Sub-Bullet-1']]">
        <xsl:variable name="str0">
            <xsl:for-each-group select="*" group-adjacent="boolean(self::ul)">
                <xsl:choose>
                    <xsl:when test="current-grouping-key()">
                        <ul_grouping>
                            <xsl:apply-templates select="current-group()/preceding-sibling::*[1][name()='p']" />
                            <xsl:apply-templates select="current-group()" />
                        </ul_grouping>
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <xsl:apply-templates select="current-group()[name() !='p']" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each-group>
        </xsl:variable>
        
        <xsl:variable name="str1">
            <xsl:for-each-group select="$str0/*" group-adjacent="boolean(self::ul_grouping)">
                <xsl:choose>
                    <xsl:when test="current-group()[1][name()='ul_grouping']">
                        <ulgrouping_merged>
                            <xsl:apply-templates select="current-group()" />
                        </ulgrouping_merged>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:apply-templates select="current-group()" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each-group>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:variable name="str2">
                <xsl:for-each select="$str1/*">
                    <xsl:copy>
                        <xsl:apply-templates select="@* | node()" />
                        <xsl:if test="following-sibling::*[1][name()='ulgrouping_merged']">
                            <xsl:copy-of select="following-sibling::*[1][name()='ulgrouping_merged']/node()" />
                        </xsl:if>
                    </xsl:copy>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:apply-templates select="$str2/node()[name()!='ulgrouping_merged']" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="ul[@class='Sub-Bullet-1'][*[name()='ul'][@class='Sub-Bullet-2']]">
        <xsl:variable name="current" select="." />
        
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:for-each select="li">
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()" />
                    <xsl:if test="not(following-sibling::li)">
                        <xsl:copy-of select="$current/ul[@class='Sub-Bullet-2']" />
                    </xsl:if>
                </xsl:copy>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="ul[@class='Sub-Bullet-2'][parent::ul[@class='Sub-Bullet-1']]">
    </xsl:template>

    <xsl:template match="ul_grouping">
        <xsl:apply-templates />
    </xsl:template>

</xsl:stylesheet>