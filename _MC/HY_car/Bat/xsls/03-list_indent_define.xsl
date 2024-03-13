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
		<xsl:variable name="str0">
			<xsl:copy>
				<xsl:apply-templates select="@*" />
				<xsl:for-each-group select="node()" group-adjacent="boolean(self::p[matches(@class, '[_-]Child')])">
					<xsl:choose>
						<xsl:when test="current-group()[matches(@class, '[_-]Child')][1]">
							<div class="group_indent">
								<xsl:apply-templates select="current-group()" />
	                        </div>
	                    </xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="current-group()" />
						</xsl:otherwise>
	                </xsl:choose>
	            </xsl:for-each-group>
			</xsl:copy>
        </xsl:variable>
		
		<xsl:variable name="str1">
			<xsl:for-each select="$str0/node()">
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="self::*[name()!='Table'][not(matches(@class, '(Heading|Caption)'))][following-sibling::node()[1][matches(@class, 'group_indent')]]">
								<xsl:copy>
									<xsl:apply-templates select="@*, node()" />
									<xsl:copy-of select="following-sibling::node()[1][matches(@class, 'group_indent')]/node()" />
								</xsl:copy>
							</xsl:when>
							<xsl:when test="self::*[matches(@class, 'group_indent')] and preceding-sibling::node()[1][name()!='Table'][not(matches(@class, '(Heading|Caption)'))]">
							</xsl:when>

							<xsl:when test="self::*[matches(@class, 'group_indent')] and preceding-sibling::node()[1][name()='Table']">
								<xsl:choose>
									<xsl:when test="count(node()) = 1">
										<xsl:apply-templates />
									</xsl:when>

									<xsl:otherwise>
										<xsl:copy>
											<xsl:apply-templates select="@*, node()" />
										</xsl:copy>
									</xsl:otherwise>
								</xsl:choose>
                            </xsl:when>

							<xsl:when test="self::*[matches(@class, 'group_indent')] and preceding-sibling::node()[1][matches(@class, 'Heading')]">
								<xsl:choose>
									<xsl:when test="count(node()) = 1">
										<xsl:apply-templates />
                                	</xsl:when>

									<xsl:otherwise>
										<xsl:copy>
											<xsl:apply-templates select="@*, node()" />
										</xsl:copy>
                                    </xsl:otherwise>
                                </xsl:choose>
							</xsl:when>

							<!--<xsl:when test="count(self::group_indent/*[matches(@class, 'Child')]) eq 1">
								<xsl:apply-templates />
							</xsl:when>-->

							<xsl:otherwise>
								<xsl:copy>
									<xsl:apply-templates select="@*, node()" />
                            	</xsl:copy>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:copy>
            </xsl:for-each>
        </xsl:variable>

		<xsl:copy-of select="$str1" />
    </xsl:template>

	<xsl:template match="text()" priority="10">
		<xsl:choose>
			<xsl:when test="not(preceding-sibling::node())">
				<xsl:value-of select="replace(., '^\s+', '')" />
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:value-of select="replace(., '^\s+', '&#x20;')" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:function name="son:last">
		<xsl:param name="arg1" />
		<xsl:param name="arg2" />
		<xsl:copy-of select="tokenize($arg1, $arg2)[last()]" />
	</xsl:function>
	
</xsl:stylesheet>