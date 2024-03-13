<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">


	<xsl:character-map name="tag">
		<xsl:output-character character='&lt;' string="&lt;"/>
		<xsl:output-character character='&gt;' string="&gt;"/>
	</xsl:character-map>

	<xsl:output method="xml" encoding="UTF-8" indent="no" use-character-maps="tag" />
	<xsl:strip-space elements="*"/>


	<xsl:template match="/">
		<xsl:variable name="st">
			<xsl:apply-templates />
        </xsl:variable>

		<xsl:apply-templates select="$st/*" mode="abc"/>
    </xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="@* | node()" mode="abc">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" mode="abc"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="chapter" priority="10">
		<xsl:variable name="name" select="name()" />
		<xsl:variable name="attr" select="@*" />
		
		<xsl:variable name="str0">
			<xsl:copy>
				<xsl:apply-templates select="@*" />
				
				<xsl:for-each-group select="node()" group-adjacent="boolean(self::p[matches(@class, '^UnorderList\d(\-UpSp)?$')])">
					<xsl:choose>
						<xsl:when test="current-group()[matches(@class, '^UnorderList\d(\-UpSp)?$')][1]">
							<ul>
								<xsl:attribute name="class" select="current-group()[1]/@class" />
								<xsl:apply-templates select="current-group()" />
							</ul>
						</xsl:when>

						<xsl:otherwise>
							<xsl:apply-templates select="current-group()" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each-group>
			</xsl:copy>
		</xsl:variable>

		<xsl:variable name="str1">
			<xsl:for-each select="$str0/*">
				<chapter>
					<xsl:for-each-group select="node()" group-adjacent="boolean(self::p[matches(@class, 'UnorderList(\d)_Hyp(\d)?')])">
						<xsl:choose>
							<xsl:when test="current-group()[matches(@class, 'UnorderList(\d)_Hyp(\d)?')][1]">
								<ul>
									<xsl:attribute name="class" select="current-group()[1]/@class" />
									
									<xsl:apply-templates select="current-group()" />
								</ul>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="current-group()" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each-group>
				</chapter>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="str2">
			<xsl:for-each select="$str1/*">
				<chapter>
					<xsl:for-each-group select="node()" group-adjacent="boolean(self::p[matches(@class, 'UnorderList_Alp')])">
						<xsl:choose>
							<xsl:when test="current-group()[matches(@class, 'UnorderList_Alp')][1]">
								<ol>
									<xsl:attribute name="class" select="current-group()[1]/@class" />
									<xsl:apply-templates select="current-group()" />
								</ol>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="current-group()" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each-group>
				</chapter>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="str3">
			<xsl:for-each select="$str2/*">
				<chapter>
					<xsl:for-each-group select="node()" group-adjacent="boolean(self::p[matches(@class, '_mark')])">
						<xsl:choose>
							<xsl:when test="current-group()[matches(@class, '_mark')][1]">
								<ul>
									<xsl:attribute name="class" select="current-group()[1]/@class" />
									<xsl:apply-templates select="current-group()" />
								</ul>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="current-group()" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each-group>
				</chapter>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="str4">
			<xsl:for-each select="$str3/*">
				<chapter>
					<xsl:apply-templates select="$attr" />
					<xsl:for-each-group select="node()" group-adjacent="boolean(self::p[matches(@class, 'OrderList\d_\d_Hyp')])">
						<xsl:choose>
							<xsl:when test="current-group()[matches(@class, 'OrderList\d_\d_Hyp')][1]">
								<ul>
									<xsl:attribute name="class" select="current-group()[1]/@class" />
									<xsl:apply-templates select="current-group()" />
								</ul>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="current-group()" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each-group>
				</chapter>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="str5">
			<xsl:for-each select="$str4/*">
				<chapter>
					<xsl:apply-templates select="$attr" />
					<xsl:for-each-group select="node()" group-adjacent="boolean(self::p[matches(@class, 'UnorderList\d_Number\d_\d')])">
						<xsl:choose>
							<xsl:when test="current-group()[matches(@class, 'UnorderList\d_Number\d_\d')][1]">
								<ol>
									<xsl:attribute name="class" select="current-group()[1]/@class" />
									<xsl:apply-templates select="current-group()" />
								</ol>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="current-group()" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each-group>
				</chapter>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="str6">
			<xsl:for-each select="$str5/*">
				<chapter>
					<xsl:apply-templates select="$attr" />
					<xsl:for-each-group select="node()" group-adjacent="boolean(self::p[matches(@class, 'UnorderList\d-Heading')])">
						<xsl:choose>
							<xsl:when test="current-group()[matches(@class, 'UnorderList\d-Heading')][1]">
								<ul>
									<xsl:attribute name="class" select="current-group()[1]/@class" />
									<xsl:apply-templates select="current-group()" />
								</ul>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="current-group()" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each-group>
				</chapter>
			</xsl:for-each>
		</xsl:variable>
		
		<xsl:copy-of select="$str6" />
    </xsl:template>

	<xsl:template match="*[*[matches(@class, 'UnorderList\d_Cell(_Hyp)?')]][name()!='ul']" mode="abc">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:for-each-group select="node()" group-adjacent="boolean(self::p[matches(@class, 'UnorderList\d_Cell(_Hyp)?')])">
				<xsl:choose>
					<xsl:when test="current-group()[matches(@class, 'UnorderList\d_Cell(_Hyp)?')][1]">
						<ul>
							<xsl:attribute name="class" select="current-group()[1]/@class" />
							<xsl:apply-templates select="current-group()"/>
						</ul>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="current-group()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each-group>
		</xsl:copy>
    </xsl:template>

	<xsl:template match="Cell" mode="abc">
		<xsl:variable name="str0">
			<xsl:for-each-group select="node()" group-adjacent="boolean(self::p[matches(@class, 'orderList')])">
				<xsl:choose>
					<xsl:when test="current-group()[1][matches(@class, '^Unorder')]">
						<ul>
							<xsl:attribute name="class" select="current-group()[1]/@class" />
							<xsl:apply-templates select="current-group()" />
                        </ul>
                    </xsl:when>

					<xsl:when test="current-group()[1][matches(@class, '^order')]">
						<ol>
							<xsl:attribute name="class" select="current-group()[1]/@class" />
							<xsl:apply-templates select="current-group()" />
						</ol>
					</xsl:when>

					<xsl:otherwise>
						<xsl:apply-templates select="current-group()" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each-group>
		</xsl:variable>
		
		<xsl:variable name="str1">
			<xsl:copy>
				<xsl:apply-templates select="@*" />
				<xsl:for-each-group select="$str0/node()" group-adjacent="boolean(self::p[matches(@class, 'Quad2')])">
					<xsl:choose>
						<xsl:when test="current-group()[matches(@class, 'Quad2')][1]">
							<ul>
								<xsl:attribute name="class" select="current-group()[1]/@class" />
								<xsl:apply-templates select="current-group()" />
							</ul>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="current-group()" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each-group>
			</xsl:copy>
		</xsl:variable>

		<xsl:copy-of select="$str1" />
    </xsl:template>
	
	<xsl:function name="son:last">
		<xsl:param name="arg1" />
		<xsl:param name="arg2" />
		<xsl:copy-of select="tokenize($arg1, $arg2)[last()]" />
	</xsl:function>
	
</xsl:stylesheet>