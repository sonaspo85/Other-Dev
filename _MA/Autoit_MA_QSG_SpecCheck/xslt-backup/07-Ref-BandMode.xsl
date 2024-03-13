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
    
    <xsl:template name="compareExcelBandP">
        <xsl:param name="specCheck" />
        <xsl:param name="cur" />
        <xsl:param name="lang" />
        <xsl:param name="valuesId" />
        <xsl:param name="flwP" />
        
        <xsl:if test="$cur[@multi = 'true']">
            <xsl:variable name="multisplit">
                <xsl:call-template name="bandmodeSplit">
                    <xsl:with-param name="valuesId" select="$valuesId" />
                    <xsl:with-param name="cur" select="$cur" />
                </xsl:call-template>
            </xsl:variable>
            
            <xsl:variable name="oputpowerCompare">
                <xsl:for-each select="$multisplit/split">
                    <xsl:variable name="curText" select="."/>
                    <xsl:choose>
                        <xsl:when test="$curText = $excelBandMode/*/@bandandmode and 
                                        $flwP != $excelBandMode/*[@bandandmode=$curText]/@values">
                            <xsl:value-of select="'false '"/>
                        </xsl:when>
                        
                        <xsl:when test="$curText = $excelBandMode/*/@bandandmode">
                            <xsl:value-of select="'true '"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="falseValues">
                <xsl:variable name="collect">
                    <xsl:for-each select="$excelBandMode/*[@bandandmode = $multisplit/split]">
                        <xsl:choose>
                            <xsl:when test="@values != $flwP">
                                <xsl:value-of select="concat(@bandandmode, '&#x23F5; ', @outputpower, ' &#x482; ')" />
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:value-of select="replace($collect, '( &#x482; )$', '')"/>
            </xsl:variable>
            
            <xsl:variable name="trueValues">
                <xsl:variable name="collect">
                    <xsl:for-each select="$excelBandMode/*[@bandandmode = $multisplit/split]">
                        <xsl:choose>
                            <xsl:when test="@values = $flwP">
                                <xsl:value-of select="concat(@outputpower, ' &#x482; ')" />
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:variable>
                
                <xsl:for-each select="distinct-values(tokenize(replace($collect, '( &#x482; )$', ''), ' &#x482; '))">
                    <xsl:value-of select="."/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:choose>
                <xsl:when test="$multisplit/split = $excelBandMode/*/@bandandmode and 
                                matches($oputpowerCompare, 'false')">
                    <xsl:attribute name="compBool" select="'false'" />
                    <xsl:attribute name="sourceFalseValues" select="if (string-length($falseValues) &gt; 0) then $falseValues else 'BandandmodeException'" />
                </xsl:when>
                
                <xsl:otherwise>
                    <xsl:attribute name="compBool" select="'true'" />
                    <xsl:attribute name="sameExcelValues" select="if (string-length($trueValues) &gt; 0) then $trueValues else 'BandandmodeException'" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        
        <xsl:if test="$cur[@multi = 'false']">
            <xsl:variable name="oputpowerCompare">
                <xsl:choose>
                    <xsl:when test="$valuesId = $excelBandMode/*/@bandandmode and 
                                    $excelBandMode/*[@bandandmode=$valuesId]">
                        <xsl:variable name="curbandSpec" select="$excelBandMode/*[@bandandmode=$valuesId]" />
                        <xsl:choose>
                            <xsl:when test="matches($flwP, '###')">
                                <xsl:for-each select="tokenize($flwP[matches(., '###')], ' ### ')">
                                    <xsl:variable name="curSource" select="."/>
                                    
                                    <xsl:choose>
                                        <xsl:when test="matches($curbandSpec[matches(@values, '###')]/@values, $curSource)">
                                            <xsl:value-of select="'true '"/>
                                        </xsl:when>
                                        <xsl:when test="not(matches($curbandSpec[matches(@values, '###')]/@values, $curSource))">
                                            <xsl:value-of select="'false '"/>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                            </xsl:when>
                            
                            <xsl:when test="$curbandSpec/@values != $flwP">
                                <xsl:value-of select="'false '"/>
                            </xsl:when>
                            
                            <xsl:otherwise>
                                <xsl:value-of select="'true '"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'attr ID error'"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="falseValues">
                <xsl:variable name="collect">
                    <xsl:for-each select="$excelBandMode/*[@bandandmode = $valuesId]">
                        <xsl:choose>
                            <xsl:when test="@values != $flwP">
                                <xsl:value-of select="concat(@bandandmode, '&#x23F5; ', @outputpower)" />
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:variable>
                
                <xsl:value-of select="$collect"/>
            </xsl:variable>
            
            <xsl:choose>
                <xsl:when test="matches($oputpowerCompare, 'false')">
                    <xsl:attribute name="compBool" select="'false'" />
                    <xsl:attribute name="sourceFalseValues" select="if (string-length($falseValues) &gt; 0) then $falseValues else 'BandandmodeException'" />
                </xsl:when>
                
                <xsl:otherwise>
                    <xsl:attribute name="compBool" select="'true'" />
                    <xsl:attribute name="sameExcelValues" select="$excelBandMode/*[@bandandmode = $valuesId]/@outputpower" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>