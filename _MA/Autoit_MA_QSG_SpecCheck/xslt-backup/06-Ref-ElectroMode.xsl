<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    exclude-result-prefixes="xs ast">
    <xsl:strip-space elements="*"/>

    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    
    <xsl:template name="createElecP">
        <xsl:param name="specCheck" />
        <xsl:param name="lang" />
        <xsl:param name="oneP" />
        <xsl:param name="twoP" />
        <xsl:param name="cur" />
        <xsl:param name="byLocation" />
        
        <xsl:variable name="onePCompa" select="$elecDiv/items[@lang=$lang]/item[matches(@name, $oneP)]"/>
        <xsl:variable name="twoPCompa" select="$onePCompa/entries[matches(@name, $twoP)]"/>
        
        <xsl:copy>
            <xsl:apply-templates select="@* except @class" /> 
            <xsl:choose>
                <xsl:when test="count(parent::td/preceding-sibling::td)+1 = $byLocation">
                    <xsl:variable name="languageAttr">
                        <xsl:choose>
                            <xsl:when test="not($elecDiv/items[@lang=$lang]/item[matches(@name, $oneP)])">
                                <xsl:value-of select="'td[1] error'"/>
                            </xsl:when>
                            
                            <xsl:when test="$elecDiv/items[@lang=$lang]/item[matches(@name, $oneP)]">
                                <xsl:choose>
                                    <xsl:when test="not($onePCompa/entries[matches(@name, $twoP)])">
                                        <xsl:value-of select="'td[2] error'"/>
                                    </xsl:when>
                                    
                                    <xsl:when test="$onePCompa/entries[matches(@name, $twoP)]">
                                        <xsl:apply-templates select="$twoPCompa/entry[count($cur/preceding-sibling::*)+1]"/>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    
                    <xsl:attribute name="class" select="'electronic'" />
                    <xsl:apply-templates select="$languageAttr/*/@*" />
                    
                    <xsl:variable name="UnitspaceRemove">
                        <xsl:call-template name="UnitspaceRemoveCall">
                            <xsl:with-param name="cur" select="$cur" />
                        </xsl:call-template>
                    </xsl:variable>
                    
                    <xsl:attribute name="values">
                        <xsl:value-of select="replace($UnitspaceRemove, '\s+', '')"/>
                    </xsl:attribute>
                    
                    <xsl:apply-templates select="node()" />
                </xsl:when>
                
                <xsl:otherwise>
                    <xsl:if test="count(parent::td/preceding-sibling::td)+1 = 1">
                        <xsl:variable name="onePCompa" select="$elecDiv/items[@lang=$lang]/item[matches(@name, $oneP)]"/>
                        <xsl:apply-templates select="$onePCompa/@*"/>
                    </xsl:if>
                    
                    <xsl:if test="count(parent::td/preceding-sibling::td)+1 = 2">
                        <xsl:variable name="onePCompa" select="$elecDiv/items[@lang=$lang]/item[matches(@name, $oneP)]"/>
                        <xsl:variable name="twoPCompa" select="$onePCompa/entries[matches(@name, $cur)]"/>
                        <xsl:apply-templates select="$twoPCompa/@*"/>
                    </xsl:if>
                    
                    <xsl:apply-templates select="node()" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
        
        
        
        <!--<xsl:choose>
            <xsl:when test="parent::td[not(following-sibling::td)]">
                <p1>
                    <xsl:apply-templates select="@*, node()" />
                </p1>
            </xsl:when>
            <xsl:otherwise>
                <p2>
                    <xsl:apply-templates select="@*, node()" />
                </p2>
            </xsl:otherwise>
        </xsl:choose>-->
        
    </xsl:template>
    
</xsl:stylesheet>