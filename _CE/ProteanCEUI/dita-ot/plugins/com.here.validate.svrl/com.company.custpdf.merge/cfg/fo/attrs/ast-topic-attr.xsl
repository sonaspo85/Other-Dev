<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    version="2.0">

	<!-- note indent -->
    <xsl:attribute-set name="note__table" use-attribute-sets="common.block">
        <xsl:attribute name="margin-left">2mm</xsl:attribute>
    </xsl:attribute-set>

	<!-- chapter title -->
    <xsl:attribute-set name="topic.title" use-attribute-sets="common.title common.border__bottom">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="substring-before($locale, '_') = 'ko'">SamsungOneKorean 500</xsl:when>
				<xsl:otherwise>SamsungOne 500</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="font-size">28pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="line-height">100%</xsl:attribute>
        <xsl:attribute name="padding-top">0mm</xsl:attribute>
        <xsl:attribute name="margin-left">4mm</xsl:attribute>
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
						<xsl:when test="substring-before($locale, '_') = 'ko'">SamsungOneKorean 700</xsl:when>
						<xsl:otherwise>SamsungOne 700</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="substring-before($locale, '_') = 'ko'">SamsungOneKorean 600</xsl:when>
						<xsl:otherwise>SamsungOne 600</xsl:otherwise>
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
        <xsl:attribute name="line-height">100%</xsl:attribute>
        <xsl:attribute name="padding-top">0mm</xsl:attribute>
    	<xsl:attribute name="margin-left">0mm</xsl:attribute>
        <xsl:attribute name="space-before">11mm</xsl:attribute>
        <xsl:attribute name="space-after">3.5mm</xsl:attribute>
	    <xsl:attribute name="border-after-style">none</xsl:attribute>
	    <xsl:attribute name="border-after-width">0pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
		<xsl:attribute name="page-break-before">auto</xsl:attribute>
		<xsl:attribute name="keep-with-previous">auto</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.title" use-attribute-sets="common.title">
        <xsl:attribute name="space-before">6mm</xsl:attribute>
        <xsl:attribute name="space-after">1mm</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:choose>
				<xsl:when test="ancestor-or-self::*/title[contains(@outputclass, 'Subchapter')]">18pt</xsl:when>
				<xsl:otherwise>15pt</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
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
        <xsl:attribute name="space-after">6mm</xsl:attribute>
        <xsl:attribute name="space-before.precedence">3</xsl:attribute>
        <xsl:attribute name="space-after.precedence">3</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ast-shortdesc-highlight">
        <xsl:attribute name="padding-before">0.25em</xsl:attribute>
        <xsl:attribute name="padding-after">0.15em</xsl:attribute>
    	<xsl:attribute name="background-color">rgb(201,223,244)</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ast-warning" use-attribute-sets="common.block">
		<xsl:attribute name="font-family">
			<xsl:choose>
				<xsl:when test="substring-before($locale, '_') = 'ko'">SamsungOneKorean 600</xsl:when>
				<xsl:otherwise>SamsungOne 600</xsl:otherwise>
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
				<xsl:when test="substring-before($locale, '_') = 'ko'">SamsungOneKorean 400</xsl:when>
				<xsl:otherwise>SamsungOne 600</xsl:otherwise>
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
				<xsl:when test="@align = 'left'">0mm</xsl:when>
				<xsl:otherwise>15mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="margin-right">15mm</xsl:attribute>
        <xsl:attribute name="space-before">6mm</xsl:attribute>
        <xsl:attribute name="space-after">6mm</xsl:attribute>
        <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
		<xsl:attribute name="content-height">
			<xsl:choose>
				<xsl:when test="@align = 'left'">110%</xsl:when>
				<xsl:otherwise>90%</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="width">
			<xsl:choose>
				<xsl:when test="@align = 'left'">110%</xsl:when>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:otherwise>90%</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="scaling">uniform</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="image__inline">
        <xsl:attribute name="content-width">auto</xsl:attribute>
        <xsl:attribute name="content-height">auto</xsl:attribute>
        <xsl:attribute name="width">auto</xsl:attribute>
        <xsl:attribute name="scaling">uniform</xsl:attribute>
    </xsl:attribute-set>

	<!-- FOP only -->
    <xsl:attribute-set name="image__trynow">
        <xsl:attribute name="baseline-shift">-2pt</xsl:attribute>
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
