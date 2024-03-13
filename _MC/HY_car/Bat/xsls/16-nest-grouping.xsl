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

	<xsl:template match="chapter">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:for-each-group select="node()" group-starting-with="*[matches(@class, 'body_icon')][*[name()!='Image'][not(following-sibling::node())][matches(@class, '^Description$')]]">

				<xsl:choose>
					<xsl:when test="current-group()[1][matches(@class, 'body_icon')][count(node()) &gt; 1]
							  		/following-sibling::node()[1][matches(@class, '^Description$')][not(*[matches(@class, 'C_Heading')])]">
						<xsl:value-of select="$body_open" disable-output-escaping="yes" />
						<xsl:apply-templates select="current-group()[1]/node()" />

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

	<xsl:template match="*[matches(@class, 'image_box')]">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:variable name="str0">
				<xsl:for-each-group select="node()"  group-adjacent="boolean(self::*[matches(@class, 'Quad1_noText')])">
					<xsl:choose>
					<xsl:when test="current-group()[1][matches(@class, 'Quad1_noText')]">
						<div class="Quad1_noText">
							<xsl:apply-templates select="current-group()" />
	                    </div>
	    	        </xsl:when>

					<xsl:otherwise>
						<xsl:apply-templates select="current-group()" />
	                </xsl:otherwise>
	 	           </xsl:choose>
	            </xsl:for-each-group>
			</xsl:variable>

			<xsl:variable name="str1">
				<xsl:for-each-group select="$str0/node()"  group-adjacent="boolean(self::*[*[matches(@class, '(C_img_text_left|C_img_text_right)')]])">
					<xsl:choose>
						<xsl:when test="current-group()[1][*[matches(@class, '(C_img_text_left|C_img_text_right)')]]">
							<div class="img_wrap">
								<xsl:apply-templates select="current-group()/node()" />
							</div>
						</xsl:when>

						<xsl:otherwise>
							<xsl:apply-templates select="current-group()" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each-group>
			</xsl:variable>

			<xsl:for-each select="$str1/node()">
				<xsl:choose>
					<xsl:when test="matches(@class, 'Quad1') and following-sibling::node()[1][matches(@class, 'Quad2')]">
						<div class="image_title">
							<xsl:copy>
								<xsl:apply-templates select="@*, node()" />
                            </xsl:copy>
							<xsl:copy-of select="following-sibling::node()[1]" />
						</div>
                    </xsl:when>
					<xsl:when test="matches(@class, 'Quad2') and preceding-sibling::node()[1][matches(@class, 'Quad1')]">
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

	<xsl:template name="grouping">
		<xsl:param name="group" />
		<xsl:param name="preceding-class" />

		<xsl:choose>
			<xsl:when test="$preceding-class[.='body_icon'] and $group[1][matches(@class, '^Description$')][*[1][matches(@class, '^C_Important$')]] or 
					  		$preceding-class[.='body_icon'] and $group[1][matches(@class, '^Description$')]">
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
	</xsl:template>


	<xsl:template match="p">
		<xsl:choose>
			<xsl:when test="matches(@class, '_mark') and 
					  		ancestor::ul[1][following-sibling::node()[1][matches(@class, 'Description')]]
					  		/parent::*[matches(@class, 'body_icon')]">
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
					<xsl:text>&#x20;</xsl:text>
					<xsl:copy-of select="ancestor::ul[1]/following-sibling::node()/node()" />
                </xsl:copy>
	        </xsl:when>
			<xsl:when test="matches(@class, 'Description') and 
					  		parent::*[matches(@class, 'body_icon')] and 
					  		preceding-sibling::node()[1]/descendant::*[matches(@class, '_mark')]">
            </xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
    	</xsl:choose>
    </xsl:template>
</xsl:stylesheet>