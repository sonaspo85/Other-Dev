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

	<xsl:template match="chapter">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:variable name="str0">
			<xsl:for-each-group select="*" group-adjacent="boolean(self::*[matches(@class, '(OrderList|Description_NumB)')])">
				<xsl:variable name="class" select="*[1]/@*" />
				
				<xsl:choose>
					<xsl:when test="current-group()[1][name()='ol'][matches(@class, 'derList')][following-sibling::*[1][name()='ol']]">
						<ol>
							<xsl:apply-templates select="$class" />
							<xsl:apply-templates select="current-group()/node()" />
						</ol>
					</xsl:when>

					<!--<xsl:when test="current-group()[1][name()='ul'][matches(@class, 'derList')][following-sibling::*[1][name()='ul']]">
						<ul>
							<xsl:apply-templates select="$class" />
							<xsl:apply-templates select="current-group()/node()" />
						</ul>
					</xsl:when>-->

					<xsl:when test="current-group()[1][name()='ol'][matches(@class, 'Description_NumB')][following-sibling::*[1][name()='ol']]">
						<ol>
							<xsl:apply-templates select="$class" />
							<xsl:apply-templates select="current-group()/node()" />
						</ol>
					</xsl:when>

					<xsl:otherwise>
						<xsl:apply-templates select="current-group()" />
					</xsl:otherwise>
				</xsl:choose>
            </xsl:for-each-group>
			</xsl:variable>
			
			<xsl:for-each-group select="$str0/node()" group-adjacent="boolean(self::*[matches(@class, 'UnorderList')][not(matches(@class, '(_mark|Child|Heading|_Hyp)'))])">
				<xsl:variable name="class" select="*[1]/@*" />
				<xsl:choose>
				<xsl:when test="current-group()[1][name()='ul'][matches(@class, 'derList')][following-sibling::*[1][name()='ul']]">
					<ul>
						<xsl:apply-templates select="$class" />
						<xsl:apply-templates select="current-group()/node()" />
					</ul>
				</xsl:when>

				<xsl:otherwise>
					<xsl:apply-templates select="current-group()" />
				</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each-group>
        </xsl:copy>
    </xsl:template>
	
</xsl:stylesheet>