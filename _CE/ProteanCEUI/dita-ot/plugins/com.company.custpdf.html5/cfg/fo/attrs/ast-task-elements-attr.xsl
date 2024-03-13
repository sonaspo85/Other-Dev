<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

	<xsl:variable name="myBase" select="//root()/*[contains(@class,' map/map ')][1]/@base"/>
    <xsl:attribute-set name="info">
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
		<xsl:attribute name="start-indent">
			<xsl:choose>
				<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')][@outputclass='div-step']">0pt</xsl:when>
				<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')]">body-start()</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')]">body-start()</xsl:when>
				<xsl:when test="ancestor::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">0pt</xsl:when>
				<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]">body-start()</xsl:when>
				<xsl:when test="*[contains(@class, ' topic/ul ')][@outputclass='bullet:hyphen']">body-start()</xsl:when>
				<xsl:otherwise>0pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="cmd">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')] and matches(substring-after($locale, '_'), 'TW|HK')">SamsungSVDMedium_T_CN, SamsungOne 400</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')] and matches(substring-after($locale, '_'), 'CN')">SamsungSVDMedium_S_CN, SamsungOne 400</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')] and matches(substring-after($locale, '_'), 'KR')">SamsungOneKorean 400</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')] and matches(substring-before($locale, '_'), 'ar|fa')">SamsungOneArabic 400</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')] and substring-before($locale, '_') = 'he'">SamsungOneHebrew 400</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')] and substring-before($locale, '_') = 'th'">Tahoma</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')] and substring-before($locale, '_') = 'my'">
					<xsl:choose>
						<xsl:when test="matches($myBase, 'Zawgyi-One')">Zawgyi-One</xsl:when>
						<xsl:otherwise>SamsungOneMyanmar 450</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')] and not(matches(substring-before($locale, '_'), 'ko|ar|fa|he'))">SamsungOne 400, SamsungSVDMedium_S_CN</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and substring-after($locale, '_') = 'TW'">
					<xsl:value-of select="if ( ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle' ) then 'SamsungSVDMedium_T_CN' else 'SamsungSVDMedium_T_CN'"/>
				</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and substring-after($locale, '_') = 'HK'">
					<xsl:value-of select="if ( ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle' ) then 'SamsungSVDMedium_T_CN' else 'SamsungSVDMedium_T_CN'"/>
				</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and substring-after($locale, '_') = 'CN'">
					<xsl:value-of select="if ( ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle' ) then 'SamsungSVDMedium_S_CN, SamsungOne 600' else 'SamsungSVDMedium_S_CN, SamsungOne 400'"/>
				</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and substring-after($locale, '_') = 'KR'">
					<xsl:value-of select="if ( ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle' ) then 'SamsungOneKorean 600' else 'SamsungOneKorean 400'"/>
				</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and matches(substring-before($locale, '_'), 'th')">
					<xsl:value-of select="if ( ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle' ) then 'Tahoma-Bold' else 'Tahoma'"/>
				</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and matches(substring-before($locale, '_'), 'my')">
					<xsl:choose>
						<xsl:when test="matches($myBase, 'Zawgyi-One')">
							<xsl:value-of select="if ( ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle' ) then 'Zawgyi-One' else 'Zawgyi-One'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="if ( ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle' ) then 'SamsungOneMyanmar 600' else 'SamsungOneMyanmar 450'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and matches(substring-before($locale, '_'), 'ar|fa')">
					<xsl:value-of select="if ( ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle' ) then 'SamsungOneArabic 600' else 'SamsungOneArabic 400'"/>
				</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and substring-before($locale, '_') = 'he'">
					<xsl:value-of select="if ( ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle' ) then 'SamsungOneHebrew 600' else 'SamsungOneHebrew 400'"/>
				</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and not(matches(substring-before($locale, '_'), 'ko|ar|fa|he'))">
					<xsl:value-of select="if ( ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle' ) then 'SamsungOne 600, SamsungSVDMedium_S_CN' else 'SamsungOne 400, SamsungSVDMedium_S_CN'"/>
				</xsl:when>
				<xsl:otherwise>SamsungOne 400, SamsungSVDMedium_S_CN</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:choose>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')]">10pt</xsl:when>
				<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">10pt</xsl:when>
				<xsl:otherwise>10pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ast.steps.step__content" use-attribute-sets="ol.li__content">
        <xsl:attribute name="margin-left" select="concat('-', 'body-start()')"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="ast.substeps.substep__content" use-attribute-sets="ol.li__content">
        <xsl:attribute name="margin-left" select="concat('-', 'body-start()')"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="steps.step__label__content" use-attribute-sets="ol.li__label__content">
    	<xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="steps.step__label" use-attribute-sets="ol.li__label">
    	<xsl:attribute name="font-family">Arial</xsl:attribute>
    	<xsl:attribute name="font-size">10pt</xsl:attribute>
    	<xsl:attribute name="font-stretch">
    		<xsl:choose>
    			<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">normal</xsl:when>
    			<xsl:otherwise>semi-condensed</xsl:otherwise>
    		</xsl:choose>
    	</xsl:attribute>
        <xsl:attribute name="color">cmyk(0%,0%,0%,100%)</xsl:attribute>
    	<xsl:attribute name="baseline-shift">-1pt</xsl:attribute>
		<xsl:attribute name="padding-top">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@outputclass, 'number:circle')] and contains(class, ' task/cmd ')">0pt</xsl:when>
        		<xsl:when test="contains(class, ' task/cmd ')">
        			<xsl:choose>
		        		<xsl:when test="image[@height &gt;= 17]">4pt</xsl:when>
		        		<xsl:when test="image[@height &gt;= 13]">3pt</xsl:when>
		        		<xsl:when test="image[@height &gt;= 11]">1pt</xsl:when>
		        		<xsl:otherwise>0pt</xsl:otherwise>
		        	</xsl:choose>
        		</xsl:when>
        		<xsl:otherwise>
        			<xsl:choose>
        				<xsl:when test="ancestor::*[contains(@outputclass, 'bullet:hyphen')]">
        					<xsl:choose>
				        		<xsl:when test="*[1]/image[@height &gt;= 17]">4pt</xsl:when>
				        		<xsl:when test="*[1]/image[@height &gt;= 13]">3pt</xsl:when>
				        		<xsl:when test="*[1]/image[@height &gt;= 11]">1pt</xsl:when>
				        		<xsl:otherwise>0pt</xsl:otherwise>
				        	</xsl:choose>
        				</xsl:when>
        				<xsl:otherwise>
        					<xsl:choose>
				        		<xsl:when test="*[1]/image[@height &gt;= 17]">4pt</xsl:when>
				        		<xsl:when test="*[1]/image[@height &gt;= 13]">3pt</xsl:when>
				        		<xsl:when test="*[1]/image[@height &gt;= 11]">1pt</xsl:when>
				        		<xsl:otherwise>0pt</xsl:otherwise>
				        	</xsl:choose>
        				</xsl:otherwise>
        			</xsl:choose>
        		</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="steps.step" use-attribute-sets="ol.li">
        <xsl:attribute name="space-after">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">4mm</xsl:when>
				<xsl:otherwise>1mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="space-before">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">6mm</xsl:when>
				<xsl:otherwise>2mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="start-indent">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">0mm</xsl:when>
				<xsl:otherwise>0mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="substeps.substep" use-attribute-sets="ol.li">
        <xsl:attribute name="space-after">2mm</xsl:attribute>
        <xsl:attribute name="space-before">3mm</xsl:attribute>
		<xsl:attribute name="start-indent">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')]">inherit</xsl:when>
				<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">0mm</xsl:when>
				<xsl:otherwise>inherit</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="margin-left">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')]">-2mm</xsl:when>
				<xsl:otherwise>2mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ast.step.number">
		<xsl:attribute name="margin-left">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">-2mm</xsl:when>
				<xsl:otherwise>-1mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

		<xsl:attribute name="padding-top">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">-1pt</xsl:when>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')] and .//image[@height &gt;= 17]">4pt</xsl:when>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')] and .//image[@height &gt;= 13]">3pt</xsl:when>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')] and .//image[@height &gt;= 11]">1pt</xsl:when>
        		<xsl:when test=".//image[@height &gt;= 17] and not(.//ul[@outputclass='bullet:hyphen'])">4pt</xsl:when>
        		<xsl:when test=".//image[@height &gt;= 13] and not(.//ul[@outputclass='bullet:hyphen'])">3pt</xsl:when>
        		<xsl:when test=".//image[@height &gt;= 11] and not(.//ul[@outputclass='bullet:hyphen'])">1pt</xsl:when>
				<xsl:otherwise>0pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

		<xsl:attribute name="font-family">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">Number_blackfilled</xsl:when>
				<xsl:otherwise>Arial</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">13pt</xsl:when>
				<xsl:otherwise>10pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    	<xsl:attribute name="font-stretch">
    		<xsl:choose>
    			<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">normal</xsl:when>
    			<xsl:otherwise>semi-condensed</xsl:otherwise>
    		</xsl:choose>
    	</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
		<xsl:attribute name="baseline-shift">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">-2pt</xsl:when>
				<xsl:otherwise>0pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="color">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">rgb(0,113,188)</xsl:when>
				<xsl:otherwise>cmyk(0%,0%,0%,100%)</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>