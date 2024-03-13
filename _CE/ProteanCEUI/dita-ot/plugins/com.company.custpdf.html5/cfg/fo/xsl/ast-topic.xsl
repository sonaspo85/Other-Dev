<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
	xmlns:ast="http://www.astkorea.net/"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="dita-ot ot-placeholder opentopic opentopic-index opentopic-func dita2xslfo xs ast svg xlink"
    version="2.0">

	<xsl:template name="smart-ui-containter">
		<xsl:attribute name="background-repeat">no-repeat</xsl:attribute>
		<xsl:attribute name="background-position">center</xsl:attribute>
		<xsl:attribute name="space-before">6mm</xsl:attribute>
		<xsl:attribute name="space-after">6mm</xsl:attribute>
	</xsl:template>

	<xsl:template match="svg:svg" mode="convert">
		<xsl:param name="href"/>
		<fo:block>
			<xsl:attribute name="start-indent" select="concat((180 - xs:float(substring-before(svg:image/@width, 'mm'))) div 2, 'mm')"/>
			<fo:block-container border="0px solid green" width="{svg:image/@width}" height="{svg:image/@height}">
				<xsl:attribute name="background-image">
					<xsl:text>url('</xsl:text>
				 	<xsl:value-of select="replace($href, '\.svg', '.png')"/>
				 	<xsl:text>')</xsl:text>
				</xsl:attribute>
				<xsl:call-template name="smart-ui-containter"/>
				<xsl:for-each select="svg:g/svg:rect">
					<fo:block-container absolute-position="absolute">
						<xsl:attribute name="start-indent">0</xsl:attribute>
						<xsl:attribute name="end-indent">0</xsl:attribute>
						<xsl:attribute name="left" select="@x"/>
						<xsl:attribute name="top" select="@y"/>
						<xsl:attribute name="width" select="@width"/>
						<xsl:attribute name="height" select="@height"/>
						<xsl:attribute name="border">0px solid red</xsl:attribute>
						<xsl:attribute name="text-align" select="replace(following-sibling::svg:text/@text-anchor, 'middle', 'center')"/>
						<xsl:attribute name="wrap-option" select="following-sibling::svg:text/@ast:wrap-option"/>
						<xsl:attribute name="overflow" select="following-sibling::svg:text/@ast:overflow"/>
						<xsl:attribute name="display-align" select="following-sibling::svg:text/@ast:display-align"/>
						<!-- <fo:block>
							<xsl:attribute name="font-size" select="substring-after(tokenize(following-sibling::svg:text/@style, ';')[1], ':')"/>
							<xsl:attribute name="color" select="substring-after(tokenize(following-sibling::svg:text/@style, ';')[2], ':')"/>
							<xsl:attribute name="line-height">110%</xsl:attribute>
							<fo:inline>
								<xsl:value-of select="following-sibling::svg:text"/>
							</fo:inline>
						</fo:block> -->
						<fo:block>
							<xsl:choose>
								<xsl:when test="following-sibling::svg:text/@ast:direction">
									<xsl:attribute name="font-size" select="substring-after(tokenize(following-sibling::svg:text/@style, ';')[1], ':')"/>
									<xsl:attribute name="color" select="substring-after(tokenize(following-sibling::svg:text/@style, ';')[2], ':')"/>
									<xsl:attribute name="line-height">110%</xsl:attribute>
									<fo:bidi-override direction="ltr" unicode-bidi="bidi-override">
										<fo:inline>
											<xsl:value-of select="following-sibling::svg:text"/>
										</fo:inline>
									</fo:bidi-override>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="font-size" select="substring-after(tokenize(following-sibling::svg:text/@style, ';')[1], ':')"/>
									<xsl:attribute name="color" select="substring-after(tokenize(following-sibling::svg:text/@style, ';')[2], ':')"/>
									<xsl:attribute name="line-height">110%</xsl:attribute>
									<fo:inline>
										<xsl:value-of select="following-sibling::svg:text"/>
									</fo:inline>
								</xsl:otherwise>
							</xsl:choose>
						</fo:block>
					</fo:block-container>
				</xsl:for-each>
			</fo:block-container>
		</fo:block>
	</xsl:template>

    <xsl:template match="*[contains(@class,' topic/topic ')]/*[contains(@class,' topic/title ')]">
        <xsl:variable name="topicType" as="xs:string">
            <xsl:call-template name="determineTopicType"/>
        </xsl:variable>
        <xsl:choose>
            <!-- Disable chapter title processing when mini TOC is created -->
            <xsl:when test="(topicType = 'topicChapter') or (topicType = 'topicAppendix')" />
            <!-- Normal processing -->
            <xsl:otherwise>
            	<!-- from: added for final pagebreak touch by Sunhill -->
            	<xsl:variable name="id" select="parent::*[contains(@class, ' topic/topic ')]/@id" />
            	<xsl:if test="ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@outputclass='pagebreak'">
            		<fo:block break-after="page"/>
            	</xsl:if>
            	<!-- to: -->
                <xsl:apply-templates select="." mode="processTopicTitle"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*" mode="getTitle">
        <xsl:choose>
			<!-- add keycol here once implemented -->
            <xsl:when test="@spectitle">
                <xsl:value-of select="@spectitle"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="node()[not(contains(@class, ' pr-d/apiname '))]" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*" mode="processTopicTitle">
        <xsl:variable name="level" as="xs:integer">
          <xsl:apply-templates select="." mode="get-topic-level"/>
        </xsl:variable>
        <xsl:variable name="attrSet1">
            <xsl:apply-templates select="." mode="createTopicAttrsName">
                <xsl:with-param name="theCounter" select="$level"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:variable name="attrSet2" select="concat($attrSet1, '__content')"/>
        <fo:block>
        	<xsl:if test="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@otherprops='learn_the_menu_screen'">
        		<xsl:attribute name="id">learn_the_menu_screen</xsl:attribute>
        	</xsl:if>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="processAttrSetReflection">
                <xsl:with-param name="attrSet" select="$attrSet1"/>
                <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
            </xsl:call-template>
            <fo:block>
                <xsl:call-template name="processAttrSetReflection">
                    <xsl:with-param name="attrSet" select="$attrSet2"/>
                    <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
                </xsl:call-template>
                <xsl:if test="$level = 1">
                    <xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
                </xsl:if>
                <xsl:if test="$level = 2">
                    <xsl:apply-templates select="." mode="insertTopicHeaderMarker">
                      <xsl:with-param name="marker-class-name" as="xs:string">current-h2</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:if>
                <fo:wrapper id="{parent::node()/@id}"/>
                <fo:wrapper>
                    <xsl:attribute name="id">
                        <xsl:call-template name="generate-toc-id">
                            <xsl:with-param name="element" select=".."/>
                        </xsl:call-template>
                    </xsl:attribute>
                </fo:wrapper>
                <xsl:apply-templates select="." mode="customTopicAnchor"/>
                <xsl:call-template name="pullPrologIndexTerms"/>
                <xsl:apply-templates select="preceding-sibling::*[contains(@class,' ditaot-d/ditaval-startprop ')]"/>
                <xsl:apply-templates select="." mode="getTitle"/>
                <!-- Try Now는 변수 처리 -->
                <xsl:if test="*[contains(@class,' pr-d/apiname ')]">
                	<xsl:text>&#x20;</xsl:text>
                	<xsl:apply-templates select="*[contains(@class,' pr-d/apiname ')]"/>
                </xsl:if>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template match="*" mode="placeNoteContent">
        <fo:block xsl:use-attribute-sets="note">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class,' topic/image ')]" name="image">
        <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline"/>
        <xsl:choose>
            <xsl:when test="empty(@href)"/>
            <xsl:when test="@placement = 'break'">
            	<xsl:variable name="href">
					<xsl:choose>
						<xsl:when test="@scope = 'external' or opentopic-func:isAbsolute(@href)">
							<xsl:value-of select="@href"/>
						</xsl:when>
						<xsl:when test="exists(key('jobFile', @href, $job))">
							<xsl:value-of select="key('jobFile', @href, $job)/@src"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($input.dir.url, @href)"/>
						</xsl:otherwise>
					</xsl:choose>
		        </xsl:variable>

            	<xsl:choose>
            		<xsl:when test="starts-with(ast:getFile($href, '/'), 'smart-ui')">
            			<xsl:variable name="svg" select="document(replace($href, '\.svg', '_tmp.svg'))" as="document-node()"/>
            			<xsl:apply-templates select="$svg" mode="convert">
            				<xsl:with-param name="href" select="$href"/>
            			</xsl:apply-templates>
            		</xsl:when>
            		<xsl:otherwise>
		                <fo:block xsl:use-attribute-sets="image__block">
		                    <xsl:call-template name="commonattributes"/>
		                    <xsl:apply-templates select="." mode="placeImage">
		                        <!--<xsl:with-param name="imageAlign" select="if (@align) then @align else 'center'"/>-->
		                        <xsl:with-param name="href" select="$href"/>
		                        <xsl:with-param name="height" select="@height"/>
		                        <xsl:with-param name="width" select="@width"/>
		                    </xsl:apply-templates>
		                </fo:block>
            		</xsl:otherwise>
            	</xsl:choose>

                <xsl:if test="$artLabel='yes'">
                  <fo:block>
                    <xsl:apply-templates select="." mode="image.artlabel"/>
                  </fo:block>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline xsl:use-attribute-sets="image__inline">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates select="." mode="placeImage">
                        <xsl:with-param name="imageAlign" select="@align"/>
	                    <xsl:with-param name="href">
	                        <xsl:choose>
	                          <xsl:when test="@scope = 'external' or opentopic-func:isAbsolute(@href)">
	                            <xsl:value-of select="@href"/>
	                          </xsl:when>
	                          <xsl:when test="exists(key('jobFile', @href, $job))">
	                            <xsl:value-of select="key('jobFile', @href, $job)/@src"/>
	                          </xsl:when>
	                          <xsl:otherwise>
	                            <xsl:value-of select="concat($input.dir.url, @href)"/>
	                          </xsl:otherwise>
	                        </xsl:choose>
	                    </xsl:with-param>
                        <xsl:with-param name="height" select="@height"/>
                        <xsl:with-param name="width" select="@width"/>
                    </xsl:apply-templates>
                </fo:inline>
                <xsl:if test="$artLabel='yes'">
                  <xsl:apply-templates select="." mode="image.artlabel"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline"/>
    </xsl:template>

    <xsl:template match="*" mode="placeImage">
        <xsl:param name="imageAlign"/>
        <xsl:param name="href"/>
        <xsl:param name="height" as="xs:string?"/>
        <xsl:param name="width" as="xs:string?"/>
        <xsl:param name="scale" as="xs:string?">
            <xsl:choose>
                <xsl:when test="@scale"><xsl:value-of select="@scale"/></xsl:when>
                <xsl:when test="ancestor::*[@scale]"><xsl:value-of select="ancestor::*[@scale][1]/@scale"/></xsl:when>
            </xsl:choose>
        </xsl:param>
		<xsl:choose>
			<xsl:when test="not(@align)">
				<!--Testing whether image @align attribute is present-->
		        <xsl:call-template name="processAttrSetReflection">
		            <!--<xsl:with-param name="attrSet" select="concat('__align__', 'center')"/>-->
		            <xsl:with-param name="path" select="'../../cfg/fo/attrs/topic-attr.xsl'"/>
		        </xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!--Using align attribute set according to image @align attribute-->
		        <xsl:call-template name="processAttrSetReflection">
		            <xsl:with-param name="attrSet" select="concat('__align__', $imageAlign)"/>
		            <xsl:with-param name="path" select="'../../cfg/fo/attrs/topic-attr.xsl'"/>
		        </xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
        <xsl:choose>
        	<xsl:when test="@placement = 'break'">
		        <fo:external-graphic src="url('{$href}')" xsl:use-attribute-sets="image__block">
		            <xsl:if test="$height">
		                <xsl:attribute name="content-height">
		                    <xsl:choose>
		                      <xsl:when test="not(string(number($height)) = 'NaN')">
		                        <xsl:value-of select="concat($height, 'px')"/>
		                      </xsl:when>
		                      <xsl:otherwise>
		                        <xsl:value-of select="$height"/>
		                      </xsl:otherwise>
		                    </xsl:choose>
		                </xsl:attribute>
		            </xsl:if>
		            <xsl:if test="$width">
		                <xsl:attribute name="content-width">
		                    <xsl:choose>
		                      <xsl:when test="not(string(number($width)) = 'NaN')">
		                        <xsl:value-of select="concat($width, 'px')"/>
		                      </xsl:when>
		                      <xsl:otherwise>
		                        <xsl:value-of select="$width"/>
		                      </xsl:otherwise>
		                    </xsl:choose>
		                </xsl:attribute>
		            </xsl:if>
		            <xsl:if test="not($width) and not($height) and $scale">
		                <xsl:attribute name="content-width">
		                    <xsl:value-of select="concat($scale,'%')"/>
		                </xsl:attribute>
		            </xsl:if>
		          <xsl:if test="@scalefit = 'yes' and not($width) and not($height) and not($scale)">
		            <xsl:attribute name="width">100%</xsl:attribute>
		            <xsl:attribute name="height">100%</xsl:attribute>
		            <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
		            <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
		            <xsl:attribute name="scaling">uniform</xsl:attribute>
		          </xsl:if>
		          <xsl:choose>
		            <xsl:when test="*[contains(@class,' topic/alt ')]">
		              <xsl:apply-templates select="*[contains(@class,' topic/alt ')]" mode="graphicAlternateText"/>
		            </xsl:when>
		            <xsl:when test="@alt">
		              <xsl:apply-templates select="@alt" mode="graphicAlternateText"/>
		            </xsl:when>
		          </xsl:choose>
		          <xsl:apply-templates select="node() except (text(), *[contains(@class, ' topic/alt ') or contains(@class, ' topic/longdescref ')])"/>
		        </fo:external-graphic>
        	</xsl:when>
        	<xsl:otherwise>
		        <fo:external-graphic src="url('{$href}')" xsl:use-attribute-sets="image__inline">
		            <xsl:attribute name="vertical-align">middle</xsl:attribute>
		            <xsl:if test="$height">
		                <xsl:attribute name="content-height">
		                    <xsl:choose>
		                      <xsl:when test="not(string(number($height)) = 'NaN')">
		                        <xsl:value-of select="concat($height, 'px')"/>
		                      </xsl:when>
		                      <xsl:otherwise>
		                        <xsl:value-of select="$height"/>
		                      </xsl:otherwise>
		                    </xsl:choose>
		                </xsl:attribute>
		            </xsl:if>
		            <xsl:if test="$width">
		                <xsl:attribute name="content-width">
		                    <xsl:choose>
		                      <xsl:when test="not(string(number($width)) = 'NaN')">
		                        <xsl:value-of select="concat($width, 'px')"/>
		                      </xsl:when>
		                      <xsl:otherwise>
		                        <xsl:value-of select="$width"/>
		                      </xsl:otherwise>
		                    </xsl:choose>
		                </xsl:attribute>
		            </xsl:if>
		            <xsl:choose>
			            <xsl:when test="not($width) and not($height) and $scale">
			                <xsl:attribute name="content-width">
			                    <xsl:value-of select="concat($scale,'%')"/>
			                </xsl:attribute>
			            </xsl:when>
			            <xsl:when test="ancestor::*[contains(@class,' topic/entry ')] and starts-with(ast:getFile($href, '/'), 'btn')">
				            <xsl:attribute name="content-width">100%</xsl:attribute>
				            <xsl:attribute name="content-height">100%</xsl:attribute>
				            <xsl:attribute name="scaling">uniform</xsl:attribute>
							<xsl:attribute name="scaling">uniform</xsl:attribute>
			          	</xsl:when>
			            <xsl:when test="ancestor::*[contains(@class,' topic/entry ')] and starts-with(ast:getFile($href, '/'), 'ico_num')">
				            <xsl:attribute name="content-width">145%</xsl:attribute>
				            <xsl:attribute name="content-height">145%</xsl:attribute>
				            <xsl:attribute name="scaling">uniform</xsl:attribute>
							<xsl:attribute name="scaling">uniform</xsl:attribute>
			          	</xsl:when>
			            <xsl:when test="@scalefit = 'yes' and not($width) and not($height) and not($scale)">
				            <xsl:attribute name="width">100%</xsl:attribute>
				            <xsl:attribute name="height">100%</xsl:attribute>
				            <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
				            <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
				            <xsl:attribute name="scaling">uniform</xsl:attribute>
			          	</xsl:when>
			        </xsl:choose>
			        <xsl:attribute name="padding-top">
						<xsl:choose>
							<xsl:when test="ancestor::*[contains(@class,' topic/entry ')] and starts-with(ast:getFile($href, '/'), 'btn')">-2pt</xsl:when>
							<xsl:when test="starts-with(ast:getFile($href, '/'), 'btn')">-4pt</xsl:when>
							<xsl:when test="starts-with(ast:getFile($href, '/'), 'ico')">-2pt</xsl:when>
							<xsl:otherwise>0pt</xsl:otherwise>
						</xsl:choose>
			        </xsl:attribute>
					<xsl:choose>
						<xsl:when test="*[contains(@class,' topic/alt ')]">
							<xsl:apply-templates select="*[contains(@class,' topic/alt ')]" mode="graphicAlternateText"/>
						</xsl:when>
						<xsl:when test="@alt">
							<xsl:apply-templates select="@alt" mode="graphicAlternateText"/>
						</xsl:when>
					</xsl:choose>
		          	<xsl:apply-templates select="node() except (text(), *[contains(@class, ' topic/alt ') or contains(@class, ' topic/longdescref ')])"/>
		        </fo:external-graphic>
        	</xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="*[contains(@class,' topic/shortdesc ')]">
        <xsl:variable name="format-as-block" as="xs:boolean" select="dita-ot:formatShortdescAsBlock(.)"/>
        <xsl:choose>
            <xsl:when test="parent::abstract/parent::*[contains(@class, ' topic/topic ')]">
                <xsl:apply-templates select="." mode="format-shortdesc-as-block"/>
            </xsl:when>
            <xsl:when test="$format-as-block">
                <xsl:apply-templates select="." mode="format-shortdesc-as-block"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="format-shortdesc-as-inline"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*" mode="format-shortdesc-as-block">
    	<xsl:choose>
    		<xsl:when test="parent::abstract/parent::concept/parent::map">
    			<!-- vertical line as chapter signal -->
				<fo:block-container position="absolute" top="0mm">
					<xsl:choose>
						<xsl:when test="matches(substring-before($locale, '_'), 'ar|he|fa')">
							<xsl:attribute name="left">1.5mm</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="left">1.5mm</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<fo:block padding-top="14mm">
						<xsl:choose>
							<xsl:when test="matches(substring-before($locale, '_'), 'ar|he|fa')">
 								<xsl:attribute name="border-right">1.5mm solid cmyk(0%,0%,0%,30%)</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
 								<xsl:attribute name="border-left">1.5mm solid cmyk(0%,0%,0%,30%)</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text>
					</fo:block>
				</fo:block-container>
		        <!--compare the length of shortdesc with the got max chars-->
		        <fo:block xsl:use-attribute-sets="topic__shortdesc ast-shortdesc-spacing">
		            <xsl:call-template name="commonattributes"/>
		            <!-- If the shortdesc is sufficiently short, add keep-with-next. -->
		            <xsl:if test="string-length(.) lt $maxCharsInShortDesc">
		                <!-- Low-strength keep to avoid conflict with keeps on titles. -->
		                <xsl:attribute name="keep-with-next.within-page">5</xsl:attribute>
		            </xsl:if>
		            <xsl:if test="parent::*[contains(@class,' topic/abstract ')]">
		                <xsl:attribute name="start-indent">from-parent(start-indent)</xsl:attribute>
		            </xsl:if>
		            <xsl:if test="parent::abstract/parent::concept/parent::map">
		                <xsl:attribute name="start-indent">4mm</xsl:attribute>
		            </xsl:if>
					<xsl:apply-templates select="." mode="format-shortdesc-as-inline"/>
		        </fo:block>
    		</xsl:when>
    		<xsl:otherwise>
		        <!--compare the length of shortdesc with the got max chars-->
		        <fo:block xsl:use-attribute-sets="topic__shortdesc ast-shortdesc-spacing">
		            <xsl:call-template name="commonattributes"/>
		            <!-- If the shortdesc is sufficiently short, add keep-with-next. -->
		            <xsl:if test="string-length(.) lt $maxCharsInShortDesc">
		                <!-- Low-strength keep to avoid conflict with keeps on titles. -->
		                <xsl:attribute name="keep-with-next.within-page">5</xsl:attribute>
		            </xsl:if>
		            <xsl:if test="parent::*[contains(@class,' topic/abstract ')]">
		                <xsl:attribute name="start-indent">from-parent(start-indent)</xsl:attribute>
		            </xsl:if>
					<xsl:apply-templates select="." mode="format-shortdesc-as-inline"/>
		        </fo:block>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

    <xsl:template match="*" mode="format-shortdesc-as-inline">
    	<xsl:choose>
    		<xsl:when test="parent::abstract/preceding-sibling::title/@outputclass='Subchapter'">
		        <fo:inline xsl:use-attribute-sets="shortdesc">
		            <xsl:call-template name="commonattributes"/>
		            <xsl:if test="preceding-sibling::* | preceding-sibling::text()">
		                <xsl:text> </xsl:text>
		            </xsl:if>
		            <xsl:apply-templates/>
		        </fo:inline>
    		</xsl:when>
    		<xsl:when test="parent::abstract/parent::concept/parent::map">
		        <fo:inline xsl:use-attribute-sets="shortdesc">
		            <xsl:call-template name="commonattributes"/>
		            <xsl:if test="preceding-sibling::* | preceding-sibling::text()">
		                <xsl:text> </xsl:text>
		            </xsl:if>
		            <xsl:apply-templates/>
		        </fo:inline>
    		</xsl:when>
    		<xsl:otherwise>
		        <fo:inline xsl:use-attribute-sets="ast-shortdesc-highlight">
		            <xsl:call-template name="commonattributes"/>
		            <xsl:if test="preceding-sibling::* | preceding-sibling::text()">
		                <xsl:text> </xsl:text>
		            </xsl:if>
		            <xsl:apply-templates/>
		        </fo:inline>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class,' topic/note ')]">
        <xsl:variable name="noteImagePath">
            <xsl:apply-templates select="." mode="setNoteImagePath"/>
        </xsl:variable>
		<xsl:variable name="id" select="ancestor::*[contains(@class, ' topic/topic ')]/@id" />
		<xsl:choose>
			<xsl:when test="@props = 'remote_reference' and 
							not(ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@props)">
			</xsl:when>
			<xsl:otherwise>
		        <xsl:choose>
		            <xsl:when test="not($noteImagePath = '')">
		                <fo:table xsl:use-attribute-sets="note__table">
		                    <fo:table-column xsl:use-attribute-sets="note__image__column"/>
		                    <fo:table-column xsl:use-attribute-sets="note__text__column"/>
		                    <fo:table-body>
		                        <fo:table-row>
		                            <fo:table-cell xsl:use-attribute-sets="note__image__entry">
		                            	<xsl:if test="parent::*[contains(@class, ' topic/entry ')]">
		                            		<xsl:attribute name="display-align">before</xsl:attribute>
		                            	</xsl:if>
		                                <fo:block>
		                                    <fo:external-graphic src="url('{concat($artworkPrefix, $noteImagePath)}')" content-height="9pt" xsl:use-attribute-sets="image"/>
		                                </fo:block>
		                            </fo:table-cell>
		                            <fo:table-cell xsl:use-attribute-sets="note__text__entry">
		                                <xsl:apply-templates select="." mode="placeNoteContent"/>
		                            </fo:table-cell>
		                        </fo:table-row>
		                    </fo:table-body>
		                </fo:table>
		            </xsl:when>
		            <xsl:otherwise>
		                <xsl:apply-templates select="." mode="placeNoteContent"/>
		            </xsl:otherwise>
		        </xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class,' topic/abstract ')]">
    	<xsl:choose>
			<!-- <xsl:when test="count(*) = 1 and *[contains(@class, ' topic/note ')][@type='note'][@product='html']">
    		</xsl:when> -->
    		<xsl:when test="count(*) = 1 and *[contains(@class, ' topic/note ')][@type='warning']">
		        <fo:block xsl:use-attribute-sets="ast-warning">
		            <xsl:call-template name="commonattributes"/>
		            <xsl:apply-templates/>
		        </fo:block>
    		</xsl:when>
    		<xsl:otherwise>
		        <fo:block xsl:use-attribute-sets="abstract">
		            <xsl:call-template name="commonattributes"/>
		            <xsl:apply-templates/>
		        </fo:block>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/p ')]">
		<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
			<fo:block break-after="page"/>
		</xsl:if>
    	<xsl:choose>
    		<xsl:when test="parent::*[contains(@class, ' topic/entry ')] and count(parent::*[contains(@class, ' topic/entry ')]/*) = 1">
		        <fo:block xsl:use-attribute-sets="ast.table.cell">
		            <xsl:call-template name="commonattributes"/>
					<xsl:if test="@outputclass='align-left'">
		            	<xsl:attribute name="text-align">start</xsl:attribute>
		            </xsl:if>
		            <xsl:apply-templates/>
		        </fo:block>
    		</xsl:when>
    		<xsl:when test="count(*) = 1 and *[contains(@class, ' topic/image ')][@placement='break']">
    		    <xsl:apply-templates/>
    		</xsl:when>
    		<xsl:otherwise>
		        <fo:block xsl:use-attribute-sets="p">
		            <xsl:call-template name="commonattributes"/>
					<xsl:if test="@outputclass='align-left'">
		            	<xsl:attribute name="text-align">start</xsl:attribute>
		            </xsl:if>
		            <xsl:if test="@outputclass='menu'">
		            	<xsl:attribute name="font-size">12pt</xsl:attribute>
		            </xsl:if>
					<xsl:if test="@dir='ltr'">
		            	<xsl:attribute name="text-align">
							<xsl:value-of select="if ( matches(substring-before($locale, '_'), 'ar|fa|he') ) then 'end' else 'start'"/>
						</xsl:attribute>
						<xsl:attribute name="direction">ltr</xsl:attribute>
		            </xsl:if>
		            <xsl:apply-templates/>
		        </fo:block>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

	<xsl:template match="*" mode="inlineTextOptionalKeyref">
		<xsl:param name="copyAttributes" as="element()?"/>
		<xsl:param name="keys" select="@keyref" as="attribute()?"/>
		<xsl:param name="contents" as="node()*">
			<!-- Current node can be preprocessed and may not be part of source document, check for root() to ensure key() is resolvable -->
			<xsl:variable name="target" select="if (exists(root()) and @href) then key('id', substring(@href, 2)) else ()" as="element()?"/>
			<xsl:choose>
				<xsl:when test="not(normalize-space(.)) and $keys and $target/self::*[contains(@class,' topic/topic ')]">
					<xsl:apply-templates select="$target/*[contains(@class, ' topic/title ')]/node()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:variable name="topicref" select="key('map-id', substring(@href, 2))"/>
		<xsl:choose>
			<xsl:when test="$keys and @href and not($topicref/ancestor-or-self::*[@linking][1]/@linking = ('none', 'sourceonly'))">
				<fo:basic-link xsl:use-attribute-sets="xref">
					<xsl:sequence select="$copyAttributes/@*"/>
					<xsl:call-template name="commonattributes"/>
					<xsl:call-template name="buildBasicLinkDestination"/>
					<xsl:copy-of select="$contents"/>
				</fo:basic-link>
			</xsl:when>
			<xsl:when test="matches(substring-before($locale, '_'), 'ar|he|fa') and ( @dir = 'ltr' or contains(., 'Anynet+') or matches(., '\d+\s*x\s*\d+') )">
				<fo:bidi-override direction="ltr" unicode-bidi="bidi-override">
					<fo:inline>
						<xsl:sequence select="$copyAttributes/@*"/>
						<xsl:call-template name="commonattributes"/>
						<xsl:attribute name="wrap-option">no-wrap</xsl:attribute>
						<xsl:copy-of select="$contents"/>
					</fo:inline>
				</fo:bidi-override>
			</xsl:when>
			<xsl:when test="matches(substring-before($locale, '_'), 'ar|he|fa') and ( @outputclass = 'no-trans-wrap' )">
				<fo:bidi-override direction="ltr" unicode-bidi="bidi-override">
					<fo:inline>
						<xsl:sequence select="$copyAttributes/@*"/>
						<xsl:call-template name="commonattributes"/>
						<xsl:attribute name="wrap-option">wrap</xsl:attribute>
						<xsl:copy-of select="$contents"/>
					</fo:inline>
				</fo:bidi-override>
			</xsl:when>
			<xsl:when test="matches(substring-before($locale, '_'), 'ar|he|fa') and ( @outputclass = 'no-trans' )">
				<fo:bidi-override direction="ltr" unicode-bidi="bidi-override">
					<fo:inline>
						<xsl:sequence select="$copyAttributes/@*"/>
						<xsl:call-template name="commonattributes"/>
						<xsl:attribute name="wrap-option">no-wrap</xsl:attribute>
						<xsl:copy-of select="$contents"/>
					</fo:inline>
				</fo:bidi-override>
			</xsl:when>
			<xsl:otherwise>
				<fo:inline>
					<xsl:sequence select="$copyAttributes/@*"/>
					<xsl:call-template name="commonattributes"/>
					<xsl:copy-of select="$contents"/>
				</fo:inline>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:function name="ast:getPath">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], '/')" />
	</xsl:function>

	<xsl:function name="ast:getFile">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="tokenize($str, $char)[last()]" />
	</xsl:function>

</xsl:stylesheet>