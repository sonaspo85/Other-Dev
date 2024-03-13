<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

<xsl:variable name="myBase" select="//root()/*[contains(@class,' map/map ')][1]/@base"/>
    <xsl:attribute-set name="cmdname">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="substring-after($locale, '_') = 'KR'">SamsungOneKorean 600</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'ar'">SamsungOneArabic 600</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'fa'">SamsungOneArabic 600</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'he'">SamsungOneHebrew 600</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'th'">Tahoma-Bold</xsl:when>
				<!-- <xsl:when test="substring-before($locale, '_') = 'my'">SamsungOneMyanmar 600</xsl:when> -->
				<xsl:when test="substring-before($locale, '_') = 'my'">
					<xsl:choose>
						<xsl:when test="matches($myBase, 'Zawgyi-One')">Zawgyi-One</xsl:when>
						<xsl:otherwise>SamsungOneMyanmar 600</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'TW'">SamsungSVDMedium_T_CN, SamsungOne 600</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'HK'">SamsungSVDMedium_T_CN, SamsungOne 600</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'CN'">SamsungSVDMedium_S_CN, SamsungOne 600</xsl:when>
				<xsl:otherwise>SamsungOne 600, SamsungSVDMedium_S_CN</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="color">rgb(0,84,166)</xsl:attribute>
		<xsl:attribute name="wrap-option">
			<xsl:choose>
				<xsl:when test="matches(substring-before($locale, '_'), 'ar|fa|he')">no-wrap</xsl:when>
				<xsl:otherwise>wrap</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="varname">
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="@outputclass = 'chi-btn'">SamsungSVDMedium_S_CN</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'KR'">inherit</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'ar'">inherit</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'fa'">inherit</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'he'">inherit</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'th'">inherit</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'my'">inherit</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'TW'">inherit</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'HK'">inherit</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'CN'">inherit</xsl:when>
				<xsl:otherwise>inherit</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>