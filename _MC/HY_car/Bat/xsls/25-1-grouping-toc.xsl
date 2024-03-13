<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	
	<xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="yes" />
	<xsl:strip-space elements="*"/>

	<xsl:variable name="open">&lt;heading1_Hidden&gt;</xsl:variable>
	<xsl:variable name="close">&lt;/heading1_Hidden&gt;</xsl:variable>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

	<xsl:template match="chapter[*[@Heading1_Hidden]]">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:for-each-group select="node()" group-starting-with="*[@Heading1_Hidden]">
				<xsl:choose>
					<xsl:when test="current-group()[1][@Heading1_Hidden]">
						<xsl:value-of select="$open" disable-output-escaping="yes" />

						<xsl:call-template name="grouping">
							<xsl:with-param name="group" select="current-group()" />
                        </xsl:call-template>
                	</xsl:when>

					<xsl:otherwise>
						<xsl:apply-templates select="current-group()" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each-group>
        </xsl:copy>
    </xsl:template>

	<xsl:template name="grouping">
		<xsl:param name="group" />

		<xsl:choose>
			<xsl:when test="$group[1][not(*[matches(@class, 'Heading1\-2')])]">
				<xsl:apply-templates select="$group[1]" />

				<xsl:call-template name="grouping">
					<xsl:with-param name="group" select="$group[position() &gt; 1]" />
                </xsl:call-template>
            </xsl:when>

			<xsl:otherwise>
				<xsl:value-of select="$close" disable-output-escaping="yes" />
				<xsl:apply-templates select="$group" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
	
</xsl:stylesheet>
