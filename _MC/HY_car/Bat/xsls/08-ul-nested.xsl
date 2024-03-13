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

	<xsl:template match="ul[not(ancestor::*[matches(name(), '(ol|ul)')])]">
		<xsl:variable name="name" select="name()" />
		<xsl:variable name="class" select="@class" />
		<xsl:variable name="flw_Hyp" select="following-sibling::*[1][matches(@class, 'UnorderList1_Hyp(\d)?')]" />

		<xsl:choose>
			<xsl:when test="matches(@class, 'UnorderList1_Hyp(\d)?') and preceding-sibling::*[1][name()='ul']">
			</xsl:when>

			<xsl:when test="parent::Cell[not(following-sibling::node())]/ancestor::Table/following-sibling::node()[1][name()=$name][@class=$class]">
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
					<xsl:copy-of select="ancestor::Table/following-sibling::node()[1]/node()" />
				</xsl:copy>
            </xsl:when>
			<xsl:when test="preceding-sibling::node()[1][name()='Table']/Cell[not(following-sibling::node())]/ul[@class=$class]">
            </xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*" />

					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="not(following-sibling::node())">
								<xsl:copy>
									<xsl:apply-templates select="@*, node()" />

									<xsl:if test="parent::*/$flw_Hyp">
										<xsl:copy-of select="$flw_Hyp" />
									</xsl:if>
								</xsl:copy>
							</xsl:when>

							<xsl:otherwise>
								<xsl:copy>
									<xsl:apply-templates select="@*, node()" />
								</xsl:copy>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>

					<xsl:if test="not(matches(@class, 'UnorderList1_Hyp(\d)?')) and 
								  following-sibling::*[1][name()='Table']
                                  [not(matches(@class, 'Table_Maintenance'))]
                                  [not(descendant::*[matches(@class, 'Heading')])]
                                  [following-sibling::*[1][name() = $name]]">
                        
                        <xsl:copy-of select="following-sibling::*[1][name()='Table']" />
					</xsl:if>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="Table">
		<xsl:choose>
			<xsl:when test="not(matches(@class, 'Table_Maintenance')) and 
                            not(descendant::*[matches(@class, 'Heading')]) and 
                            not(preceding-sibling::*[1][matches(@class, 'UnorderList1_Hyp(\d)?')]) and 
					  		preceding-sibling::*[1][name()='ul'] and 
					  		following-sibling::*[1][name()='ul']">
			</xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>