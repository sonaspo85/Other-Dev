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


	<xsl:template match="*[parent::*[matches(@class, 'image_box')]]">
		<xsl:choose>
			<xsl:when test="matches(@class, '(^Quad1$|^Quad2$)')">
				<div class="image_title">
					<xsl:copy>
						<xsl:apply-templates select="@*, node()"/>
					</xsl:copy>
				</div>
			</xsl:when>

			<xsl:when test="matches(@class, '^Quad1_noText$')">
				<div class="image_title">
					<xsl:apply-templates select="node()"/>
				</div>
			</xsl:when>

			<xsl:when test="matches(@class, 'Design_num')">
				<div class="image_number">
					<xsl:copy>
						<xsl:apply-templates select="@*, node()"/>
					</xsl:copy>
				</div>
			</xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

	<xsl:template match="*[matches(@class, 'image_box')]">
		<xsl:variable name="str0">
            
			<xsl:for-each select="node()">
				<xsl:choose>
					<xsl:when test="self::*[matches(@class, '^Quad1$')] and following-sibling::*[1][name()='Image']">
						<xsl:variable name="first_img" select="following-sibling::*[1][name()='Image']" />
						<xsl:copy-of select="$first_img" />
						<xsl:apply-templates select="."/>
					</xsl:when>
					<xsl:when test="self::*[1][name()='Image'] and preceding-sibling::*[1][matches(@class, '^Quad1$')]">
					</xsl:when>

					<xsl:when test="self::*[name()='Image'] and preceding-sibling::*[matches(@class, '^Quad1_noText$')]">
						<xsl:variable name="Quad1_noText" select="preceding-sibling::*[matches(@class, '^Quad1_noText$')]" />
						
						<xsl:apply-templates select="."/>
						<xsl:apply-templates select="$Quad1_noText" />
					</xsl:when>

					<xsl:when test="self::*[matches(@class, '^Quad2$')] and following-sibling::*[1][name()='Image']">
						<xsl:variable name="first_img" select="following-sibling::*[1][name()='Image']" />
						<xsl:copy-of select="$first_img" />
						<xsl:apply-templates select="."/>
					</xsl:when>
					<xsl:when test="self::*[1][name()='Image'] and preceding-sibling::*[1][matches(@class, '^Quad2$')]">
					</xsl:when>

					<xsl:when test="self::*[matches(@class, '^image_title$')] and following-sibling::*[1][name()='Image']">
						<xsl:variable name="first_img" select="following-sibling::*[1][name()='Image']" />
						<xsl:copy-of select="$first_img" />
						<xsl:apply-templates select="."/>
					</xsl:when>
					<xsl:when test="self::*[1][name()='Image'] and preceding-sibling::*[1][matches(@class, '^image_title$')]">
					</xsl:when>
					
					<xsl:otherwise>
						<xsl:apply-templates select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>

		<xsl:for-each select="$str0/node()">
			<xsl:choose>
				<xsl:when test="self::Image">
					<div class="image_box">
						<xsl:copy>
							<xsl:apply-templates select="@*, node()" />
							<xsl:copy-of select="following-sibling::*" />
						</xsl:copy>
					</div>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="p[descendant::Image]">
		<xsl:choose>
			<xsl:when test="count(node()) = 1 and span[count(node()) = 1]/Image">
				<xsl:apply-templates select="span/Image" />
	    	</xsl:when>

			<xsl:when test="count(node()) = 1 and Image">
				<xsl:apply-templates select="Image" />
			</xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

	<xsl:template match="p[matches(@class, 'Caption_R')]" priority="10">
		<div class="image_number">
			<xsl:copy>
				<xsl:apply-templates select="@*, node()" />
			</xsl:copy>
		</div>
    </xsl:template>

	<xsl:template match="Image">
		<xsl:choose>
			<xsl:when test="parent::*[matches(@class, 'body_icon')] and 
					  		not(following-sibling::node()) and 
					  		preceding-sibling::node()[1][name()='ul'] and 
					  		parent::*/following-sibling::node()[1][name()='ul']">
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
				</xsl:copy>
				<xsl:copy-of select="parent::*/following-sibling::node()[1]" />
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

	<xsl:template match="ul">
		<xsl:choose>
			<xsl:when test="preceding-sibling::node()[1][matches(@class, 'body_icon')]
					  		/node()[last()][name()='Image']
					  		[preceding-sibling::node()[1][name()='ul']]">
				<!-- 121번라인 대응 -->
            </xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<xsl:template match="ol">
		<xsl:choose>
			<xsl:when test="*[1][matches(@class, 'image_box')] and 
					  		preceding-sibling::node()[1][matches(@class, 'image_box')]">
				
				<xsl:apply-templates select="*[1][matches(@class, 'image_box')]" />
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="position() = 1 and matches(@class, 'image_box')">
                            </xsl:when>
							
							<xsl:otherwise>
								<xsl:copy>
									<xsl:apply-templates select="@*, node()" />
                                </xsl:copy>
                            </xsl:otherwise>
                    	</xsl:choose>
                    </xsl:for-each>
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