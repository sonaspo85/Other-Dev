<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    version="2.0">
	<xsl:variable name="myBase" select="//root()/*[contains(@class,' map/map ')][1]/@base"/>
	<xsl:attribute-set name="base-font">
		<xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
		<xsl:attribute name="line-height"><xsl:value-of select="$default-line-height"/></xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="common.title">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="substring-after($locale, '_') = 'KR'">SamsungOneKorean 600</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'ar'">SamsungOneArabic 600</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'fa'">SamsungOneArabic 600</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'he'">SamsungOneHebrew 600</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'he'">SamsungOneHebrew 600</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'th'">Tahoma-Bold</xsl:when>
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

	<xsl:attribute-set name="__fo__root" use-attribute-sets="base-font">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="substring-after($locale, '_') = 'KR'">SamsungOneKorean 400</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'ar'">SamsungOneArabic 400</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'fa'">SamsungOneArabic 400</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'he'">SamsungOneHebrew 400</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'th'">Tahoma</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'my'">
					<xsl:choose>
						<xsl:when test="matches($myBase, 'Zawgyi-One')">Zawgyi-One</xsl:when>
						<xsl:otherwise>SamsungOneMyanmar 600</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'TW'">SamsungSVDMedium_T_CN, SamsungOne 400</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'HK'">SamsungSVDMedium_T_CN, SamsungOne 400</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'CN'">SamsungSVDMedium_S_CN, SamsungOne 400</xsl:when>
				<xsl:otherwise>SamsungOne 400, SamsungSVDMedium_S_CN</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="xml:lang" select="translate($locale, '_', '-')"/>
		<xsl:attribute name="writing-mode" select="$writing-mode"/>
	</xsl:attribute-set>
	<xsl:attribute-set name="page-sequence.toc" use-attribute-sets="__force__page__count">
		<xsl:attribute name="format">1</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>
