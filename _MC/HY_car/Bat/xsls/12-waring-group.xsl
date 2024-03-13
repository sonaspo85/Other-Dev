<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	<xsl:variable name="open">&lt;warning-group&gt;</xsl:variable>
	<xsl:variable name="close">&lt;/warning-group&gt;</xsl:variable>

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
			<xsl:for-each-group select="node()" group-starting-with="*[matches(@class, '(Warning|Caution|NOTE|INFO)')]">

				<xsl:choose>
					<xsl:when test="current-group()[matches(@class, '(Warning|Caution|NOTE|INFO)')][1]">
						<xsl:value-of select="$open" disable-output-escaping="yes" />
						<xsl:apply-templates select="current-group()[1]" />

						<xsl:call-template name="grouping">
							<xsl:with-param name="group" select="current-group()[position() &gt; 1]" />
							<xsl:with-param name="preceding-class" select="current-group()[1]/@class" />
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
		<xsl:param name="preceding-class" />

		<xsl:if test="$preceding-class = 'Warning'">
			<xsl:choose>
				<xsl:when test="$group[1][matches(@class, '^Description$')][preceding-sibling::node()[1][not(matches(name(), 'ul'))]][*[1][matches(@class, '^C_Important$')]] or 
						  		$group[1][matches(name(), '(ul|ol)')][not(matches(@class, 'Heading'))][*[matches(@class, '(1_1|UnorderList1)')]]">
					<xsl:apply-templates select="$group[1]" />

					<xsl:call-template name="grouping">
						<xsl:with-param name="group" select="$group[position() &gt; 1]" />
						<xsl:with-param name="preceding-class" select="$preceding-class" />
					</xsl:call-template>
				</xsl:when>

				<xsl:otherwise>
					<xsl:value-of select="$close" disable-output-escaping="yes" />
					<xsl:apply-templates select="$group" />
				</xsl:otherwise>
			</xsl:choose>
        </xsl:if>

		<xsl:if test="$preceding-class = 'Caution'">
			<xsl:choose>
				<xsl:when test="$group[1][matches(@class, '^Description$')][*[1][matches(@class, '^C_Important$')]] or 
						  		$group[1][matches(name(), 'ul')][not(matches(@class, 'Heading'))] or 
						  		$group[1][matches(name(), 'Table')][following-sibling::*[1][not(*[matches(@class, 'Heading')])]]">
					<xsl:apply-templates select="$group[1]" />

					<xsl:call-template name="grouping">
						<xsl:with-param name="group" select="$group[position() &gt; 1]" />
						<xsl:with-param name="preceding-class" select="$preceding-class" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when test="$group[1][matches(name(), 'ol')][matches(@class, 'UnorderList\d_Number')][following-sibling::node()[1][name()='ul']]">
					<xsl:apply-templates select="$group[1]" />
					
					<xsl:call-template name="grouping">
						<xsl:with-param name="group" select="$group[position() &gt; 1]" />
						<xsl:with-param name="preceding-class" select="$preceding-class" />
					</xsl:call-template>
				</xsl:when>

				<xsl:otherwise>
					<xsl:value-of select="$close" disable-output-escaping="yes" />
					<xsl:apply-templates select="$group" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="$preceding-class = 'NOTE'">
			<xsl:choose>
				<xsl:when test="$group[1][matches(@class, '^Description$')][*[1][matches(@class, '^C_Important$')]] or 
						  		$group[1][matches(name(), '(ul|ol)')][not(matches(@class, 'Heading'))][*[matches(@class, '(1_1|UnorderList1)')]] or
						  		$group[1][name()='Table'][following-sibling::node()[1]/*[matches(@class, 'C_Important')]] or 
						  		$group[1][name()='Table'][following-sibling::node()[1][matches(name(), 'ul')][descendant::*[matches(@class, 'C_Important')]]] or 
						  		$group[1][name()='Table'][following-sibling::node()[1][matches(@class, 'Caption')]] or 
						  		$group[1][matches(@class, 'Caption')][preceding-sibling::node()[1][name()='Table']]">
					<xsl:apply-templates select="$group[1]" />

					<xsl:call-template name="grouping">
						<xsl:with-param name="group" select="$group[position() &gt; 1]" />
						<xsl:with-param name="preceding-class" select="$preceding-class" />
					</xsl:call-template>
				</xsl:when>

				<xsl:otherwise>
					<xsl:value-of select="$close" disable-output-escaping="yes" />
					<xsl:apply-templates select="$group" />
				</xsl:otherwise>
			</xsl:choose>
        </xsl:if>

		<xsl:if test="$preceding-class = 'INFO'">
			<xsl:choose>
				<xsl:when test="$group[1][matches(@class, '^Description$')][*[1][matches(@class, '(^C_info_Times$|C_Important)')]] or 
						  		$group[1][matches(@class, '^Description$')][preceding-sibling::*[1]/*[matches(@class, 'C_Important')]] or 
						  		$group[1][matches(name(), '(ul|ol)')][descendant::*[matches(@class, 'C_info_Times')]] or 
						  		$group[1][matches(name(), 'ol')][matches(@class, '1_1')][preceding-sibling::node()[1][matches(name(), '(ul|ol)')]][li[1]/*[1]/following-sibling::*[1][not(matches(@class, 'Child'))]] or 
						  		$group[1][name()='Table'][following-sibling::node()[1]/*[matches(@class, 'C_info_Times')]] or 
						  		$group[1][name()='Table'][descendant::*[matches(@class, 'C_info_Times')]] or 
						  		$group[1][matches(name(), 'ul')][following-sibling::node()[1][matches(@class, 'Heading')]]">
					<xsl:apply-templates select="$group[1]" />

					<xsl:call-template name="grouping">
						<xsl:with-param name="group" select="$group[position() &gt; 1]" />
						<xsl:with-param name="preceding-class" select="$preceding-class" />
					</xsl:call-template>
				</xsl:when>

				<xsl:otherwise>
					<xsl:value-of select="$close" disable-output-escaping="yes" />
					<xsl:apply-templates select="$group" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

	</xsl:template>
	
</xsl:stylesheet>