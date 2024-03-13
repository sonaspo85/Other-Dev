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

	<xsl:template match="*[name()='p']">
		<xsl:variable name="name" select="name()" />

		<xsl:choose>
			<xsl:when test="parent::chapter and following-sibling::node()[1][matches(@class, '_Hyp\d$')]">
            </xsl:when>
			
			<xsl:when test="*[matches(@class, 'Child$')]">
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
            </xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<xsl:template match="ul[matches(@class, '_Hyp\d$')][parent::chapter]">
		
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:if test="preceding-sibling::node()[1][matches(@class, '\-Child$')]">
				<li>
					<xsl:apply-templates select="@*" />
					<xsl:copy-of select="preceding-sibling::node()[1][matches(@class, '\-Child$')]" />
				</li>
			</xsl:if>
			
			<xsl:apply-templates select="node()" />
    	</xsl:copy>
    </xsl:template>

	
</xsl:stylesheet>