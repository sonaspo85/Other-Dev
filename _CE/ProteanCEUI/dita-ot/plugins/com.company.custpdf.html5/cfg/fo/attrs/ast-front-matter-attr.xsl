<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
	
	<xsl:variable name="myBase" select="//root()/*[contains(@class,' map/map ')][1]/@base"/>
	<xsl:attribute-set name="__frontmatter__logo__container">
		<xsl:attribute name="position">absolute</xsl:attribute>
		<xsl:attribute name="top">14mm</xsl:attribute>
		<xsl:attribute name="left">
			<xsl:choose>
				<xsl:when test="matches(substring-before($locale, '_'), 'ar|fa|he')">0</xsl:when>
				<xsl:otherwise>15mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="right">
			<xsl:choose>
				<xsl:when test="matches(substring-before($locale, '_'), 'ar|fa|he')">15mm</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__frontmatter__title__container">
		<xsl:attribute name="position">absolute</xsl:attribute>
		<xsl:attribute name="top">
			<xsl:choose>
				<xsl:when test="substring-after($locale, '_') = 'KR'">89.7mm</xsl:when>
				<xsl:otherwise>107mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="left">
			<xsl:choose>
				<xsl:when test="substring-after($locale, '_') = 'KR'">13.13mm</xsl:when>
				<xsl:otherwise>15mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>		
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="width">180mm</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__frontmatter__textbox__container">
		<xsl:attribute name="position">absolute</xsl:attribute>
		<xsl:attribute name="top">
			<xsl:choose>
				<xsl:when test="substring-after($locale, '_') = 'KR'">206mm</xsl:when>
				<xsl:otherwise>207mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="left">50mm</xsl:attribute>
		<xsl:attribute name="width">
			<xsl:choose>
				<xsl:when test="substring-after($locale, '_') = 'KR'">120mm</xsl:when>
				<xsl:otherwise>110mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__frontmatter__logo__block">
		<xsl:attribute name="text-align">left</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__frontmatter__title__block">
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
						<xsl:otherwise>SamsungOneMyanmar 450</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'TW'">SamsungSVDMedium_T_CN, SamsungOne 400</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'HK'">SamsungSVDMedium_T_CN, SamsungOne 400</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'CN'">SamsungSVDMedium_S_CN, SamsungOne 400</xsl:when>
				<xsl:otherwise>SamsungOne 400, SamsungSVDMedium_S_CN</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="font-size">42pt</xsl:attribute>
		<xsl:attribute name="line-height">
			<xsl:choose>
				<xsl:when test="substring-before($locale, '_') = 'my'">1.6</xsl:when>
				<xsl:otherwise>1.4</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="letter-spacing">
			<xsl:choose>
				<xsl:when test="matches(substring-before($locale, '_'), 'ar|fa|he|my')">0</xsl:when>
				<xsl:otherwise>0.05em</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__frontmatter__blankline__leader">
		<xsl:attribute name="leader-pattern">rule</xsl:attribute>
		<xsl:attribute name="rule-thickness">1pt</xsl:attribute>
		<xsl:attribute name="leader-length">27mm</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__frontmatter__textbox__block">
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
						<xsl:otherwise>SamsungOneMyanmar 450</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'TW'">SamsungSVDMedium_T_CN, SamsungOne 400</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'HK'">SamsungSVDMedium_T_CN, SamsungOne 400</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'CN'">SamsungSVDMedium_S_CN, SamsungOne 400</xsl:when>
				<xsl:otherwise>SamsungOne 400, SamsungSVDMedium_S_CN</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="line-height">
			<xsl:choose>
				<xsl:when test="substring-before($locale, '_') = 'my'">1.5</xsl:when>
				<xsl:otherwise>1.2</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__frontmatter__blankline__block" use-attribute-sets="__frontmatter__textbox__block">
		<xsl:attribute name="padding-left">14.4pt</xsl:attribute>
		<xsl:attribute name="padding-after">14.4pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__frontmatter__external__link__block">
		<xsl:attribute name="padding-before">14.4pt</xsl:attribute>
		<xsl:attribute name="padding-after">14.4pt</xsl:attribute>
	</xsl:attribute-set>

</xsl:stylesheet>