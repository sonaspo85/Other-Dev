<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	<xsl:output method="xml" encoding="UTF-8" indent="no" />
	<xsl:strip-space elements="*"/>

	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

	<xsl:template match="*[name()='p'][*[matches(@class, 'Child$')]]">
		<xsl:variable name="name" select="name()" />
		
		<xsl:for-each-group select="node()" group-adjacent="boolean(self::*[matches(@class, 'Child$')])">
			<xsl:choose>
				<xsl:when test="current-group()[1][matches(@class, 'Child$')]">
					<xsl:apply-templates select="current-group()" />
                </xsl:when>
				
				<xsl:otherwise>
					<xsl:element name="{$name}">
						<xsl:apply-templates select="parent::*/@*" />
						<xsl:apply-templates select="current-group()" />
					</xsl:element>
                </xsl:otherwise>
			</xsl:choose>

		</xsl:for-each-group>
    </xsl:template>

	<!--<xsl:template match="li">
		<xsl:choose>
			<xsl:when test="following-sibling::node()[1][matches(@class, 'Child$')]">
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
					<iiii/>
					<xsl:copy-of select="following-sibling::node()[1]/node()" />
                </xsl:copy>
            </xsl:when>
			<xsl:when test="matches(@class, 'Child$') and preceding-sibling::node()">
        	</xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>-->
	
</xsl:stylesheet>