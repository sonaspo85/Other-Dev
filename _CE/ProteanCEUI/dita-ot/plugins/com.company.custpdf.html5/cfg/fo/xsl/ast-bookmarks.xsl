<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
                xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
                exclude-result-prefixes="xs opentopic-index opentopic opentopic-func ot-placeholder"
                version="2.0">

    <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="bookmark">
        <xsl:variable name="mapTopicref" select="key('map-id', @id)[1]"/>
        <xsl:variable name="topicTitle">
            <xsl:call-template name="getNavTitle"/>
        </xsl:variable>
    	<xsl:variable name="id" select="@id" />
        <xsl:choose>
          <xsl:when test="ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@product='html'"/>
          <xsl:when test="$mapTopicref[@toc = 'yes' or not(@toc)] or not($mapTopicref)">
          	<xsl:if test="string($topicTitle)">
	            <fo:bookmark>
	                <xsl:attribute name="internal-destination">
	                    <xsl:call-template name="generate-toc-id"/>
	                </xsl:attribute>
	                    <xsl:if test="$bookmarkStyle!='EXPANDED'">
	                        <xsl:attribute name="starting-state">hide</xsl:attribute>
	                    </xsl:if>
	                <fo:bookmark-title>
	                    <xsl:value-of select="normalize-space($topicTitle)"/>
	                </fo:bookmark-title>
	                <xsl:apply-templates mode="bookmark"/>
	            </fo:bookmark>
	        </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates mode="bookmark"/>
          </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>