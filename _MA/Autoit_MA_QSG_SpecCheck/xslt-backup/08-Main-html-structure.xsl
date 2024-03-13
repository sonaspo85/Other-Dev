<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    
    exclude-result-prefixes="xs ast xsi">

    <xsl:strip-space elements="*"/>
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    
    <xsl:include href="00-CommonTemplate.xsl"/>
    <xsl:include href="08-Ref-otherSection.xsl"/>
    <xsl:include href="08-Ref-BandMode.xsl"/>
    <xsl:include href="08-Ref-DistansMode.xsl"/>
    <xsl:include href="08-Ref-ElectroMode.xsl"/>
    <xsl:include href="08-Ref-ProductMode.xsl"/>
    <!--<xsl:include href="08-Ref-RegistMode.xsl"/>-->
    <xsl:include href="08-Ref-SarsMode.xsl"/>
    <xsl:include href="08-Ref-PackageMode.xsl"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="root">
        <xsl:variable name="fileName" select="concat(ast:getPath(base-uri(.), '/'), '/outputHTML', '.xml')" />
        
        <xsl:result-document href="{$fileName}">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html></xsl:text>
            <html>
                <xsl:call-template name="HeadSection" />
                <body>
                    <ul>
                        <li><span style="color:red">빨간색 : Error</span></li>
                        <li><span style="color:blue">파란색 : 스펙 데이터</span></li>
                        <li><span style="color:black">검은색 : 인디자인 데이터</span></li>
                    </ul>
                    <h1>
                        <xsl:value-of select="@zipName"/>
                    </h1>
                    <p id="result"></p>
                    <xsl:for-each select="doc">
                        <xsl:for-each select="*">
                            <xsl:variable name="docLang" select="ancestor::doc/@lang"/>
                            <xsl:variable name="title">
                                <h3>
                                    <xsl:value-of select="concat(upper-case(@class), ' - ', $docLang)"/>
                                </h3>
                            </xsl:variable>
                            
                            <xsl:choose>
                                <!--  Exception -->
                                <xsl:when test="self::*[.='NullPointerException']">
                                    <xsl:copy-of select="$title" />
                                    <xsl:copy>
                                        <xsl:apply-templates select="@*" />
                                        <xsl:apply-templates select="." />
                                    </xsl:copy>
                                </xsl:when>
                                
                                <!-- ****** bandandmode ****** -->
                                <xsl:when test="self::Table[@class='bandandmode']">
                                    <xsl:copy-of select="$title" />
                                    <xsl:copy>
                                        <xsl:apply-templates select="@*, node()" />
                                    </xsl:copy>
                                </xsl:when>
                                
                                <!-- ****** sars ****** -->
                                <xsl:when test="self::Table[@class='sars']">
                                    <xsl:copy-of select="$title" />
                                    <xsl:copy>
                                        <xsl:apply-templates select="@*, node()" />
                                    </xsl:copy>
                                </xsl:when>
                                
                                <xsl:when test="self::p[@class='sars'][parent::doc]">
                                    <xsl:copy-of select="$title" />
                                    <xsl:apply-templates select="." />
                                </xsl:when>
                                
                                <!-- ****** distance ****** -->
                                <xsl:when test="self::*[@class='distance']">
                                    <xsl:copy-of select="$title" />
                                    <xsl:apply-templates select="." />
                                </xsl:when>
                                
                                <!-- ****** regNum ****** -->
                                <!--<xsl:when test="self::p[@class='regNum']">
                                    <xsl:copy-of select="$title" />
                                    <xsl:apply-templates select="." />
                                </xsl:when>-->
                                
                                <xsl:when test="self::Table[@class='regNum']">
                                    <xsl:copy-of select="$title" />
                                    <xsl:apply-templates select="." />
                                </xsl:when>
                                
                                <!-- ****** productSpec ****** -->
                                <xsl:when test="self::Table[@class='productSpec']">
                                    <xsl:copy-of select="$title" />
                                    <xsl:apply-templates select="." />
                                </xsl:when>
                                
                                <!-- ****** electronic ****** -->
                                <xsl:when test="self::Table[@class='electronic']">
                                    <xsl:copy-of select="$title" />
                                    <xsl:copy>
                                        <xsl:apply-templates select="@*, node()" />
                                    </xsl:copy>
                                </xsl:when>
                                
                                <!-- ****** packages ****** -->
                                <xsl:when test="self::ol[@class='packages']">
                                    <xsl:copy-of select="$title" />
                                    <Table>
                                        <xsl:apply-templates select="@*" />
                                        <xsl:apply-templates select="p" />
                                    </Table>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                        <xsl:if test="position() != last()">
                            <hr/>
                        </xsl:if>
                    </xsl:for-each>
                    <script type="text/javascript">
                        <xsl:text>var failNum = document.getElementsByClassName("fail").length;</xsl:text>
                        <xsl:text>var result = document.getElementById("result");</xsl:text>
                        <xsl:text>console.log(failNum);</xsl:text>
                        <xsl:text>if (failNum</xsl:text><xsl:text disable-output-escaping="no"> &gt; 0) {</xsl:text>
                        <xsl:text>result.innerHTML = "오류현황 : " + failNum + " 개";
                        }</xsl:text>
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="p">
        <xsl:variable name="preCls" select="parent::td/preceding-sibling::*[1]/p/@class"/>
        
        <xsl:choose>
            <!-- ****** packages ****** -->
            <xsl:when test="$preCls = 'bandandmode'">
                <xsl:call-template name="band-structure" />
            </xsl:when>
            
            <!-- ****** sars ****** -->
            <xsl:when test="$preCls = 'sars'">
                <xsl:call-template name="sars-structure" />
            </xsl:when>
            
            <xsl:when test="@class = 'sars' and parent::doc">
                <xsl:call-template name="sars-structure" />
            </xsl:when>
            
            <!-- ****** distance ****** -->
            <xsl:when test="@class = 'distance'">
                <xsl:call-template name="distans-structure" />
            </xsl:when>
            
            <!-- ****** regNum ****** -->
            <!--<xsl:when test="@class = 'regNum'">
                <xsl:call-template name="regist-structure" />
            </xsl:when>-->
            
            <!-- ****** productSpec ****** -->
            <xsl:when test="$preCls = 'productSpec'">
                <xsl:call-template name="prod-structure" />
            </xsl:when>
            
            <!-- ****** electronic ****** -->
            <xsl:when test="@class = 'electronic'">
                <xsl:call-template name="electro-structure" />
            </xsl:when>
            
            <!-- ****** packages ****** -->
            <xsl:when test="@class = 'packages'">
                <xsl:call-template name="package-structure" />
            </xsl:when>
            
            <!-- ****** Other ****** -->
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="div">
        <table>
            <tr>
                <td>
                    <span class="source fail">
                        There is no matching indesign data.
                    </span>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!--<xsl:template match="@columnPos | @bgcolor | @rowspan | @colspan | @excelBandValues | @pos | @id | @values | @Name | @classPar" />-->
    
</xsl:stylesheet>