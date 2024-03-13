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

	<xsl:template match="Image">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::*[matches(@class, 'body_icon')]
						  				[preceding-sibling::node()[matches(@class, 'Heading')]]
						  				[following-sibling::node()[matches(@class, 'Description')]]
						  				[count(Image) = 2]">
					<xsl:value-of select="'general'" />
				</xsl:when>
				
				<xsl:when test="parent::*[matches(@class, 'body_icon')] and following-sibling::*[1][name()!='ul']">
					<xsl:value-of select="if (following-sibling::node()[1][matches(@class, 'Description')]) 
								  		  then 'Side_Icon_10mm_L' 
								  		  else 'Side_Icon_15mm_L'" />
                </xsl:when>

				<xsl:when test="parent::li/parent::ul[following-sibling::node()[1][name()!='ul']]/parent::*[matches(@class, 'body_icon')]">
					<xsl:value-of select="'Side_Icon_10mm_L'" />
				</xsl:when>
				
				<xsl:when test="following-sibling::*[1][*[matches(@class, '(C_Heading|C_info_Times)')]]">
					<xsl:value-of select="'Side_Icon_10mm_L'" />
				</xsl:when>

				<xsl:when test="parent::*[name()!='span'][matches(@class, '(title_icon)')] and 
						  		following-sibling::node()">
					<xsl:value-of select="'Side_Icon_10mm_L'" />
				</xsl:when>

				<xsl:when test="following-sibling::node()[1][matches(@class, 'image_number')]">
					<xsl:value-of select="'img_center'" />
				</xsl:when>

				<xsl:when test="matches(@class, 'Description_Cell_8.5pt_C')">
					<xsl:value-of select="'img_center'" />
				</xsl:when>

				<xsl:when test="following-sibling::node()[1][matches(@class, 'Description_Cell_8')]">
					<xsl:value-of select="'img_center'" />
				</xsl:when>

				<xsl:when test="matches(@class, 'Description_Cell_8.5pt_R')">
					<xsl:value-of select="@class" />
				</xsl:when>

				<xsl:when test="parent::span[matches(@class, '(C_image|C_Heading|C_Important|C_info_Times)')] or parent::p">
					<xsl:value-of select="'c_image'" />
				</xsl:when>
				
				<xsl:otherwise>
					<xsl:value-of select="'general'" />
                </xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
			
		<xsl:copy>
			<xsl:attribute name="class" select="$class" />
			<xsl:apply-templates select="@* except @class" />
			<xsl:apply-templates select="node()" />
		</xsl:copy>
    </xsl:template>

	<xsl:template match="div[matches(@class, 'image_box')]">
		<xsl:choose>
			<xsl:when test="count(node()) = 1 and Image[matches(@src, 'Arrow_')]">
				<div class="image_box" style="display: block;">
					<xsl:apply-templates select="@*, node()" />
                   <!-- <xsl:if test="preceding-sibling::node()[1][matches(name(), '(ol|ul)')] and 
                                  following-sibling::node()[1][matches(@class, '\-Child$')] and 
                                  following-sibling::node()[2][matches(name(), '(ol|ul)')]">
                        <xsl:copy-of select="following-sibling::node()[1]" />
                    </xsl:if>-->
                </div>
            </xsl:when>
            
            <!--<xsl:when test="count(node()) = 1 and 
                            preceding-sibling::node()[1][matches(name(), '(ol|ul)')] and 
                            following-sibling::node()[1][matches(@class, '\-Child$')] and 
                            following-sibling::node()[2][matches(name(), '(ol|ul)')]">
                <div class="image_box">
                    <xsl:apply-templates select="@*, node()" />
                    <xsl:copy-of select="following-sibling::node()[1]" />
                </div>
            </xsl:when>-->
            
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--<xsl:template match="p[matches(@class, '\-Child$')][preceding-sibling::node()[1][matches(@class, 'image_box')]]">
    </xsl:template>-->
	
</xsl:stylesheet>