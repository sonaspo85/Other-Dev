<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
    exclude-result-prefixes="xs son xsi aid"
    version="2.0">

	<xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:variable name="language" select="lower-case(body/@language)" />
	<xsl:variable name="ltr">
		<xsl:choose>
			<xsl:when test="matches($language, 'ara')">
				<xsl:value-of select="'rtl'" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'ltr'" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

	<!--73-element-define.xsl 참고로 추가 할것-->
	
	<xsl:template match="body">
		<xsl:copy>
			<xsl:attribute name="dir" select="$ltr" />
			<xsl:apply-templates select="@*, node()" />
		</xsl:copy>
    </xsl:template>
	
	<xsl:template match="span">
		<xsl:choose>
			<xsl:when test="matches(@class, 'C_Subscript')">
				<xsl:choose>
					<xsl:when test="following-sibling::node()[1][matches(@class, 'C_Subscript')]">
						<sup>
							<xsl:apply-templates select="@*, node()" />
							<xsl:copy-of select="following-sibling::node()[1]/node()" />
						</sup>
                    </xsl:when>
					<xsl:when test="preceding-sibling::node()[1][matches(@class, 'C_Subscript')]">
					</xsl:when>

					<xsl:otherwise>
						<sup>
							<xsl:apply-templates select="@*, node()" />
						</sup>
                    </xsl:otherwise>
                </xsl:choose>
        	</xsl:when>
			
			<xsl:when test="matches(@class, 'C_LtoR')">
				<xsl:choose>
					<xsl:when test="following-sibling::node()[1][matches(@class, 'C_LtoR')]">
						<xsl:copy>
							<xsl:attribute name="dir" select="'ltr'" />
							<xsl:apply-templates select="@*, node()" />
							<xsl:text>&#x20;</xsl:text>
							<xsl:value-of select="following-sibling::node()[1]" />
                        </xsl:copy>
                    </xsl:when>
					<xsl:when test="preceding-sibling::node()[1][matches(@class, 'C_LtoR')]">
                    </xsl:when>

					<xsl:otherwise>
						<xsl:copy>
							<xsl:attribute name="dir" select="'ltr'" />
							<xsl:apply-templates select="@*, node()" />
						</xsl:copy>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

			<xsl:when test="matches(@class, 'C_Important')">
				<strong>
					<xsl:apply-templates select="node()" />
                </strong>
        	</xsl:when>
			
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<!--<xsl:template match="*[following-sibling::node()[1][matches(@class, 'C_Subscript')]]">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
			<xsl:for-each select="following-sibling::*[1]">
				<sup222>
					<xsl:apply-templates select="@*, node()" />
				</sup222>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>-->

	<xsl:template match="p">
		<xsl:choose>
			<xsl:when test="matches(@class, '(Warning|Caution|INFO|NOTE)')">
				<h2>
				<xsl:apply-templates select="@*" />
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="self::text() and parent::*[matches(@class, 'NOTE')]">
								<span class="NOTE">
									<xsl:value-of select="normalize-space(.)" />
								</span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="normalize-space(.)" />
	                        </xsl:otherwise>
	                    </xsl:choose>
	                </xsl:for-each>
				</h2>
            </xsl:when>
			
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
            	</xsl:copy>
            </xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

	<xsl:template match="text()[parent::*[not(matches(@class, 'C_LtoR'))]]" priority="10">
		<xsl:variable name="parent_class" select="parent::*[matches(@class, 'Heading\d_Number')]" />
		<!--<xsl:variable name="direction" select="if (parent::*[matches(@class, 'C_LtoR')]) then '&#x200e;' else '&#x200f;'" />-->
		<!-- &#x200f; : RIGHT-TO-LEFT MARK
			 &#x200e; : LEFT-TO-RIGHT MARK-->
		<xsl:variable name="str0">
			<xsl:choose>
				<xsl:when test="matches($language, 'ara')">
					<xsl:analyze-string select="." regex="(\d+)([±\-])(\d+)">
						<xsl:matching-substring>
							<xsl:value-of select="regex-group(1)" />
							<xsl:text>&#x200f;</xsl:text>
							<xsl:value-of select="regex-group(2)" />
							<xsl:text>&#x200f;</xsl:text>
							<xsl:value-of select="regex-group(3)" />
						</xsl:matching-substring>
						<xsl:non-matching-substring>
							<xsl:analyze-string select="." regex="([+-])([\d\.]+)">
								<xsl:matching-substring>
									<xsl:text>&#x200e;</xsl:text>
									<xsl:value-of select="regex-group(1)" />
									<xsl:value-of select="regex-group(2)" />
									<xsl:text>&#x200e;</xsl:text>
								</xsl:matching-substring>
								<xsl:non-matching-substring>
									<xsl:analyze-string select="." regex="([a-zA-Z])(،)(\s)?([a-zA-Z])">
										<xsl:matching-substring>
											<xsl:value-of select="regex-group(1)" />
											<xsl:text>&#x200f;</xsl:text>
											<xsl:value-of select="regex-group(2)" />
											<xsl:value-of select="regex-group(3)" />
											<xsl:value-of select="regex-group(4)" />
										</xsl:matching-substring>

										<xsl:non-matching-substring>
											<xsl:value-of select="." />
										</xsl:non-matching-substring>
									</xsl:analyze-string>
								</xsl:non-matching-substring>
							</xsl:analyze-string>
						</xsl:non-matching-substring>
					</xsl:analyze-string>
                </xsl:when>
				
				<xsl:otherwise>
					<xsl:value-of select="." />
                </xsl:otherwise>
            </xsl:choose>
		</xsl:variable>

		<xsl:for-each select="$str0">
			<xsl:choose>
				<xsl:when test="$parent_class">
					<span>
						<xsl:attribute name="class" select="$parent_class/@class" />
						<xsl:value-of select="." />
					</span>
				</xsl:when>
				
				<xsl:otherwise>
					<xsl:value-of select="." />
				</xsl:otherwise>
			</xsl:choose>
        </xsl:for-each>
    </xsl:template>

	<xsl:template match="@class">
		<xsl:choose>
			<xsl:when test="matches(., '[_\-]Child')">
				<xsl:attribute name="class">
					<xsl:value-of select="'list_indent'" />
				</xsl:attribute>
            </xsl:when>

			<xsl:when test="parent::td/descendant::*[matches(@class, 'C_table_left')]">
				<xsl:attribute name="class">
					<xsl:value-of select="concat(., ' ', 'C_table_left')" />
				</xsl:attribute>
            </xsl:when>
			
			<xsl:otherwise>
				<xsl:attribute name="class">
					<xsl:value-of select="." />
				</xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
	</xsl:template>
	
	<xsl:template match="warning-group">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="*[1][matches(@class, 'Warning')]">
					<xsl:value-of select="'Warning'" />
                </xsl:when>

				<xsl:when test="*[1][matches(@class, 'Caution')]">
					<xsl:value-of select="'Caution'" />
				</xsl:when>

				<xsl:when test="*[1][matches(@class, 'NOTE')]">
					<xsl:value-of select="'notice'" />
				</xsl:when>

				<xsl:when test="*[1][matches(@class, 'INFO')]">
					<xsl:value-of select="'info'" />
				</xsl:when>
            </xsl:choose>
        </xsl:variable>
		
		<div class="{$class}">
			<xsl:apply-templates />
		</div>
    </xsl:template>

	<xsl:template match="Image">
		<img>
			<xsl:apply-templates select="@*, node()" />
		</img>
    </xsl:template>

	<xsl:template match="@crows">
		<xsl:attribute name="rowspan">
			<xsl:value-of select="." />
        </xsl:attribute>
    </xsl:template>

	<xsl:template match="@ccols">
		<xsl:attribute name="colspan">
			<xsl:value-of select="." />
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="@newrow | @namest | @nameend | @table">
    </xsl:template>
	
</xsl:stylesheet>
