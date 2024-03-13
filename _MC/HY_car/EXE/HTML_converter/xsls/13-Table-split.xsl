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

	<!--<xsl:key name="img_src" match="Table/Cell[count(node())=1]" use="Image/@class[starts-with(., 'Img-Center')]" />
	<xsl:key name="cell_class" match="Table[Cell[count(node())=1]]" use="Cell/p/@class[starts-with(., 'Design_num')]" />-->
	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

	<xsl:template match="Cell">
		<xsl:choose>
			<xsl:when test="empty(node()) and count(parent::Table[not(matches(@class, 'Table_Maintenance'))]/descendant::*[name()='Image']) = 1">
			</xsl:when>

			<xsl:when test="empty(node())">
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					<xsl:text>&#xA0;</xsl:text>
                </xsl:copy>
        	</xsl:when>

			<xsl:when test="not(preceding-sibling::node()) and *[matches(@class, '(Heading3_\d\-\d|Heading\d)')]">
				<!-- 54번 라인 -->
            </xsl:when>

			<xsl:when test="descendant::*[matches(@class, 'C_table_left')]">
				<xsl:copy>
					<xsl:attribute name="class" select="following-sibling::node()[1]/@class" />
					<!--<xsl:attribute name="class" select="'Description_Cell'" />-->
					<xsl:apply-templates select="@* except @class" />
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

	<xsl:template match="Table">
		<xsl:variable name="table_cur" select="." />
		<xsl:variable name="count_img" select="count($table_cur[count(descendant::Image) &gt; 0]/descendant::Image[starts-with(@class, 'Img-Center')])" />
		<xsl:variable name="cls_degn_pos" select="descendant::p[starts-with(@class, 'Design')]" />
		<xsl:variable name="quad1_pos" select="descendant::*[matches(name(), '(p|ul)')][matches(@class, '^Quad\d$')]" />
		<xsl:variable name="img_pos" select="descendant::Image" />
		<xsl:variable name="quad2_pos" select="descendant::ul[matches(@class, '^Quad2$')]" />
		
		<xsl:if test="*[1]/*[matches(@class, '(Heading3_\d\-\d|Heading\d)')]">
			<xsl:copy-of select="*[1]/*[matches(@class, '(Heading3_\d\-\d|Heading\d)')]" />
        </xsl:if>

		<xsl:choose>
			<xsl:when test="$count_img &gt; 0 and $count_img = count($cls_degn_pos)">
				<xsl:choose>
					<xsl:when test="$count_img = count($quad1_pos) and 
							  		count($quad1_pos) = count($cls_degn_pos) and 
					  				Cell[1]/following-sibling::Cell[1][not(node())]">
						<!-- count_img, quad1_pos, cls_degn_pos 전부 있고 첫번째 Cell 다음에 빈Cell 인 경우 -->
						<xsl:for-each select="node()[matches(@class, 'Cell_ImgCenter')][node()]">
							<xsl:variable name="current_pos" select="position()" />
							<xsl:element name="Table">
								<xsl:apply-templates select="ancestor::Table/@*" />

								<xsl:copy>
									<xsl:apply-templates select="@*, node()" />
								</xsl:copy>
								<xsl:if test="$cls_degn_pos[position() = $current_pos]">
									<xsl:apply-templates select="$cls_degn_pos[position() = $current_pos]/parent::*" />
								</xsl:if>

								<xsl:if test="$quad1_pos[position() = $current_pos]">
									<xsl:apply-templates select="$quad1_pos[position() = $current_pos]/parent::*" />
								</xsl:if>
							</xsl:element>
						</xsl:for-each>
					</xsl:when>

					<xsl:when test="$count_img = count($quad1_pos) and 
							  		count($quad1_pos) = count($cls_degn_pos) and 
					  				not(empty(Cell))">
						<!-- count_img, quad1_pos, cls_degn_pos 전부 있고 첫번째 Cell 다음에 빈Cell을 가지고 있지 않은 경우 -->
						
						<xsl:for-each select="node()[*[matches(@class, '^Img-Center$')]][node()]">
							<xsl:variable name="current_pos" select="position()" />
							<xsl:element name="Table">
								<xsl:apply-templates select="ancestor::Table/@*" />

								<xsl:copy>
									<xsl:apply-templates select="@*, node()" />
								</xsl:copy>

								<xsl:if test="$quad1_pos[position() = $current_pos]">
									<xsl:apply-templates select="$quad1_pos[position() = $current_pos]/parent::*" />
								</xsl:if>
								
								<xsl:if test="$cls_degn_pos[position() = $current_pos]">
									<xsl:apply-templates select="$cls_degn_pos[position() = $current_pos]/parent::*" />
								</xsl:if>
							</xsl:element>
						</xsl:for-each>
					</xsl:when>

					<xsl:when test="matches(@class, 'Table_Product_Quad') and 
					  				Cell[1]/following-sibling::Cell[1][not(node())]">
						
						<xsl:choose>
							<xsl:when test="count($quad1_pos) = 1">
								<xsl:for-each select="node()[matches(@class, 'Cell_ImgCenter')][node()]">
									<xsl:variable name="current_pos" select="position()" />

									<xsl:element name="Table">
										<xsl:apply-templates select="ancestor::Table/@*" />

										<xsl:copy>
											<xsl:apply-templates select="@*, node()" />
										</xsl:copy>
										
										<xsl:if test="$quad1_pos[position() = $current_pos]">
											<xsl:apply-templates select="$quad1_pos[position() = $current_pos]/parent::*" />
										</xsl:if>

										<xsl:if test="$cls_degn_pos[position() = $current_pos]">
											<xsl:apply-templates select="$cls_degn_pos[position() = $current_pos]/parent::*" />
										</xsl:if>
									</xsl:element>
								</xsl:for-each>
							</xsl:when>

							<xsl:when test="$count_img = count(descendant::p[matches(@class, '^Quad2$')]) and 
							  				count(descendant::p[matches(@class, '^Quad2$')]) = count($cls_degn_pos) and 
									  		Cell[1][matches(@class, 'Cell_ImgCenter')]/following-sibling::Cell[1][not(node())]">

								<xsl:for-each select="node()[matches(@class, 'Cell_ImgCenter')][node()]">
									<xsl:variable name="current_pos" select="position()" />

									<xsl:element name="Table">
										<xsl:apply-templates select="ancestor::Table/@*" />

										<xsl:copy>
											<xsl:apply-templates select="@*, node()" />
										</xsl:copy>

										<xsl:if test="$quad2_pos[position() = $current_pos]">
											<xsl:apply-templates select="$quad2_pos[position() = $current_pos]/parent::*" />
										</xsl:if>
										
										<xsl:if test="$cls_degn_pos[position() = $current_pos]">
											<xsl:apply-templates select="$cls_degn_pos[position() = $current_pos]/parent::*" />
										</xsl:if>
									</xsl:element>
								</xsl:for-each>
							</xsl:when>

							<xsl:otherwise>
								<!-- 이미지 및 Design_num 이 두개인 셀 인데 Cell 순서가 안맞는 Table -->
								<xsl:for-each select="node()[matches(@class, 'Cell_ImgCenter')][node()]">
									<xsl:variable name="current_pos" select="position()" />
									<xsl:element name="Table">
										<xsl:apply-templates select="ancestor::Table/@*" />

										<xsl:copy>
											<xsl:apply-templates select="@*, node()" />
										</xsl:copy>
										<xsl:if test="$cls_degn_pos[position() = $current_pos]">
											<xsl:apply-templates select="$cls_degn_pos[position() = $current_pos]/parent::*" />
										</xsl:if>
									</xsl:element>
								</xsl:for-each>
							</xsl:otherwise>
                        </xsl:choose>
					</xsl:when>

					<xsl:when test="matches(@class, 'Table_Product_Quad') and 
							  		Cell[not(node())]">
						
						<!--  이미지 및 Design_num 이 두개인 셀을 가지고 있는 Table -->
						<xsl:for-each-group select="node()" group-adjacent="boolean(self::Cell[not(node())])">
							<xsl:choose>
								<xsl:when test="current-group()[not(node())]">
                                </xsl:when>

								<xsl:otherwise>
									<xsl:element name="Table">
										<xsl:apply-templates select="ancestor::Table/@*" />
										<xsl:apply-templates select="current-group()" />
                                    </xsl:element>
                                </xsl:otherwise>
                        	</xsl:choose>
                        </xsl:for-each-group>
					</xsl:when>

					<xsl:when test="matches(@class, 'Table_Image_Text') and 
							  		count(Cell[1][Image]) = 1 and 
							  		Cell[2][ul][following-sibling::node()[1]/*[matches(@class, 'Design_num')]]">

						<xsl:for-each-group select="node()" group-starting-with="Cell[*[matches(@class, '^Img-Center$')]]">
							<xsl:choose>
								<xsl:when test="current-group()[*[matches(@class, '^Img-Center$')]]">
									<xsl:element name="Table">
										<xsl:apply-templates select="ancestor::Table/@*" />
										<xsl:attribute name="ul_split" select="'ul_split'" />
										<xsl:apply-templates select="current-group()" />
									</xsl:element>
								</xsl:when>

								<xsl:otherwise>
									<xsl:element name="Table">
										<xsl:apply-templates select="ancestor::Table/@*" />
										<xsl:apply-templates select="current-group()" />
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each-group>
					</xsl:when>

					<xsl:otherwise>
						<xsl:copy>
							<xsl:apply-templates select="@*, node()" />
						</xsl:copy>
					</xsl:otherwise>
				</xsl:choose>
            </xsl:when>

			<xsl:when test="$count_img &gt; 0 and 
					  		$count_img = count($quad1_pos) and 
					  		count($cls_degn_pos) = 1">
				<!-- quad1의 개수와 이미지 개수가 같고, Design_num이 1개
					 첫번째 Cell 다음 빈Cell이 있는 경우 -->
				<xsl:choose>
					<xsl:when test="Cell[1][matches(@class, 'Cell_ImgCenter')]/following-sibling::Cell[1][not(node())]">
						
						<xsl:for-each select="node()[matches(@class, 'Cell_ImgCenter')][node()]">
							<xsl:variable name="current_pos" select="position()" />

							<xsl:element name="Table">
								<xsl:apply-templates select="ancestor::Table/@*" />

								<xsl:copy>
									<xsl:apply-templates select="@*, node()" />
								</xsl:copy>
								<xsl:if test="$quad1_pos[position() = $current_pos]">
									<xsl:apply-templates select="$quad1_pos[position() = $current_pos]/parent::*" />
								</xsl:if>

								<xsl:if test="position() = last()">
									<xsl:apply-templates select="$cls_degn_pos/parent::*" />
								</xsl:if>
							</xsl:element>
						</xsl:for-each>
					</xsl:when>

					<xsl:when test="Cell[1][*[matches(@class, '^Quad1$')]]/following-sibling::Cell[1][*[matches(@class, '^Img-Center$')]]">
						<xsl:for-each select="node()[*[matches(@class, '^Quad1$')]][node()]">
							<xsl:variable name="current_pos" select="position()" />

							<xsl:element name="Table">
								<xsl:apply-templates select="ancestor::Table/@*" />

								<xsl:copy>
									<xsl:apply-templates select="@*, node()" />
								</xsl:copy>
								<xsl:if test="$img_pos[position() = $current_pos]">
									<xsl:apply-templates select="$img_pos[position() = $current_pos]/parent::*" />
								</xsl:if>

								<xsl:if test="position() = last()">
									<xsl:apply-templates select="$cls_degn_pos/parent::*" />
								</xsl:if>
							</xsl:element>
						</xsl:for-each>
					</xsl:when>

					<xsl:when test="Cell[not(node())]">
						<xsl:for-each-group select="node()" group-adjacent="boolean(self::Cell[not(node())])">
							<xsl:choose>
								<xsl:when test="current-group()[not(node())]">
								</xsl:when>

								<xsl:otherwise>
									<xsl:element name="Table">
										<xsl:apply-templates select="ancestor::Table/@*" />
										<xsl:apply-templates select="current-group()" />
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each-group>
                    </xsl:when>
				</xsl:choose>
			</xsl:when>

			<xsl:when test="$count_img &gt; 0 and 
					  		$count_img = count($quad1_pos)">
				<!-- quad1의 개수와 이미지 개수가 같고, Design_num이 1개
					 빈Cell이 있는 없는 경우 -->
				<xsl:for-each-group select="node()" group-starting-with="Cell[*[matches(@class, '^Quad1$')]]">
					<xsl:choose>
						<xsl:when test="current-group()[*[matches(@class, '^Quad1$')]]">
							<xsl:element name="Table">
								<xsl:apply-templates select="ancestor::Table/@*" />
								<xsl:apply-templates select="current-group()" />
							</xsl:element>
						</xsl:when>

						<xsl:otherwise>
							<xsl:element name="Table">
								<xsl:apply-templates select="ancestor::Table/@*" />
								<xsl:apply-templates select="current-group()" />
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each-group>
			</xsl:when>

			<xsl:when test="$count_img = 2 and 
					  		count($cls_degn_pos) = 1">
				<!-- 이미지2개 Design_num 1개만 존재하는 테이블 -->
				<xsl:for-each-group select="node()" group-starting-with="Cell[*[matches(@class, '^Img-Center$')]]">
					<xsl:choose>
						<xsl:when test="current-group()[*[matches(@class, '^Img-Center$')]]">
							<xsl:element name="Table">
								<xsl:apply-templates select="ancestor::Table/@*" />
								<xsl:apply-templates select="current-group()" />
							</xsl:element>
						</xsl:when>

						<xsl:otherwise>
							<xsl:element name="Table">
								<xsl:apply-templates select="ancestor::Table/@*" />
								<xsl:apply-templates select="current-group()" />
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each-group>
			</xsl:when>

			<xsl:when test="Cell[1][*[matches(@class, '^Quad1$')]] and 
					  		descendant::*[matches(@class, '^Quad2$')] and 
					  		Cell[not(node())]">

				<xsl:for-each-group select="node()" group-adjacent="boolean(self::Cell[not(node())])">
					<xsl:choose>
						<xsl:when test="current-group()[not(node())]">
						</xsl:when>

						<xsl:otherwise>
							<xsl:element name="Table">
								<xsl:apply-templates select="ancestor::Table/@*" />
								<xsl:apply-templates select="current-group()" />
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each-group>
			</xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="p">
		<xsl:choose>
			<xsl:when test="Table">
				<xsl:apply-templates />
            </xsl:when>

			<xsl:when test="span/Table">
				<xsl:apply-templates select="span/Table"/>
			</xsl:when>

			<xsl:when test="current()[matches(@class, 'Description_Cell_8.5pt_C')][*[matches(@class, 'C_Important')]] and 
					  		following-sibling::node()[1][matches(@class, 'Description_Cell_8.5pt_C')][*[matches(@class, 'C_Important')]]">
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
					<br/>
					<xsl:copy-of select="following-sibling::node()[1]/node()" />
            	</xsl:copy>
            </xsl:when>
			<xsl:when test="current()[matches(@class, 'Description_Cell_8.5pt_C')][*[matches(@class, 'C_Important')]] and 
					  		preceding-sibling::node()[1][matches(@class, 'Description_Cell_8.5pt_C')][*[matches(@class, 'C_Important')]]">
            </xsl:when>
			
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
	
</xsl:stylesheet>