<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <xsl:variable name="toc.text-indent" select="'0pt'"/>
    <xsl:variable name="toc.toc-indent" select="'0pt'"/>

    <xsl:attribute-set name="__toc__header" use-attribute-sets="common.title">
        <xsl:attribute name="space-before">0pt</xsl:attribute>
        <xsl:attribute name="space-after">0pt</xsl:attribute>
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="padding-top">0pt</xsl:attribute>
        <xsl:attribute name="color">rgb(0,84,166)</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__toc__chapter__content" use-attribute-sets="__toc__topic__content">
        <xsl:attribute name="font-size">15pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="space-before">20pt</xsl:attribute>
        <xsl:attribute name="padding-top">0pt</xsl:attribute>
        <xsl:attribute name="space-before.conditionality">discard</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__toc__topic__content">
        <xsl:attribute name="last-line-end-indent">0pt</xsl:attribute>
        <xsl:attribute name="end-indent">0pt</xsl:attribute>
        <xsl:attribute name="text-indent">
        	<xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">0mm</xsl:when>
                <xsl:when test="$level = 2">0mm</xsl:when>
                <xsl:when test="$level = 3">-10mm</xsl:when>
                <xsl:when test="$level = 4">0mm</xsl:when>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="text-align-last">left</xsl:attribute>
        <xsl:attribute name="font-family">
        	<xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">
					<xsl:choose>
						<xsl:when test="substring-before($locale, '_') = 'ko'">SamsungOneKorean 600</xsl:when>
						<xsl:otherwise>SamsungOne 600</xsl:otherwise>
					</xsl:choose>
                </xsl:when>
                <xsl:otherwise>
					<xsl:choose>
						<xsl:when test="substring-before($locale, '_') = 'ko'">SamsungOneKorean 400</xsl:when>
						<xsl:otherwise>SamsungOne 400</xsl:otherwise>
					</xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="font-size">
        	<xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">15pt</xsl:when>
                <xsl:when test="$level = 2">9pt</xsl:when>
                <xsl:when test="$level = 3">8pt</xsl:when>
                <xsl:when test="$level = 4">8pt</xsl:when>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="space-before">
        	<xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">
		            <xsl:choose>
		                <xsl:when test="not(preceding-sibling::*[contains(@class, ' concept/concept ')])">0mm</xsl:when>
		                <xsl:otherwise>20pt</xsl:otherwise>
		            </xsl:choose>
                </xsl:when>
                <xsl:when test="$level = 2">5mm</xsl:when>
                <xsl:when test="$level = 3">2mm</xsl:when>
                <xsl:when test="$level = 4">0mm</xsl:when>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-column">
        	<xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">auto</xsl:when>
                <xsl:when test="$level = 2">auto</xsl:when>
                <xsl:when test="$level = 3">always</xsl:when>
                <xsl:when test="$level = 4">auto</xsl:when>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">
        	<xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">always</xsl:when>
                <xsl:when test="$level = 2">always</xsl:when>
                <xsl:when test="$level = 3">auto</xsl:when>
                <xsl:when test="$level = 4">auto</xsl:when>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="line-height">140%</xsl:attribute>
        <xsl:attribute name="space-before.conditionality">discard</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__toc__indent">
        <xsl:attribute name="start-indent">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
            	<xsl:when test="$level = 3">10mm</xsl:when>
            	<xsl:otherwise>
            		<xsl:value-of select="concat($side-col-width, ' + (', string($level - 1), ' * ', $toc.toc-indent, ') + ', $toc.text-indent)"/>
            	</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__toc__page-number">
      <xsl:attribute name="start-indent">0mm</xsl:attribute>
      <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__toc__leader">
        <xsl:attribute name="leader-pattern">space</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="body" use-attribute-sets="base-font">
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>