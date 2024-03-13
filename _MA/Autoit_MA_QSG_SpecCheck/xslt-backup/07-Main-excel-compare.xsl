<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="xs ast xsi functx">
    
  
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    <xsl:strip-space elements="*"/>
    
    
    <xsl:include href="00-CommonTemplate.xsl"/>
    <xsl:include href="07-Ref-BandMode.xsl"/>
    <xsl:include href="07-Ref-DistansMode.xsl"/>
    <xsl:include href="07-Ref-ElectroMode.xsl"/>
    <xsl:include href="07-Ref-ProductMode.xsl"/>
    <xsl:include href="07-Ref-RegistMode.xsl"/>
    <xsl:include href="07-Ref-SarsMode.xsl"/>
    <xsl:include href="07-Ref-PackageMode.xsl"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="doc">
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:for-each-group select="node()" group-by="boolean(self::*[@class='regNum'])">
                <xsl:choose>
                    <xsl:when test="current-grouping-key()">
                        <Table class="regNum">
                            <tr>
                                <td>
                                    <xsl:for-each select="current-group()">
                                        <xsl:apply-templates select="." />
                                    </xsl:for-each>
                                </td>
                                <td>
                                    <p>
                                        <xsl:value-of select=" if (count(current-group()) = 2) then 'true' else 'false'"/>
                                    </p>
                                </td>
                            </tr>
                        </Table>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="current-group()" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each-group>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="p">
        <xsl:variable name="lang" select="ancestor::doc/@lang"/>
        
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            
            <xsl:if test="ancestor::Table[@class = 'bandandmode']">
                <xsl:choose>
                    <xsl:when test="@multi = 'true'">
                        <xsl:call-template name="CompareBoolean">
                            <xsl:with-param name="specCheck" select="ancestor::Table/@class" />
                            <xsl:with-param name="cur" select="." />
                            <xsl:with-param name="lang" select="$lang" />
                            <xsl:with-param name="valuesId" select="@id" />
                            <xsl:with-param name="flwP" select="parent::td/following-sibling::td[1]/p/@values" />
                        </xsl:call-template>
                    </xsl:when>
                    
                    <xsl:when test="@multi = 'false'">
                        <xsl:call-template name="CompareBoolean">
                            <xsl:with-param name="specCheck" select="ancestor::Table/@class" />
                            <xsl:with-param name="cur" select="." />
                            <xsl:with-param name="lang" select="$lang" />
                            <xsl:with-param name="valuesId" select="@id" />
                            <xsl:with-param name="flwP" select="parent::td/following-sibling::td[1]/p/@values" />
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:if>
            
            <xsl:if test="ancestor::Table[@class = 'sars']">
                <xsl:choose>
                    <xsl:when test="parent::td[@pos = 1]/parent::tr[@pos &gt; 1]">
                        <xsl:call-template name="CompareBoolean">
                            <xsl:with-param name="specCheck" select="ancestor::Table/@class" />
                            <xsl:with-param name="cur" select="." />
                            <xsl:with-param name="lang" select="$lang" />
                            <xsl:with-param name="region" select="ancestor::doc/@region" />
                            <xsl:with-param name="valuesId" select="@id" />
                            <xsl:with-param name="flwP" select="parent::td/following-sibling::td[1]/p/@values" />
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:if>
            
            <xsl:if test="self::p[@class = 'sars'][parent::doc]">
                <xsl:call-template name="CompareBoolean">
                    <xsl:with-param name="specCheck" select="@class" />
                    <xsl:with-param name="cur" select="." />
                    <xsl:with-param name="lang" select="$lang" />
                    <xsl:with-param name="region" select="ancestor::doc/@region" />
                    <xsl:with-param name="valuesId" select="@id" />
                    <xsl:with-param name="flwP" select="@values" />
                </xsl:call-template>
            </xsl:if>
            
            <xsl:if test="self::*[@class = 'distance']">
                <xsl:call-template name="CompareBoolean">
                    <xsl:with-param name="specCheck" select="@class" />
                    <xsl:with-param name="cur" select="." />
                    <xsl:with-param name="lang" select="$lang" />
                    <xsl:with-param name="valuesId" select="@id" />
                    <xsl:with-param name="flwP" select="@distansValue" />
                </xsl:call-template>
            </xsl:if>
            
            <xsl:if test="self::*[@class = 'regNum']">
                <xsl:call-template name="CompareBoolean">
                    <xsl:with-param name="specCheck" select="@class" />
                    <xsl:with-param name="cur" select="." />
                    <xsl:with-param name="lang" select="$lang" />
                    <xsl:with-param name="valuesId" select="@id" />
                    <xsl:with-param name="flwP" select="false()" />
                    <xsl:with-param name="root" select="ancestor::doc" />
                </xsl:call-template>
            </xsl:if>
            
            <xsl:if test="ancestor::Table[@class = 'productSpec']">
                <xsl:choose>
                    <xsl:when test="parent::td[@pos = 1]">
                        <xsl:call-template name="CompareBoolean">
                            <xsl:with-param name="specCheck" select="ancestor::Table/@class" />
                            <xsl:with-param name="cur" select="." />
                            <xsl:with-param name="lang" select="$lang" />
                            <xsl:with-param name="valuesId" select="@id" />
                            <xsl:with-param name="flwP" select="parent::td/following-sibling::td[1]/p/@values" />
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:if>
            
            <xsl:if test="ancestor::Table[@class = 'electronic']">
                <xsl:choose>
                    <xsl:when test="parent::td[@pos = 3]">
                        <xsl:call-template name="CompareBoolean">
                            <xsl:with-param name="specCheck" select="ancestor::Table/@class" />
                            <xsl:with-param name="cur" select="." />
                            <xsl:with-param name="lang" select="$lang" />
                            <xsl:with-param name="valuesId" select="@id" />
                            <xsl:with-param name="flwP" select="false()" />
                            <xsl:with-param name="preP" select="ancestor::tr/td[1]/p/@id" />
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:if>
            
            <xsl:if test="ancestor::ol[@class = 'packages']">
                <xsl:call-template name="CompareBoolean">
                    <xsl:with-param name="specCheck" select="ancestor::ol/@class" />
                    <xsl:with-param name="cur" select="." />
                    <xsl:with-param name="lang" select="$lang" />
                    <xsl:with-param name="valuesId" select="@id" />
                    <xsl:with-param name="flwP" select="false()" />
                </xsl:call-template>
            </xsl:if>
            
            <xsl:apply-templates select="node()" />
        </xsl:copy>
        <!--<bb>
            <xsl:copy-of select="$excelBandMode/*" />
        </bb>-->
    </xsl:template>
    
    <xsl:template name="CompareBoolean">
        <xsl:param name="specCheck" />
        <xsl:param name="cur" />
        <xsl:param name="lang" />
        <xsl:param name="region" required="no" />
        <xsl:param name="valuesId" />
        <xsl:param name="flwP" required="no" />
        <xsl:param name="preP" required="no" />
        <xsl:param name="root" required="no" />
        
        <xsl:if test="$specCheck = 'bandandmode'">
            <xsl:call-template name="compareExcelBandP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="valuesId" select="$valuesId" />
                <xsl:with-param name="flwP" select="$flwP" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'sars'">
            <xsl:call-template name="compareExcelSarsP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="region" select="$region" />
                <xsl:with-param name="valuesId" select="$valuesId" />
                <xsl:with-param name="flwP" select="$flwP" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'distance'">
            <xsl:call-template name="compareExcelDistansP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="valuesId" select="$valuesId" />
                <xsl:with-param name="flwP" select="$flwP" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'regNum'">
            <xsl:call-template name="compareExcelregistP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="valuesId" select="$valuesId" />
                <xsl:with-param name="root" select="$root" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'productSpec'">
            <xsl:call-template name="compareExcelproductP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="valuesId" select="$valuesId" />
                <xsl:with-param name="flwP" select="$flwP" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'electronic'">
            <xsl:call-template name="compareExcelelectroP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="valuesId" select="$valuesId" />
                <xsl:with-param name="preP" select="$preP" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'packages'">
            <xsl:call-template name="compareExcelpackageP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="valuesId" select="$valuesId" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>