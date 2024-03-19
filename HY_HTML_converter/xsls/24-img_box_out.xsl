<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	<xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[matches(name(), '(ol|ul)')]">
		<xsl:variable name="name" select="name()" />
		<xsl:variable name="class" select="@class" />
		
		<xsl:for-each-group select="node()" group-adjacent="boolean(self::*[matches(@class, 'image_box')])">
			<xsl:choose>
				<xsl:when test="current-group()[1][matches(@class, 'image_box')]">
					<xsl:apply-templates select="current-group()" />
                </xsl:when>
				<xsl:otherwise>
					<xsl:element name="{$name}">
						<xsl:attribute name="class"  select="$class" />
						<xsl:apply-templates select="current-group()" />
					</xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each-group>
    </xsl:template>
	
</xsl:stylesheet>
