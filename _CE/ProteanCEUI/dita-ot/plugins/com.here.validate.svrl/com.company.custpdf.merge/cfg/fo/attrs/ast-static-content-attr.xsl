<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

	<xsl:attribute-set name="odd__footer">
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="end-indent">0pt</xsl:attribute>
		<xsl:attribute name="space-after">10pt</xsl:attribute>
		<xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
		<xsl:attribute name="padding-top">15mm</xsl:attribute>
		<xsl:attribute name="padding-bottom">15mm</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="even__footer">
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="start-indent">0pt</xsl:attribute>
		<xsl:attribute name="space-after">10pt</xsl:attribute>
		<xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
		<xsl:attribute name="padding-top">15mm</xsl:attribute>
		<xsl:attribute name="padding-bottom">15mm</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="pagenum">
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-family">SamsungOne 600</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="color">cmyk(0%,0%,0%,75%)</xsl:attribute>
	</xsl:attribute-set>

	<!--from: remove this after study -->
    <xsl:attribute-set name="__chapter__frontmatter__name__container">
        <xsl:attribute name="font-size">16pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="border-before-style">none</xsl:attribute>
        <xsl:attribute name="border-after-style">none</xsl:attribute>
        <xsl:attribute name="border-before-width">0pt</xsl:attribute>
        <xsl:attribute name="border-after-width">0pt</xsl:attribute>
        <xsl:attribute name="padding-top">0pt</xsl:attribute>
        <xsl:attribute name="color">black</xsl:attribute>
        <xsl:attribute name="font-family">Book Antiqua, Times New Roman, Times</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__chapter__frontmatter__number__container">
        <xsl:attribute name="font-size">16pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>
	<!--to: remove this after study -->

</xsl:stylesheet>