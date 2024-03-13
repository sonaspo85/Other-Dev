<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    exclude-result-prefixes="xs ast">
    <xsl:strip-space elements="*"/>

    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    
    <xsl:template name="createSarsP">
        <xsl:param name="specCheck" />
        <xsl:param name="lang" />
        <xsl:param name="cur" />
        <xsl:param name="byLocation" required="no" />
        
        <xsl:copy>
            <xsl:apply-templates select="@* except @class" />
            <xsl:if test="$cur/ancestor::Table">
            <xsl:choose>
                <xsl:when test="count(parent::td/preceding-sibling::td)+1 = $byLocation">
                    <xsl:variable name="booleanValues">
                        <xsl:call-template name="booleanCheck">
                            <xsl:with-param name="specCheck" select="$specCheck" />
                            <xsl:with-param name="specDiv" select="$sarDiv/items[@lang=$lang]/item" />
                            <xsl:with-param name="cur" select="." />
                            <xsl:with-param name="lang" select="false()" />
                        </xsl:call-template>
                    </xsl:variable>
                    
                    <xsl:choose>
                        <xsl:when test="not(matches($booleanValues, 'false'))">
                            <xsl:variable name="languageAttr" select="$sarDiv/items[@lang=$lang]/item[. = $cur]/@*"/>
                            <xsl:attribute name="class" select="'sars'" />
                            <xsl:apply-templates select="$languageAttr" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="id">
                                <xsl:value-of select="'compare error'"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:apply-templates select="node()" />
                </xsl:when>
                
                <xsl:otherwise>
                    <xsl:variable name="preP" select="parent::*/preceding-sibling::*[1]/p" />
                    <xsl:variable name="languageUnit" select="$sarDiv/items[@lang=$lang]/item[. = $preP]/@unit"/>
                    <xsl:variable name="values" select="if (string-length($languageUnit) &gt; 0) then normalize-space(replace($cur/text(), $languageUnit, '')) else 'error'"/>
                    
                    <xsl:attribute name="values">
                        <xsl:call-template name="decimalChange">
                            <xsl:with-param name="cur" select="$values" />
                        </xsl:call-template>
                    </xsl:attribute>
                    <xsl:apply-templates select="node()" />
                </xsl:otherwise>
            </xsl:choose>
            </xsl:if>
            
            <xsl:if test="not(ancestor::Table)">
                <xsl:variable name="booleanValues">
                    <xsl:call-template name="booleanCheck">
                        <xsl:with-param name="specCheck" select="$specCheck" />
                        <xsl:with-param name="specDiv" select="$sarDiv/items[@lang=$lang]/item" />
                        <xsl:with-param name="cur" select="." />
                        <xsl:with-param name="lang" select="false()" />
                    </xsl:call-template>
                </xsl:variable>
                
                <xsl:choose>
                    <xsl:when test="not(matches($booleanValues, 'false'))">
                        <xsl:variable name="languageAttr" select="$sarDiv/items[@lang=$lang]/item[matches($cur, .)]/@*"/>
                        <xsl:attribute name="class" select="'sars'" />
                        <xsl:attribute name="values">
                            <xsl:variable name="sameValues" select="$sarDiv/items[@lang=$lang]/item[matches($cur, .)]"/>
                            <xsl:variable name="plus" select="concat($sameValues, '(\s+?)(\d+)([.,])?(\d+)(\s)(W/kg)')"/>
                            
                            <xsl:analyze-string select="$cur" regex="{$plus}">
                                <xsl:matching-substring>
                                    <xsl:value-of select="regex-group(2)"/>
                                    <xsl:value-of select="'.'"/>
                                    <xsl:value-of select="regex-group(4)"/>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                        </xsl:attribute>
                        
                        <xsl:apply-templates select="$languageAttr" />
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <xsl:attribute name="id">
                            <xsl:value-of select="'compare error'"/>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:apply-templates select="node()" />
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>