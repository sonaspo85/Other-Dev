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
	
	<xsl:template match="*[matches(@class, 'Heading1_Hidden')]">
		
	</xsl:template>
	
	<xsl:template match="chapter">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:sequence select="son:group(*, 2)" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:function name="son:group">
		<xsl:param name="elements" />
		<xsl:param name="level" />
		
		<xsl:variable name="str0">
			<xsl:for-each-group select="$elements" group-starting-with="h2">
				<xsl:choose>
					<xsl:when test="current-group()[1][name()='h2']">
						<xsl:variable name="h2" select="replace(current-group()[1][name()='h2'], '/', '_')" />
						
						<topic>
							<xsl:if test="preceding-sibling::node()[1][matches(@class, 'Heading1_Hidden')]">
								<xsl:attribute name="Heading1_Hidden" select="preceding-sibling::node()[1][matches(@class, 'Heading1_Hidden')]" />
							</xsl:if>
							
							<xsl:attribute name="id" select="current-group()[1][name()='h2']/@id" />
							<xsl:attribute name="filename" select="$h2" />
							<xsl:apply-templates select="current-group()" />
						</topic>
					</xsl:when>
					
					<xsl:otherwise>
						<xsl:for-each-group select="current-group()" group-adjacent="boolean(self::CHAPTER_TITLE)">
							<xsl:choose>
								<xsl:when test="current-grouping-key()">
									<xsl:apply-templates select="current-group()" />
								</xsl:when>
								<xsl:otherwise>
									<insert_template>
										<xsl:apply-templates select="current-group()" />
									</insert_template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each-group>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each-group>
		</xsl:variable>
		
		<xsl:for-each select="$str0/node()">
			<xsl:choose>
				<xsl:when test="preceding-sibling::*[1][name()='insert_template']">
					<xsl:copy>
						<xsl:apply-templates select="@*" />
						<xsl:copy-of select="preceding-sibling::*[1]/node()" />
						<xsl:apply-templates select="node()" />
					</xsl:copy>
				</xsl:when>
				<xsl:when test="self::insert_template">
				</xsl:when>
				
				<xsl:otherwise>
					<xsl:copy>
						<xsl:apply-templates select="@*, node()" />
					</xsl:copy>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:function>
	
</xsl:stylesheet>