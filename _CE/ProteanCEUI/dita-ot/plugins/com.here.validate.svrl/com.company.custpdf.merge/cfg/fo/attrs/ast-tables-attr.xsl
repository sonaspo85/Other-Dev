<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

	<xsl:attribute-set name="common.table.body.entry">
		<xsl:attribute name="space-before">3pt</xsl:attribute>
		<xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
		<xsl:attribute name="space-after">1pt</xsl:attribute>
		<xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
		<xsl:attribute name="start-indent">3pt</xsl:attribute>
		<xsl:attribute name="end-indent">3pt</xsl:attribute>
		<xsl:attribute name="text-align">
		    <xsl:choose>
		    	<xsl:when test="ancestor::*[contains(@class, ' topic/table ')]/@outputclass = 'cell:center'">center</xsl:when>
		    	<xsl:otherwise>inherit</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="ast.table.cell">
		<xsl:attribute name="padding-before">0pt</xsl:attribute>
		<xsl:attribute name="padding-after">0pt</xsl:attribute>
		<xsl:attribute name="padding-start">0pt</xsl:attribute>
		<xsl:attribute name="padding-end">0pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="tbody.row.entry">
		<xsl:attribute name="display-align">center</xsl:attribute>
		<xsl:attribute name="padding-before">0pt</xsl:attribute>
		<xsl:attribute name="padding-after">0pt</xsl:attribute>
		<xsl:attribute name="padding-start">5pt</xsl:attribute>
		<xsl:attribute name="padding-end">5pt</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="line-height">160%</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="ast.thead.row">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="keep-together.within-page">always</xsl:attribute>
		<xsl:attribute name="background-color">cmyk(0%,0%,0%,30%)</xsl:attribute>
		<xsl:attribute name="border-style">solid</xsl:attribute>
		<xsl:attribute name="border-width">1pt</xsl:attribute>
		<xsl:attribute name="border-color">cmyk(0%,0%,0%,20%)</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="ast.thead.padding">
		<xsl:attribute name="padding-before">2pt</xsl:attribute>
		<xsl:attribute name="padding-after">2pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="ast.tbody.row">
		<xsl:attribute name="display-align">center</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="ast.tgroup.thead">
		<xsl:attribute name="line-height">100%</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="common.border__top">
		<xsl:attribute name="border-before-style">solid</xsl:attribute>
		<xsl:attribute name="border-before-width">0.5pt</xsl:attribute>
		<xsl:attribute name="border-before-color">cmyk(0%,0%,0%,20%)</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="common.border__bottom">
		<xsl:attribute name="border-after-style">solid</xsl:attribute>
		<xsl:attribute name="border-after-width">0.5pt</xsl:attribute>
		<xsl:attribute name="border-after-color">cmyk(0%,0%,0%,20%)</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="common.border__right">
		<xsl:attribute name="border-end-style">solid</xsl:attribute>
		<xsl:attribute name="border-end-width">0.5pt</xsl:attribute>
		<xsl:attribute name="border-end-color">cmyk(0%,0%,0%,20%)</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="common.border__left">
		<xsl:attribute name="border-start-style">solid</xsl:attribute>
		<xsl:attribute name="border-start-width">0.5pt</xsl:attribute>
		<xsl:attribute name="border-start-color">cmyk(0%,0%,0%,20%)</xsl:attribute>
	</xsl:attribute-set>

</xsl:stylesheet>