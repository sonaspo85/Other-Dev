<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    exclude-result-prefixes="xs dita-ot opentopic opentopic-func ot-placeholder opentopic-index"
    version="2.0">

    <xsl:variable name="myBase" select="//root()/*[contains(@class,' map/map ')][1]/@base"/>
    <xsl:template name="createTocHeader">
    	<fo:block-container position="absolute" top="-13mm" left="0mm">
	        <fo:block xsl:use-attribute-sets="__toc__header" id="{$id.toc}">
	            <xsl:apply-templates select="." mode="customTopicAnchor"/>
	            <xsl:call-template name="getVariable">
	                <xsl:with-param name="id" select="'Table of Contents'"/>
	            </xsl:call-template>
	        </fo:block>
	    </fo:block-container>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="toc">
        <xsl:param name="include"/>
        <xsl:variable name="topicLevel" as="xs:integer">
          <xsl:apply-templates select="." mode="get-topic-level"/>
        </xsl:variable>
        <xsl:variable name="astNavTitle" as="item()*">
            <xsl:call-template name="getNavTitle" />
        </xsl:variable>
        <xsl:if test="$topicLevel &lt; $tocMaximumLevel">
            <xsl:variable name="mapTopicref" select="key('map-id', @id)[1]"/>
        	<xsl:variable name="id" select="@id" />
            <xsl:choose>
              <!-- In a future version, suppressing Notices in the TOC should not be hard-coded. -->
			  <xsl:when test="ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@product='html'"/>
              <xsl:when test="$retain-bookmap-order and $mapTopicref/self::*[contains(@class, ' bookmap/notices ')]"/>
              <xsl:when test="$mapTopicref[@toc = 'yes' or not(@toc)] or (not($mapTopicref) and $include = 'true')">
              	<xsl:if test="$astNavTitle">
                	<fo:block xsl:use-attribute-sets="__toc__indent">
                        <xsl:variable name="tocItemContent">
                          <fo:basic-link xsl:use-attribute-sets="__toc__link">
                            <xsl:attribute name="internal-destination">
                              <xsl:call-template name="generate-toc-id"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]/revprop[@changebar]" mode="changebar">
                                <xsl:with-param name="changebar-id" select="concat(dita-ot:generate-changebar-id(.),'-toc')"/>
                            </xsl:apply-templates>
                            <xsl:if test="count(ancestor-or-self::*[contains(@class, ' topic/topic ')]) &gt; 2">
	                            <fo:inline-container width="10mm">
	                            	<fo:block margin-left="4mm">
		                                <fo:page-number-citation>
                                      <xsl:attribute name="font-family">
                                        <xsl:choose>
                                          <xsl:when test="substring-after($locale, '_') = 'KR'">SamsungOneKorean 400</xsl:when>
                                          <xsl:when test="substring-before($locale, '_') = 'ar'">SamsungOneArabic 400</xsl:when>
                                          <xsl:when test="substring-before($locale, '_') = 'fa'">SamsungOneArabic 400</xsl:when>
                                          <xsl:when test="substring-before($locale, '_') = 'he'">SamsungOneHebrew 400</xsl:when>
                                          <xsl:when test="substring-before($locale, '_') = 'th'">Tahoma</xsl:when>
                                          <!-- <xsl:when test="substring-before($locale, '_') = 'my'">SamsungOneMyanmar 450</xsl:when> -->
                                          <xsl:when test="substring-before($locale, '_') = 'my'">
                                            <xsl:choose>
                                              <xsl:when test="matches($myBase, 'Zawgyi-One')">Zawgyi-One</xsl:when>
                                              <xsl:otherwise>SamsungOneMyanmar 450</xsl:otherwise>
                                            </xsl:choose>
                                          </xsl:when>
                                          <xsl:when test="substring-after($locale, '_') = 'TW'">SamsungSVDMedium_T_CN, SamsungOne 400</xsl:when>
                                          <xsl:when test="substring-after($locale, '_') = 'HK'">SamsungSVDMedium_T_CN, SamsungOne 400</xsl:when>
                                          <xsl:when test="substring-after($locale, '_') = 'CN'">SamsungSVDMedium_S_CN, SamsungOne 400</xsl:when>
                                          <xsl:otherwise>SamsungOne 400, SamsungSVDMedium_S_CN</xsl:otherwise>
                                        </xsl:choose>
                                      </xsl:attribute>
		                                  <xsl:attribute name="ref-id">
		                                    <xsl:call-template name="generate-toc-id"/>
		                                  </xsl:attribute>
		                                </fo:page-number-citation>
	                                	<fo:leader xsl:use-attribute-sets="__toc__leader"/>
	                                </fo:block>
	                            </fo:inline-container>
	                        </xsl:if>
                            <xsl:apply-templates select="$mapTopicref" mode="tocPrefix"/>
                            <fo:inline xsl:use-attribute-sets="__toc__title">
                                <xsl:variable name="pulledNavigationTitle" as="item()*">
                                    <xsl:call-template name="getNavTitle" />
                                </xsl:variable>
                                <xsl:apply-templates select="$pulledNavigationTitle" mode="dropCopiedIds"/>
                            </fo:inline>
                            <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]/revprop[@changebar]" mode="changebar">
                                <xsl:with-param name="changebar-id" select="concat(dita-ot:generate-changebar-id(.),'-toc')"/>
                            </xsl:apply-templates>
                          </fo:basic-link>
                        </xsl:variable>
                        <xsl:choose>
                          <xsl:when test="not($mapTopicref)">
                            <xsl:apply-templates select="." mode="tocText">
                              <xsl:with-param name="tocItemContent" select="$tocItemContent"/>
                              <xsl:with-param name="currentNode" select="."/>
                            </xsl:apply-templates>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:apply-templates select="$mapTopicref" mode="tocText">
                              <xsl:with-param name="tocItemContent" select="$tocItemContent"/>
                              <xsl:with-param name="currentNode" select="."/>
                            </xsl:apply-templates>
                          </xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
                    <xsl:apply-templates mode="toc">
                        <xsl:with-param name="include" select="'true'"/>
                    </xsl:apply-templates>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates mode="toc">
                    <xsl:with-param name="include" select="'true'"/>
                </xsl:apply-templates>
              </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template match="node()" mode="tocText" priority="-10">
        <xsl:param name="tocItemContent"/>
        <xsl:param name="currentNode"/>
        <xsl:for-each select="$currentNode">
          <fo:block xsl:use-attribute-sets="__toc__topic__content">
              <xsl:copy-of select="$tocItemContent"/>
          </fo:block>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
