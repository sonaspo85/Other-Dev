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

	<xsl:template match="Table">
		<xsl:choose>
			<xsl:when test="Cell/descendant::span[matches(@class, 'C_Heading')]">
				<div class="title_icon">
					<xsl:apply-templates select="Cell/node()" />
				</div>
			</xsl:when>

			<xsl:when test="matches(@class, 'Table_Image_Text') and 
					  		@ul_split">
				<div class="body_icon">
					<div class="image_box">
    					<xsl:for-each select="node()">
    						<xsl:choose>
    							<xsl:when test="child::ul">
                                </xsl:when>
    							
    							<xsl:otherwise>
    								<xsl:apply-templates select="node()" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
					</div>
					<xsl:apply-templates select="Cell[2]/node()" />
				</div>
			</xsl:when>

			<xsl:when test="Cell[matches(@class, 'Cell_Description_none')]">
				<xsl:choose>
					<xsl:when test="count(Cell[1]/node()) = 1 and Cell/Image and 
							  		Cell[1]/following-sibling::*/descendant::*[matches(@class, 'Design_num')]">
						<div class="image_box">
							<xsl:apply-templates select="Cell/node()" />
						</div>
                    </xsl:when>

					<xsl:otherwise>
						<div class="body_icon">
							<xsl:apply-templates select="Cell/node()" />
						</div>
                    </xsl:otherwise>
                </xsl:choose>
			</xsl:when>

			<xsl:when test="matches(@class, 'Table_Image_Text') and 
					  		Cell[matches(@class, '(Cell_Description|\[None\])')]">
				<div class="body_icon">
					<xsl:apply-templates select="Cell/node()" />
				</div>
			</xsl:when>
			
			<xsl:when test="not(matches(@class, 'Table_Maintenance')) and 
					  		Cell/descendant::span[matches(@class, 'C_info_Times')]">
				<div class="body_icon">
					<xsl:apply-templates select="Cell/node()" />
				</div>
			</xsl:when>

			<!--<xsl:when test="matches(@class, 'Table_Text_none\-3')">
				<div class="body_icon">
					<xsl:for-each-group select="Cell" group-starting-with="*[matches(., '\s:$')]">
						<xsl:choose>
							<xsl:when test="current-group()[matches(., '\s:$')]">
								<p>
								<xsl:apply-templates select="current-group()/p/@*" />
								<xsl:value-of select="current-group()/node()" />
								</p>
	                        </xsl:when>

							<xsl:otherwise>
								<xsl:apply-templates select="current-group()" />
	                        </xsl:otherwise>
	                    </xsl:choose>
	                </xsl:for-each-group>
				</div>
			</xsl:when>-->

			<xsl:when test="matches(@class, 'Table_Text_none\-\d')">
				<xsl:choose>
					<xsl:when test="matches(@class, 'Table_Text_none\-3')">
						<div class="body_icon">
							<xsl:for-each-group select="Cell" group-starting-with="*[matches(., '(\s:$|\s\-$|^\*$|^\*\*$)')]">
								<xsl:choose>
									<xsl:when test="current-group()[matches(., '(\s:$|\s\-$|^\*$|^\*\*$)')]">
										<p>
											<xsl:attribute name="class" select="'Table_Text_none-3'" />
											<xsl:value-of select="current-group()/node()" />
										</p>
									</xsl:when>

									<xsl:otherwise>
										<xsl:apply-templates select="current-group()" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each-group>
						</div>
                	</xsl:when>
                    
					<xsl:otherwise>
						<div class="body_icon">
							<p>
								<xsl:apply-templates select="Cell[1]/p/@*" />
								<xsl:for-each select="Cell/node()">
									<xsl:apply-templates />
									<xsl:text>&#x20;</xsl:text>
								</xsl:for-each>
							</p>
						</div>
                    </xsl:otherwise>
                </xsl:choose>
			</xsl:when>

			<xsl:when test="matches(@class, '^Table_Text_none$')">
				<xsl:variable name="cur" select="." />

                <xsl:choose>
                    <xsl:when test="Cell[1]/ul[empty(*/text())]">
                        <div class="image_box">
                            <span class="img_bullet">• </span>
                            <xsl:apply-templates select="Cell[position() &gt; 1]/node()" />
                        </div>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:call-template name="recall">
                            <xsl:with-param name="cur" select="$cur" />
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
                
				
			</xsl:when>

			<xsl:when test="Cell[1][matches(@class, '^Cell_Description(_none)?$')]
					  		[following-sibling::node()[1][matches(@class, '(^Cell_Description$|\[None\])')]]">
				<xsl:variable name="cur" select="." />
				
				<xsl:call-template name="recall">
					<xsl:with-param name="cur" select="$cur" />
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="count(Cell) = 1 and 
					  		Cell/Image">
				<div class="image_box">
					<xsl:apply-templates select="Cell/Image" />
				</div>
			</xsl:when>

			<xsl:when test="Cell[1]/Image or 
					  		Cell[1][matches(@class, '(Cell_ImagQuad|Cell_Quad|Cell_Img)')]">
				<div class="image_box">
					<xsl:apply-templates select="Cell/node()" />
				</div>
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:copy>
					<xsl:attribute name="class">
						<xsl:value-of select="concat('standard', ' ', @class)" />
                    </xsl:attribute>
					<xsl:for-each-group select="node()" group-adjacent="boolean(self::*[matches(@class, '(_Heading|_Heding)')])">
						<xsl:choose>
							<xsl:when test="current-group()[matches(@class, '(_Heading|_Heding)')]">
								<thead>
									<xsl:apply-templates select="current-group()" />
								</thead>
                            </xsl:when>
							
							<xsl:otherwise>
								<tbody>
									<xsl:apply-templates select="current-group()" />
								</tbody>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each-group>
            	</xsl:copy>
            </xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

	<!--<xsl:template match="Cell[count(*[matches(@class, '^Quad1_noText$')]) &gt; 1]">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:choose>
				<xsl:when test="*[matches(@class, '^Quad1_noText$')]
						  		[following-sibling::node()[1][matches(@class, '^Quad1_noText$')]]">
					<div class="image_box">
						<xsl:copy-of select="Image" />
						
						<xsl:for-each select="node()">
							<xsl:choose>
								<xsl:when test="self::Image">
                                </xsl:when>

								<xsl:otherwise>
									<xsl:copy>
										<xsl:apply-templates select="@*, node()" />
                                    </xsl:copy>
                                </xsl:otherwise>
                            </xsl:choose>
						</xsl:for-each>
					</div>
            	</xsl:when>

				<xsl:otherwise>
					<xsl:apply-templates select="node()" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
		
	</xsl:template>-->

    <xsl:template match="Cell">
            <xsl:choose>
                <xsl:when test="count(*[matches(@class, '^Quad1_noText$')]) &gt; 1">
                    <xsl:copy>
                        <xsl:apply-templates select="@*" />
                    <xsl:choose>
                        <xsl:when test="*[matches(@class, '^Quad1_noText$')]
						  		        [following-sibling::node()[1][matches(@class, '^Quad1_noText$')]]">
                            <div class="image_box">
                                <xsl:copy-of select="Image" />

                                <xsl:for-each select="node()">
                                    <xsl:choose>
                                        <xsl:when test="self::Image">
                                        </xsl:when>

                                        <xsl:otherwise>
                                            <xsl:copy>
                                                <xsl:apply-templates select="@*, node()" />
                                            </xsl:copy>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                            </div>
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:apply-templates select="node()" />
                        </xsl:otherwise>
                    </xsl:choose>
                    </xsl:copy>
                </xsl:when>

                <xsl:when test="parent::*[matches(@class, 'Table_Maintenance')] and 
                                        Image[following-sibling::node()[1][matches(@class, 'Design_num')]]">
                    <xsl:copy>
                        <xsl:apply-templates select="@*" />
                        <div class="image_box">
                            <xsl:apply-templates select="@* except @class" />
                            <xsl:apply-templates select="node()" />
                        </div>
                   </xsl:copy>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:copy>
                        <xsl:apply-templates select="@*, node()" />
                    </xsl:copy>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
	
	
	<xsl:template name="recall">
		<xsl:param name="cur" />

		<xsl:for-each select="$cur">
			<xsl:copy>
				<xsl:attribute name="class">
					<xsl:choose>
    					<xsl:when test="matches(@class, '^Table_Text_none$')">
    						<xsl:value-of select="@class" />
                    	</xsl:when>

    					<xsl:otherwise>
    						<xsl:value-of select="concat('standard', ' ', @class)" />
                        </xsl:otherwise>
                    </xsl:choose>
				</xsl:attribute>
                
				<xsl:for-each-group select="node()" group-adjacent="boolean(self::*[not(matches(@class, '(_Heading|_Heding)'))])">
					<xsl:choose>
						<xsl:when test="current-grouping-key()">
							<tbody>
								<xsl:apply-templates select="current-group()" />
							</tbody>
						</xsl:when>

						<xsl:otherwise>
							<thead>
								<xsl:apply-templates select="current-group()" />
							</thead>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each-group>
			</xsl:copy>
		</xsl:for-each>
    </xsl:template>
	
</xsl:stylesheet>