<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

<xsl:variable name="myBase" select="//root()/*[contains(@class,' map/map ')][1]/@base"/>
	<!-- for only Study -->
    <xsl:attribute-set name="b_red">
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
        <xsl:attribute name="color">red</xsl:attribute>
    </xsl:attribute-set>

	<!-- for only Study -->
    <xsl:attribute-set name="i_blue">
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="color">blue</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="b">
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
    </xsl:attribute-set>

</xsl:stylesheet>