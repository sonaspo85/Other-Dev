<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <xsl:template match="*[contains(@class,' hi-d/b ')]">
    	<xsl:choose>
    		<xsl:when test="./@outputclass='red'">
		        <fo:inline xsl:use-attribute-sets="b_red">
		            <xsl:call-template name="commonattributes"/>
		            <xsl:apply-templates/>
		        </fo:inline>
    		</xsl:when>
    		<xsl:otherwise>
		        <fo:inline xsl:use-attribute-sets="b">
		            <xsl:call-template name="commonattributes"/>
		            <xsl:apply-templates/>
		        </fo:inline>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class,' hi-d/i ')]">
    	<xsl:choose>
    		<xsl:when test="./@outputclass='blue'">
		        <fo:inline xsl:use-attribute-sets="i_blue">
		            <xsl:call-template name="commonattributes"/>
		            <xsl:apply-templates/>
		        </fo:inline>
    		</xsl:when>
    		<xsl:otherwise>
		        <fo:inline xsl:use-attribute-sets="i">
		            <xsl:call-template name="commonattributes"/>
		            <xsl:apply-templates/>
		        </fo:inline>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

</xsl:stylesheet>