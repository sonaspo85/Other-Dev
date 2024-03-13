<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

    <xsl:import href="00.xsl" />
    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="root"/>

    <xsl:param name="language" />

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="root">
        <xsl:text>&#xa;</xsl:text>
        <xsl:copy>
            <xsl:for-each select="node()">
                <xsl:sort select="@ID" order="ascending" />
                    <xsl:apply-templates select="." />
            </xsl:for-each>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="listitem">
        <xsl:for-each select="item[@LV_name = $compare]">
            <xsl:variable name="LV_name" select="@LV_name" />
            <xsl:text>&#xa;&#x9;</xsl:text>
            <paragraph>
                <xsl:attribute name="id">
                    <xsl:value-of select="parent::*/@ID" />
                </xsl:attribute>
                <xsl:apply-templates select="node()" />
            </paragraph>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="item">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>