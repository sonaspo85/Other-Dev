<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	<xsl:character-map name="tag">
		<xsl:output-character character='⁍' string="&amp;lt;"/>
		<xsl:output-character character='⁌' string="&amp;gt;"/>
	</xsl:character-map>
	
	<xsl:output method="xml" encoding="UTF-8" indent="no" use-character-maps="tag" />
	<xsl:strip-space elements="*"/>

	<xsl:key name="target" match="*[@id]" use="@id"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

	<xsl:template match="a">
		<xsl:choose>
			<xsl:when test="@href">
				<xsl:variable name="target_href" select="key('target', @href)[1]" />
				<xsl:variable name="filename" select="$target_href/ancestor::topic[@filename][1]/@filename" />
				<xsl:variable name="fid" select="$target_href/ancestor::topic[@filename][1]/@id" />
				<xsl:variable name="html" select="concat($fid, '.html')" />
				<xsl:variable name="pre_text" select="normalize-space(preceding-sibling::node()[1][name()!='a'])" />

				<xsl:copy>
					<xsl:attribute name="href">
						<xsl:value-of select="concat($html, '#', $target_href/parent::*/@id)" />
					</xsl:attribute>
					<xsl:copy-of select="$pre_text" />
				</xsl:copy>
            </xsl:when>

			<xsl:when test="@id">
        	</xsl:when>
			
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@* | node()" />
				</xsl:copy>
			</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

	<xsl:template match="p">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:for-each select="node()">
				<xsl:choose>
					<xsl:when test="parent::*[starts-with(@class, 'Chapter_TOC')] and self::node()[preceding-sibling::span] and following-sibling::a">
					</xsl:when>

					<xsl:when test="parent::*[matches(@class, '_Child$')][parent::*[starts-with(@class, 'Chapter_TOC')]]">
						<xsl:choose>
							<xsl:when test="self::node() and following-sibling::*[1][name()='a']">
                            </xsl:when>
							
							<xsl:when test="self::a and preceding-sibling::node()">
								<xsl:apply-templates select="." />
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>

					<xsl:otherwise>
						<xsl:apply-templates select="." />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="text()[parent::*[not(matches(@class, 'C_URL'))]]" priority="10">
		<xsl:analyze-string select="." regex="(^http://.+com$)">
			<xsl:matching-substring>
				<a>
					<xsl:attribute name="href" select="." />
					<xsl:value-of select="regex-group(1)" />
				</a>
			</xsl:matching-substring>
			<xsl:non-matching-substring>
				<xsl:analyze-string select="." regex="(https?://.+com)">
					<xsl:matching-substring>
						<a>
							<xsl:attribute name="href" select="." />
							<xsl:value-of select="regex-group(1)" />
						</a>
					</xsl:matching-substring>
					<xsl:non-matching-substring>
						<xsl:value-of select="." />
					</xsl:non-matching-substring>
				</xsl:analyze-string>
			</xsl:non-matching-substring>
		</xsl:analyze-string>
	</xsl:template>

	<xsl:template match="span">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:choose>
				<xsl:when test="matches(@class, 'C_URL')">
					<a>
						<xsl:attribute name="href">
							<xsl:analyze-string select="." regex="(&#8269;)(https?:.+\.PDF)(&#8268;)">
								<xsl:matching-substring>
									<xsl:value-of select="regex-group(2)" />
								</xsl:matching-substring>
								<xsl:non-matching-substring>
									<xsl:analyze-string select="." regex="^(\()(http.+\.com)(\))$">
										<xsl:matching-substring>
											<xsl:value-of select="regex-group(2)" />
										</xsl:matching-substring>
										<xsl:non-matching-substring>
											<xsl:analyze-string select="." regex="^(www\.)(.+au)$">
												<xsl:matching-substring>
													<xsl:text>https://</xsl:text>
													<xsl:value-of select="regex-group(1)" />
													<xsl:value-of select="regex-group(2)" />
												</xsl:matching-substring>
												<xsl:non-matching-substring>
													<xsl:analyze-string select="." regex="^(www\.)(.+)$">
														<xsl:matching-substring>
															<xsl:text>https://</xsl:text>
															<xsl:value-of select="regex-group(1)" />
															<xsl:value-of select="regex-group(2)" />
														</xsl:matching-substring>
														<xsl:non-matching-substring>
															<xsl:value-of select="." />
														</xsl:non-matching-substring>
													</xsl:analyze-string>
												</xsl:non-matching-substring>
											</xsl:analyze-string>
										</xsl:non-matching-substring>
									</xsl:analyze-string>
								</xsl:non-matching-substring>
							</xsl:analyze-string>
						</xsl:attribute>
						<xsl:apply-templates select="node()" />
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="node()" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xsl:function name="son:filename">
		<xsl:param name="arg1" />
		<xsl:value-of select="replace(replace(replace($arg1, '&#xA0;', '_'), '&amp;', ''), '__', '_')" />
	</xsl:function>
	
</xsl:stylesheet>