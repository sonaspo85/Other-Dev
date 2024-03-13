<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
	xmlns:ast="http://www.astkorea.net/"
    exclude-result-prefixes="ast"
    version="2.0">

	<xsl:variable name="myBase" select="//root()/*[contains(@class,' map/map ')][1]/@base"/>
	<!-- note indent -->
    <xsl:attribute-set name="note__table" use-attribute-sets="common.block">
		<xsl:attribute name="margin-left">2mm</xsl:attribute>
    </xsl:attribute-set>

	<!-- chapter title -->
    <xsl:attribute-set name="topic.title" use-attribute-sets="common.title common.border__bottom">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="substring-after($locale, '_') = 'KR'">SamsungOneKorean 500</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'ar'">SamsungOneArabic 450</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'fa'">SamsungOneArabic 450</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'he'">SamsungOneHebrew 450</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'th'">Tahoma-Bold</xsl:when>
				<!-- <xsl:when test="substring-before($locale, '_') = 'my'">SamsungOneMyanmar 450</xsl:when> -->
				<xsl:when test="substring-before($locale, '_') = 'my'">
					<xsl:choose>
						<xsl:when test="matches($myBase, 'Zawgyi-One')">Zawgyi-One</xsl:when>
						<xsl:otherwise>SamsungOneMyanmar 450</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'TW'">SamsungSVDMedium_T_CN, SamsungOne 500</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'HK'">SamsungSVDMedium_T_CN, SamsungOne 500</xsl:when>
				<xsl:when test="substring-after($locale, '_') = 'CN'">SamsungSVDMedium_S_CN, SamsungOne 500</xsl:when>
				<xsl:otherwise>SamsungOne 500, SamsungSVDMedium_S_CN</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="font-size">28pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="line-height">120%</xsl:attribute>
        <xsl:attribute name="padding-top">0mm</xsl:attribute>
		<xsl:attribute name="margin-left">
			<xsl:choose>
				<xsl:when test="matches(substring-before($locale, '_'), 'ar|he|fa')">0mm</xsl:when>
				<xsl:otherwise>4mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="margin-right">
			<xsl:choose>
				<xsl:when test="matches(substring-before($locale, '_'), 'ar|he|fa')">2mm</xsl:when>
				<xsl:otherwise>0mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="padding-bottom">5.8mm</xsl:attribute>
        <xsl:attribute name="space-after">5mm</xsl:attribute>
	    <xsl:attribute name="border-after-style">none</xsl:attribute>
	    <xsl:attribute name="border-after-width">0pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
		<xsl:attribute name="page-break-before">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.title" use-attribute-sets="common.title common.border__bottom">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*/title[contains(@outputclass, 'Subchapter')]">
					<xsl:choose>
						<xsl:when test="substring-after($locale, '_') = 'KR'">SamsungOneKorean 700</xsl:when>
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
						<xsl:when test="substring-after($locale, '_') = 'TW'">SamsungSVDMedium_T_CN, SamsungOne 700</xsl:when>
						<xsl:when test="substring-after($locale, '_') = 'HK'">SamsungSVDMedium_T_CN, SamsungOne 700</xsl:when>
						<xsl:when test="substring-after($locale, '_') = 'CN'">SamsungSVDMedium_S_CN, SamsungOne 700</xsl:when>
						<xsl:otherwise>SamsungOne 700, SamsungSVDMedium_S_CN</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
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
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*/title[contains(@outputclass, 'Subchapter')]">24pt</xsl:when>
				<xsl:otherwise>18pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="line-height">140%</xsl:attribute>
        <xsl:attribute name="padding-top">0mm</xsl:attribute>
        <!-- Here I am -->
		<xsl:attribute name="padding-bottom">2mm</xsl:attribute>
    	<xsl:attribute name="margin-left">0mm</xsl:attribute>
        <xsl:attribute name="space-before">
			<xsl:choose>
				<xsl:when test="matches(substring-before($locale, '_'), 'hr|hu|kk|el|mk|pl|ru|sl|sk')">9mm</xsl:when>
				<xsl:otherwise>11mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="space-after">3.5mm</xsl:attribute>
	    <xsl:attribute name="border-after-style">none</xsl:attribute>
	    <xsl:attribute name="border-after-width">0pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
		<xsl:attribute name="page-break-before">auto</xsl:attribute>
		<xsl:attribute name="keep-with-previous">auto</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.title" use-attribute-sets="common.title">
        <xsl:attribute name="space-before">
			<xsl:choose>
				<xsl:when test="matches(substring-before($locale, '_'), 'hr|hu|kk|el|mk|pl|ru|sl|sk')">6mm</xsl:when>
				<xsl:otherwise>8mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="space-after">
			<xsl:choose>
				<xsl:when test="matches(substring-before($locale, '_'), 'hr|hu|kk|el|mk|pl|ru|sl|sk')">3mm</xsl:when>
				<xsl:otherwise>4mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*/title[contains(@outputclass, 'Subchapter')]">18pt</xsl:when>
				<xsl:otherwise>15pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="line-height">140%</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.title" use-attribute-sets="common.title">
        <xsl:attribute name="space-before">6mm</xsl:attribute>
        <xsl:attribute name="space-after">1mm</xsl:attribute>
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*/title[contains(@outputclass, 'Subchapter')]">15pt</xsl:when>
				<xsl:otherwise>12pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.topic.title" use-attribute-sets="common.title">
        <xsl:attribute name="space-before">6mm</xsl:attribute>
        <xsl:attribute name="space-after">1mm</xsl:attribute>
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*/title[contains(@outputclass, 'Subchapter')]">12pt</xsl:when>
				<xsl:otherwise>10pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ast-shortdesc-spacing" use-attribute-sets="body">
        <xsl:attribute name="space-before">0mm</xsl:attribute>
        <xsl:attribute name="space-after">3mm</xsl:attribute>
        <xsl:attribute name="space-before.precedence">3</xsl:attribute>
        <xsl:attribute name="space-after.precedence">3</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ast-shortdesc-highlight">
        <!--<xsl:attribute name="padding-before">0.25em</xsl:attribute>
        <xsl:attribute name="padding-after">0.15em</xsl:attribute>-->
    	<xsl:attribute name="background-color">rgb(201,223,244)</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ast-warning" use-attribute-sets="common.block">
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
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="line-height">16pt</xsl:attribute>
		<xsl:attribute name="color">rgb(255,0,0)</xsl:attribute>
		<xsl:attribute name="space-before">5mm</xsl:attribute>
        <xsl:attribute name="space-after">5mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="note" use-attribute-sets="common.block">
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
		<xsl:attribute name="font-size">
			<xsl:choose>
				<xsl:when test="@type='warning'">10pt</xsl:when>
				<xsl:otherwise>9pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="line-height">
			<xsl:choose>
				<xsl:when test="@type='warning'">16pt</xsl:when>
				<xsl:otherwise>14pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="color">
			<xsl:choose>
				<xsl:when test="@type='warning'">rgb(255,0,0)</xsl:when>
				<xsl:otherwise>rgb(120,120,120)</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="space-after">3mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="note__text__entry">
		<xsl:attribute name="start-indent">
			<xsl:choose>
				<xsl:when test="@type='warning'">-4mm</xsl:when>
				<xsl:otherwise>-6mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="image__block">
		<xsl:attribute name="margin-left">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*[contains(@outputclass, 'license')]">0mm</xsl:when>
				<xsl:otherwise>15mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="margin-right">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*[contains(@outputclass, 'license')]">0mm</xsl:when>
				<xsl:otherwise>15mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="space-before">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*[contains(@outputclass, 'no-margin')]">0mm</xsl:when>
				<xsl:otherwise>6mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="space-after">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*[contains(@outputclass, 'no-margin')]">2mm</xsl:when>
				<xsl:when test="ancestor-or-self::*[contains(@outputclass, 'license')]">2mm</xsl:when>
				<xsl:otherwise>6mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
		<xsl:attribute name="content-height">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*[contains(@outputclass, 'license')]">110%</xsl:when>
				<xsl:when test="@height"><xsl:value-of select="@height"/></xsl:when>
				<xsl:otherwise>auto</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="width">
			<xsl:choose>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:otherwise>100%</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="scaling">uniform</xsl:attribute>
		<xsl:attribute name="text-align">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*[contains(@outputclass, 'license')]">start</xsl:when>
				<xsl:otherwise>center</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="image__inline">
        <xsl:attribute name="content-width">auto</xsl:attribute>
        <xsl:attribute name="content-height">auto</xsl:attribute>
        <xsl:attribute name="width">auto</xsl:attribute>
        <xsl:attribute name="scaling">uniform</xsl:attribute>
    </xsl:attribute-set>

	<!-- FOP only -->
    <xsl:attribute-set name="image__trynow">
        <xsl:attribute name="baseline-shift">
			<xsl:choose>
				<xsl:when test="substring-before($locale, '_') = 'zh'">-0.75mm</xsl:when>
				<xsl:otherwise>-1mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="note__image__entry">
        <xsl:attribute name="padding-end">5pt</xsl:attribute>
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
		<xsl:attribute name="padding-top">
			<xsl:choose>
				<xsl:when test="image">
					<xsl:variable name="str">
						<xsl:value-of select="image[1]/preceding-sibling::node()"/>
					</xsl:variable>
					<xsl:choose>
		        		<xsl:when test="string-length($str) &gt; 130">0pt</xsl:when>
				        <xsl:when test=".//image">
				        	<xsl:choose>
				        		<xsl:when test=".//image[1][@height &gt;= 17]">4pt</xsl:when>
				        		<xsl:when test=".//image[1][@height &gt;= 13]">3pt</xsl:when>
				        		<xsl:when test=".//image[1][@height &gt;= 11]">1pt</xsl:when>
						        <xsl:otherwise>0pt</xsl:otherwise>
						    </xsl:choose>
				        </xsl:when>
				        <xsl:otherwise>0pt</xsl:otherwise>
		        	</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="str">
						<xsl:value-of select="node()[1][self::text()]"/>
					</xsl:variable>
					<xsl:choose>
		        		<xsl:when test="string-length($str) &gt; 130">0pt</xsl:when>
				        <xsl:when test=".//image">
				        	<xsl:choose>
				        		<xsl:when test=".//image[1][@height &gt;= 17]">4pt</xsl:when>
				        		<xsl:when test=".//image[1][@height &gt;= 13]">3pt</xsl:when>
				        		<xsl:when test=".//image[1][@height &gt;= 11]">1pt</xsl:when>
						        <xsl:otherwise>0pt</xsl:otherwise>
						    </xsl:choose>
				        </xsl:when>
				        <xsl:otherwise>0pt</xsl:otherwise>
		        	</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
