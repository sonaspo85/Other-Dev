<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    exclude-result-prefixes="xs ast">
    <xsl:strip-space elements="*"/>
    
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    <xsl:include href="00-CommonTemplate.xsl"/>
    <xsl:include href="06-Ref-BandMode.xsl"/>
    <xsl:include href="06-Ref-DistansMode.xsl"/>
    <xsl:include href="06-Ref-ElectroMode.xsl"/>
    <xsl:include href="06-Ref-ProductMode.xsl"/>
    <xsl:include href="06-Ref-RegistMode.xsl"/>
    <xsl:include href="06-Ref-SarsMode.xsl"/>
    <xsl:include href="06-Ref-PackageMode.xsl"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@* | node()" mode="mergedP">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" mode="mergedP" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:variable name="str0">
            <xsl:apply-templates  mode="mergedP"/>
        </xsl:variable>
        <xsl:apply-templates select="$str0/*" />
    </xsl:template>
    
    <xsl:template match="@* | node()" mode="abc">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" mode="abc" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="root">
        <xsl:result-document href="temp/06-spec-extract.xml">
            <xsl:variable name="extractSpacs">
                <root>
                    <xsl:apply-templates select="@*" />
                    <xsl:for-each select="doc">
                        <xsl:variable name="cur" select="."/>
                        <xsl:variable name="lang" select="@lang"/>
                        <xsl:copy>
                            <xsl:apply-templates select="@*" />
                            <xsl:for-each select="node()">
                                <xsl:choose>
                                    <!-- bandmode -->
                                    <xsl:when test="$lang=$bandDiv/items/@lang and 
                                        self::Table/tr[1]/td/descendant-or-self::*[.=$bandDiv/items/item[1]]">
                                        <xsl:copy>
                                            <xsl:attribute name="class" select="'bandandmode'" />
                                            <xsl:apply-templates select="@* except @class" />
                                            <xsl:apply-templates select="node()" mode="abc">
                                                <xsl:with-param name="specCheck" select="'bandandmode'"  tunnel="yes" />
                                            </xsl:apply-templates>
                                        </xsl:copy>
                                    </xsl:when>
                                    
                                    <!-- sars -->
                                    <xsl:when test="$lang=$sarDiv/items/@lang and 
                                        matches($lang, '(Chi\(Taiwan\)|Tha)') and 
                                        matches(., $sarDiv/items[@lang=$lang]/item[1])">
                                        <xsl:apply-templates select="." mode="abc" >
                                            <xsl:with-param name="specCheck" select="'sars'" tunnel="yes" />
                                        </xsl:apply-templates>
                                        
                                    </xsl:when>
                                    
                                    <xsl:when test="$lang=$sarDiv/items/@lang and 
                                        self::Table/tr[1]/td/descendant-or-self::*[.=$sarDiv/items/item[1]]">
                                        <xsl:copy>
                                            <xsl:attribute name="class" select="'sars'" />
                                            <xsl:apply-templates select="@* except @class" />
                                            <xsl:apply-templates select="node()" mode="abc">
                                                <xsl:with-param name="specCheck" select="'sars'"  tunnel="yes" />
                                            </xsl:apply-templates>
                                        </xsl:copy>
                                    </xsl:when>
                                    
                                    <!-- distance -->
                                    <xsl:when test="$lang=$distansDiv/items/@lang and 
                                        self::p[matches(., $distansDiv/items[@lang=$lang]/item)]">
                                        <xsl:apply-templates select="." mode="abc" >
                                            <xsl:with-param name="specCheck" select="'distance'" tunnel="yes" />
                                        </xsl:apply-templates>
                                    </xsl:when>
                                    
                                    <!-- registration -->
                                    <!--<xsl:when test="$lang=$registDiv/items/@lang and 
                                        self::p[matches(., $registDiv/items[@lang=$lang]/item)]">
                                        <xsl:apply-templates select="." mode="abc" >
                                        <xsl:with-param name="specCheck" select="'registration'" tunnel="yes" />
                                        </xsl:apply-templates>
                                        </xsl:when>-->
                                    
                                    <xsl:when test="$LangFeatures/codes/div[@region=$region]/code[@lang=$langSort/L]/@registration[. = 'true']">
                                        <xsl:variable name="regNum" select="$excelRegistMode/spec/@value"/>
                                        <xsl:if test="self::*[matches(., $regNum)]">
                                            <xsl:apply-templates select="." mode="abc" >
                                                <xsl:with-param name="specCheck" select="'registration'" tunnel="yes" />
                                            </xsl:apply-templates>
                                        </xsl:if>
                                    </xsl:when>
                                    
                                    <!-- productSpec -->
                                    <xsl:when test="$lang=$productDiv/items/@lang and 
                                        self::Table[preceding-sibling::*[1][. = $productDiv/items[@lang=$lang]/item]]">
                                        <xsl:copy>
                                            <xsl:attribute name="class" select="'productSpec'" />
                                            <xsl:apply-templates select="@* except @class" />
                                            <xsl:apply-templates select="node()" mode="abc">
                                                <xsl:with-param name="specCheck" select="'productSpec'"  tunnel="yes" />
                                            </xsl:apply-templates>
                                        </xsl:copy>
                                    </xsl:when>
                                    
                                    <!-- electronic -->
                                    <xsl:when test="$lang=$elecDiv/items/@lang and 
                                        self::Table[preceding-sibling::*[1][. = $elecDiv/items[@lang=$lang]/item[1]]]">
                                        <xsl:copy>
                                            <xsl:attribute name="class" select="'electronic'" />
                                            <xsl:apply-templates select="@* except @class" />
                                            <xsl:apply-templates select="node()" mode="abc">
                                                <xsl:with-param name="specCheck" select="'electronic'"  tunnel="yes" />
                                            </xsl:apply-templates>
                                        </xsl:copy>
                                    </xsl:when>
                                    
                                    <!-- packages -->
                                    <xsl:when test="$lang=$packageDiv/items/@lang and 
                                        self::ol[preceding-sibling::*[1][. = $packageDiv/items[@lang=$lang]/item[1]]]">
                                        <xsl:copy>
                                            <xsl:attribute name="class" select="'packages'" />
                                            <xsl:apply-templates select="@* except @class" />
                                            <xsl:apply-templates select="node()" mode="abc">
                                                <xsl:with-param name="specCheck" select="'packages'"  tunnel="yes" />
                                            </xsl:apply-templates>
                                        </xsl:copy>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:copy>
                    </xsl:for-each>
                </root>
            </xsl:variable>
            
            <root>
                <xsl:apply-templates select="@*" />
                <xsl:variable name="extractSpacs01">
                    <xsl:for-each-group select="$extractSpacs/root/doc[node()]" group-by="@lang">
                        <xsl:choose>
                            <xsl:when test="current-grouping-key()">
                                <doc lang="{current-group()[1]/@lang}">
                                    <xsl:apply-templates select="current-group()/node()" />
                                </doc>
                            </xsl:when>
                            <xsl:otherwise>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each-group>
                </xsl:variable>
                
                <xsl:for-each select="$extractSpacs01/doc">
                    <xsl:variable name="cur" select="."/>
                    <xsl:variable name="lang" select="@lang"/>
                    <xsl:variable name="nodeClass">
                        <xsl:for-each select="node()">
                            <xsl:copy>
                                <xsl:apply-templates select="@*" />
                            </xsl:copy>
                        </xsl:for-each>
                    </xsl:variable>
                    
                    <xsl:variable name="sameNode">
                        <xsl:for-each select="$codesAttr/group">
                            <xsl:variable name="groupLang" select="@lang"/>
                            <xsl:choose>
                                <xsl:when test="$groupLang = $lang">
                                    <xsl:for-each select="specList">
                                        <xsl:variable name="specList" select="." />
                                        <xsl:choose>
                                            <xsl:when test="$specList = $nodeClass/*/@class">
                                            </xsl:when>
                                            
                                            <xsl:otherwise>
                                                <xsl:element name="div">
                                                    <xsl:attribute name="class" select="$specList" />
                                                    <xsl:value-of select="'NullPointerException'"/>
                                                </xsl:element>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:variable>
                    
                    <xsl:copy>
                        <xsl:apply-templates select="@*, node()" />
                        <xsl:copy-of select="$sameNode" />
                    </xsl:copy>
                    <!--<xsl:copy-of select="$sameNode" />-->
                </xsl:for-each>
            </root>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="p" mode="abc">
        <xsl:param name="specCheck" tunnel="yes" />
        <xsl:variable name="lang" select="ancestor::doc/@lang"/>
        <xsl:variable name="cur" select="."/>
        <xsl:variable name="byLocation" select="if (count(ancestor::tr/td) = 3) then 2 else 1" as="xs:integer" />
        
        <xsl:if test="$specCheck = 'bandandmode'">
            <xsl:call-template name="createBandP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="byLocation" select="$byLocation" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'sars'">
            <xsl:call-template name="createSarsP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="byLocation" select="$byLocation" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'distance'">
            <xsl:call-template name="createDistanceP">
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="cur" select="$cur" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'registration'">
            <xsl:call-template name="createRegistP">
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="cur" select="$cur" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'productSpec'">
            <xsl:call-template name="createProductP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="byLocation" select="$byLocation" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'electronic'">
            <xsl:call-template name="createElecP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="oneP" select="ancestor::tr/td[1]/p" />
                <xsl:with-param name="twoP" select="ancestor::tr/td[2]/p" />
                <xsl:with-param name="cur" select="$cur" />
                <xsl:with-param name="byLocation" select="3" />
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$specCheck = 'packages'">
            <xsl:call-template name="createPackageP">
                <xsl:with-param name="specCheck" select="$specCheck" />
                <xsl:with-param name="lang" select="$lang" />
                <xsl:with-param name="cur" select="$cur" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>
        
    <!--<xsl:template match="td" mode="abc">
        <xsl:param name="specCheck" tunnel="yes" />
        <xsl:variable name="lang" select="ancestor::doc/@lang"/>
        <xsl:choose>
            <xsl:when test="$specCheck = 'electronic' and 
                              count(preceding-sibling::td)+1 = 3 and 
                              count(p) &gt; 1">
                
                <xsl:copy>
                    <xsl:apply-templates select="@*" />
                    <xsl:attribute name="pos" select="position()" />
                    
                    <xsl:element name="{name(*[1])}">
                        <xsl:apply-templates select="*[1]/@*" />
                        
                        
                        <xsl:for-each select="node()">
                            <xsl:apply-templates select="node()" />
                            <xsl:if test="position() != last()">
                                <xsl:text> </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:attribute name="pos" select="position()" />
                    <xsl:apply-templates select="@*, node()" mode="abc" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>-->
    
    <xsl:template match="td" mode="mergedP">
        <xsl:variable name="lang" select="ancestor::doc/@lang"/>
        <xsl:choose>
            <!-- electronic 인 경우 -->
            <xsl:when test="$lang=$elecDiv/items/@lang and 
                            ancestor::Table[preceding-sibling::*[1][. = $elecDiv/items[@lang=$lang]/item[1]]] and 
                            count(p) &gt; 1">
                
                <xsl:copy>
                    <xsl:apply-templates select="@*" />
                    <p>
                        <xsl:apply-templates select="*[1]/@*" />
                        <xsl:for-each select="node()">
                            <xsl:apply-templates select="node()" />
                            <xsl:if test="position() != last()">
                                <xsl:text> </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*, node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
        
    <xsl:template match="tr" mode="abc">
        <xsl:copy>
            <xsl:attribute name="pos" select="position()" />
            <xsl:apply-templates select="@*, node()" mode="abc" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="td" mode="abc">
        <xsl:copy>
            <xsl:attribute name="pos" select="position()" />
            <xsl:apply-templates select="@*, node()" mode="abc" />
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>