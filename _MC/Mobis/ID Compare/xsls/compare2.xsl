<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/"
    xmlns:son="http://www.son.net/"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="xs ast son functx"
    version="2.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes" />
    <xsl:strip-space elements="*"/>
	
	<xsl:variable name="linksid" select="document(concat(son:getPath(base-uri(.), '/'), '/', 'links_id_float.xml'))" />
	<xsl:variable name="linkid" select="$linksid/links/link/@scid" />
	<xsl:variable name="review" select="document(concat(son:getPath(base-uri(.), '/'), '/', 'review.html'))" />
	<xsl:variable name="reviewid" select="$review//body/h1/@id" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			
			<xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
	</xsl:template>


	<xsl:template match="links">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:for-each-group select="node()" group-by="boolean(self::same)">
				<xsl:sort order="descending"/>
				<xsl:choose>
					<xsl:when test="current-grouping-key()">
						<same>
							<xsl:apply-templates select="current-group()/node()" />
						</same>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="current-group()/link[@scid and @float]">
							<diff>
								<xsl:apply-templates select="current-group()/link[@scid and @float]" />
							</diff>
						</xsl:if>
						<xsl:if test="current-group()/link[@scid and not(@float)]">
							<diff>
								<xsl:apply-templates select="current-group()/link[@scid and not(@float)]" />
							</diff>
						</xsl:if>
						<xsl:if test="current-group()/link[not(@scid) and @float]">
							<float>
								<xsl:apply-templates select="current-group()/link[not(@scid) and @float]" />
							</float>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each-group>
		</xsl:copy>
	</xsl:template>

	

	<xsl:function name="functx:is-value-in-sequence" as="xs:boolean" xmlns:functx="http://www.functx.com">
		<xsl:param name="scid" as="xs:anyAtomicType*" />
		<xsl:param name="reviewid" as="xs:anyAtomicType*" />
		<xsl:sequence select="$scid = $reviewid" />
	</xsl:function>

	<xsl:function name="son:getPath">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], $char)" />
	</xsl:function>

</xsl:stylesheet>
