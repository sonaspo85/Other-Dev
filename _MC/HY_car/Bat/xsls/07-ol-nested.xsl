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

	<xsl:template match="ol">
		<xsl:variable name="name" select="name()" />
		<xsl:variable name="flw_Hyp" select="following-sibling::*[1][matches(@class, '(^UnorderList2$|UnorderList1_Hyp(\d)?|UnorderList\d_Number\d_\d)')]" />
		
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			
			<xsl:if test="not(matches(@class, '(OrderList_TimeB|Heading\d_Number\d_\d)')) and preceding-sibling::*[1][name()='Table'][matches(@class, 'Table_Image_Text')][matches(@out_class, 'Empty\d')]">
				<xsl:copy-of select="preceding-sibling::*[1][name()='Table'][matches(@out_class, 'Empty\d')]" />
			</xsl:if>
			
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
        </xsl:copy>
    </xsl:template>

	<xsl:template match="ol[matches(@class, 'UnorderList\d_Number\d_\d')][preceding-sibling::*[1][name()='ol']]">
	</xsl:template>

	<xsl:template match="ul">
		<xsl:choose>
			<xsl:when test="matches(@class, '^UnorderList2$|UnorderList1_Hyp(\d)?') and preceding-sibling::*[1][matches(name(), 'ol')]">
            </xsl:when>
			
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<xsl:template match="Table">
		<xsl:variable name="pre_name" select="name(preceding-sibling::*[1])" />
		
		<xsl:choose>
			<xsl:when test="matches(@out_class, 'Empty\d') and 
					  		matches(@class, 'Table_Image_Text') and 
					  		following-sibling::*[1][name()='ol'][not(matches(@class, '(OrderList_TimeB|Heading\d_Number\d_\d)'))]">
        	</xsl:when>
			
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
            	</xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
	
</xsl:stylesheet>