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
	<xsl:variable name="reviewid" select="$review//body/*[name()='h1' or name()='h2' or name()='h0']/@id" />
	
	<xsl:template match="links">
		<links>
			<xsl:apply-templates />
		</links>
	</xsl:template>

	<xsl:template match="link">
		<xsl:variable name="current" select="." />
		<xsl:variable name="scid" select="@scid" />
		<xsl:call-template name="find-same-id">
			<xsl:with-param name="current" select="$current" />
			<xsl:with-param name="scid" select="$scid" />
			<xsl:with-param name="reviewid" select="$reviewid" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="find-same-id">
		<xsl:param name="current" />
		<xsl:param name="scid" />
		<xsl:param name="reviewid" />
		<xsl:param name="reviewid2" />
		
		<xsl:choose>
			<xsl:when test="functx:is-value-in-sequence($scid, $reviewid)">
				<same>
					<xsl:for-each select="$current">
						<xsl:sequence select="." />
                    </xsl:for-each>
				</same>
			</xsl:when>
			<xsl:otherwise>
				<diff>
					<xsl:for-each select="$current">
						<xsl:for-each select="$current">
							<xsl:sequence select="." />
						</xsl:for-each>
					</xsl:for-each>
				</diff>
			</xsl:otherwise>
		</xsl:choose>
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
