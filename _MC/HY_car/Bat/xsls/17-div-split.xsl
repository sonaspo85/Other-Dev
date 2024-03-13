<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	<xsl:variable name="body_open">&lt;div class=&quot;body_icon&quot;&gt;</xsl:variable>
	<xsl:variable name="image_open">&lt;div class=&quot;image_box&quot;&gt;</xsl:variable>
	<xsl:variable name="close">&lt;/div&gt;</xsl:variable>
	
	<xsl:output method="xml" encoding="UTF-8" indent="no" />
	<xsl:strip-space elements="*"/>
	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

	<!--<xsl:template match="div[matches(@class, 'body_icon')][count(Image) &gt; 1]">
		<xsl:for-each-group select="node()" group-starting-with="Image[following-sibling::node()[1][matches(@class, 'Description')]]">
			<xsl:choose>
				<xsl:when test="current-group()[1][name()='Image'][following-sibling::node()[1][matches(@class, 'Description')]]">
					<div class="body_icon">
						<xsl:apply-templates select="current-group()" />
					</div>
	        	</xsl:when>

				<xsl:otherwise>
					<div class="body_icon">
						<xsl:apply-templates select="current-group()" />
					</div>
                </xsl:otherwise>
        	</xsl:choose>
        </xsl:for-each-group>
    </xsl:template>-->

	<xsl:template match="div[matches(@class, 'body_icon')]">
		<xsl:choose>
			<xsl:when test="count(Image) &gt; 1">
				<xsl:for-each-group select="node()" group-starting-with="Image[following-sibling::node()[1][matches(@class, 'Description')]]">
					<xsl:choose>
						<xsl:when test="current-group()[1][name()='Image'][following-sibling::node()[1][matches(@class, 'Description')]]">
							<div class="body_icon">
								<xsl:apply-templates select="current-group()" />
							</div>
						</xsl:when>

						<xsl:otherwise>
							<div class="body_icon">
								<xsl:apply-templates select="current-group()" />
							</div>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each-group>
	    	</xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*" />

					<xsl:for-each-group select="node()" group-ending-with="p[matches(@class, 'Design_num')][preceding-sibling::node()[1][count(node()) = 1 and Image]]">
						<xsl:choose>
							<xsl:when test="current-group()[matches(@class, 'Design_num')]">
								<div class="image_box">
								<xsl:for-each select="current-group()">
									<xsl:choose>
										<xsl:when test="count(node()) = 1 and Image">
											<xsl:apply-templates />
                                        </xsl:when>
										<xsl:otherwise>
											<xsl:copy>
												<xsl:apply-templates select="@*, node()" />
                                        	</xsl:copy>
                                        </xsl:otherwise>
                                    </xsl:choose>
									
                                </xsl:for-each>
									</div>
								<!--<div class="image_box">
									<xsl:apply-templates select="current-group()/node()" />
								</div>-->
                            </xsl:when>

							<xsl:otherwise>
								<xsl:apply-templates select="current-group()" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each-group>
				</xsl:copy>
            </xsl:otherwise>
    	</xsl:choose>
	</xsl:template>

</xsl:stylesheet>