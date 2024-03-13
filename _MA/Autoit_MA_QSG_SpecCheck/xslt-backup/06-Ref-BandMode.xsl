<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    exclude-result-prefixes="xs ast">
    <xsl:strip-space elements="*"/>
    
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    <xsl:template name="createBandP">
        <xsl:param name="specCheck" />
        <xsl:param name="lang" />
        <xsl:param name="cur" />
        <xsl:param name="byLocation" />
        
        <xsl:copy>
            <xsl:apply-templates select="@* except @class" /> 
            <xsl:choose>
                <xsl:when test="count(parent::td/preceding-sibling::td)+1 = $byLocation">
                    <xsl:choose>
                        <xsl:when test="matches(., '/')">
                            <xsl:variable name="splitP">
                                <xsl:call-template name="splitCall">
                                    <xsl:with-param name="cur" select="." />
                                </xsl:call-template>
                            </xsl:variable>
                            
                            <xsl:variable name="booleanValues">
                                <xsl:for-each select="$splitP/p">
                                    <xsl:call-template name="booleanCheck">
                                        <xsl:with-param name="specCheck" select="$specCheck" />
                                        <xsl:with-param name="specDiv" select="$bandDiv/items[@lang=$lang]/item" />
                                        <xsl:with-param name="cur" select="." />
                                        <xsl:with-param name="lang" select="$lang" />
                                    </xsl:call-template>
                                </xsl:for-each>
                            </xsl:variable>
                            
                            <xsl:choose>
                                <xsl:when test="not(matches($booleanValues, 'false'))">
                                    <xsl:variable name="languageAttr" select="$bandDiv/items[@lang=$lang]/item[. = $splitP/p]/@*"/>
                                    <xsl:apply-templates select="$languageAttr" />
                                    <xsl:attribute name="id">
                                        <xsl:for-each select="distinct-values($bandDiv/items[@lang=$lang]/item[. = $splitP/p]/@id)">
                                            <xsl:value-of select="."/>
                                            <xsl:if test="position() != last()">
                                                <xsl:value-of select="'/'"/>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </xsl:attribute>
                                    <xsl:attribute name="class" select="'bandandmode'" />
                                </xsl:when>
                                
                                <xsl:when test="parent::td/preceding-sibling::td[1]/p[. = '5G']">
                                    <xsl:attribute name="id" select="'5g'" />
                                    <xsl:attribute name="unit" select="'dBm'" />
                                    <xsl:attribute name="multi" select="'false'" />
                                    <xsl:attribute name="class" select="'bandandmode'" />
                                </xsl:when>
                                
                                <xsl:otherwise>
                                    <xsl:attribute name="languageDataDiff" select="'yes'" />
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:apply-templates select="node()" />
                        </xsl:when>
                        
                        <xsl:otherwise>
                            <xsl:variable name="booleanValues">
                                <xsl:call-template name="booleanCheck">
                                    <xsl:with-param name="specCheck" select="$specCheck" />
                                    <xsl:with-param name="specDiv" select="$bandDiv/items[@lang=$lang]/item" />
                                    <xsl:with-param name="cur" select="." />
                                    <xsl:with-param name="lang" select="$lang" />
                                </xsl:call-template>
                            </xsl:variable>
                            
                            <xsl:if test="not(matches($booleanValues, 'false'))">
                                <xsl:variable name="languageAttr" select="$bandDiv/items[@lang=$lang]/item[. = $cur]/@*"/>
                                <xsl:apply-templates select="$languageAttr" />
                            </xsl:if>
                            <xsl:attribute name="class" select="'bandandmode'" />
                            
                            <xsl:apply-templates select="node()" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="values">
                        <xsl:call-template name="decimalChange">
                            <xsl:with-param name="cur" select="$cur/text()" />
                        </xsl:call-template>
                    </xsl:attribute>
                    <xsl:apply-templates select="node()" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>