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

	<xsl:template match="*[matches(name(), '(ol|ul)')]">
		<xsl:choose>
			<xsl:when test="matches(@class, 'Description_Sub')">
				<div class="footnote">
					<xsl:apply-templates select="@* except @class" />
					<xsl:apply-templates select="node()" />
				</div>
			</xsl:when>

			<xsl:when test="matches(@class, '^Heading\d')">
				<xsl:apply-templates />
			</xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					
					<xsl:for-each select="node()">
						<li>
							<xsl:apply-templates select="@class" />
							<xsl:apply-templates select="." />
						</li>
                    </xsl:for-each>
            	</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>

	<xsl:template match="p">
		<xsl:choose>
			<xsl:when test="matches(@class, 'Description_Sub')">
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					<sub>
						<xsl:value-of select="concat('*', @Num, ': ')" />
					</sub>
					<xsl:apply-templates select="node()" />
				</xsl:copy>
            </xsl:when>

			<xsl:when test="matches(@class, '_mark$')">
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					<span class="ul_mark">
						<xsl:value-of select="'* '" />
					</span>
					<xsl:apply-templates select="node()" />
				</xsl:copy>
			</xsl:when>

			<xsl:when test="matches(@class, 'UnorderList\d_Number\d_\d\)')">
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					<span class="task_num">
						<xsl:value-of select="concat(@Num, ') ')" />
					</span>
					<xsl:apply-templates select="node()" />
				</xsl:copy>
			</xsl:when>
			
			<xsl:when test="matches(@class, '(Chapter_TOC\d|^OrderList\d(_\d)?(\-10over)?$|^Heading\d_\d$|Description_NumB|UnorderList_Alp|OrderList_TimeB\d|Heading\d_Number\d_\d|UnorderList\d_Number\d_\d)')">
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					<span class="task_num">
						<xsl:value-of select="concat(@Num, '. ')" />
					</span>
					<xsl:apply-templates select="node()" />
				</xsl:copy>
			</xsl:when>

			<xsl:when test="matches(@class, '^Step\d_\d')">
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					<span class="step_num">
						<xsl:value-of select="concat('(', @Num, ') ')" />
					</span>
					<xsl:apply-templates select="node()" />
				</xsl:copy>
			</xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
    	</xsl:choose>
    </xsl:template>
	
</xsl:stylesheet>