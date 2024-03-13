<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <xsl:attribute-set name="info">
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
		<xsl:attribute name="start-indent">
			<xsl:choose>
				<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')]">body-start()</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')]">body-start()</xsl:when>
				<xsl:when test="*[contains(@class, ' topic/ul ')][@outputclass='bullet:hyphen']">body-start()</xsl:when>
				<xsl:otherwise>0pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="cmd">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and substring-before($locale, '_') = 'ko'">SamsungOneKorean 400</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/step ')] and substring-before($locale, '_') != 'ko'">SamsungOne 400</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')] and substring-before($locale, '_') = 'ko'">SamsungOneKorean 400</xsl:when>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')] and substring-before($locale, '_') != 'ko'">SamsungOne 400</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'ko' and ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle'">SamsungOneKorean 600</xsl:when>
				<xsl:when test="substring-before($locale, '_') = 'ko' and ancestor::*[contains(@class, ' task/steps ')]/@outputclass != 'number:circle'">SamsungOneKorean 400</xsl:when>
				<xsl:when test="substring-before($locale, '_') != 'ko' and ancestor::*[contains(@class, ' task/steps ')]/@outputclass = 'number:circle'">SamsungOne 600</xsl:when>
				<xsl:otherwise>SamsungOne 400</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:choose>
				<xsl:when test="parent::*[contains(@class, ' task/substep ')]">10pt</xsl:when>
				<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">12pt</xsl:when>
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
    	<xsl:attribute name="font-size">13pt</xsl:attribute>
    	<xsl:attribute name="font-stretch">
    		<xsl:choose>
    			<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">normal</xsl:when>
    			<xsl:otherwise>semi-condensed</xsl:otherwise>
    		</xsl:choose>
    	</xsl:attribute>
        <xsl:attribute name="color">cmyk(0%,0%,0%,80%)</xsl:attribute>
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
        <xsl:attribute name="space-after">1mm</xsl:attribute>
        <xsl:attribute name="space-before">2mm</xsl:attribute>
		<xsl:attribute name="start-indent">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">0mm</xsl:when>
				<xsl:otherwise>0mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="substeps.substep" use-attribute-sets="ol.li">
        <xsl:attribute name="space-after">1mm</xsl:attribute>
        <xsl:attribute name="space-before">2mm</xsl:attribute>
		<xsl:attribute name="start-indent">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')]">body-start()</xsl:when>
				<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">0mm</xsl:when>
				<xsl:otherwise>body-start()</xsl:otherwise>
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

		<!--Added by KSY -->
		<xsl:attribute name="padding-top">
			<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">0pt</xsl:when>
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
        <xsl:attribute name="font-size">13pt</xsl:attribute>
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
				<xsl:otherwise>cmyk(0%,0%,0%,80%)</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>