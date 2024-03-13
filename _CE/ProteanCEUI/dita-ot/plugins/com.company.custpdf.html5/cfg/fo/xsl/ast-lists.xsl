<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <xsl:template match="*[contains(@class, ' topic/ul ')]/*[contains(@class, ' topic/li ')]">
        <xsl:variable name="depth" select="count(ancestor::*[contains(@class, ' topic/ul ')])"/>
        <xsl:choose>
        	<xsl:when test="not(preceding-sibling::li)">
		        <fo:list-item xsl:use-attribute-sets="ul.li.first">
		            <xsl:call-template name="commonattributes"/>
        			<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
        				<xsl:attribute name="break-before">page</xsl:attribute>
        			</xsl:if>
					<xsl:if test="parent::*[contains(@class, ' topic/ul ')]/@outputclass='pagebreak'">
        				<xsl:attribute name="break-before">page</xsl:attribute>
        			</xsl:if>
		            <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
		                <fo:block xsl:use-attribute-sets="ul.li__label__content">
		                	<xsl:choose>
		                		<xsl:when test="parent::*[contains(@class, ' topic/ul ')]/@outputclass='bullet:hyphen'">
				                    <xsl:call-template name="getVariable">
				                        <xsl:with-param name="id" select="'Unordered List bullet 2'"/>
				                    </xsl:call-template>
		                		</xsl:when>
		                		<xsl:otherwise>
				                    <xsl:call-template name="getVariable">
				                        <xsl:with-param name="id" select="concat('Unordered List bullet ', (($depth - 1) mod 4) + 1)"/>
				                    </xsl:call-template>
		                		</xsl:otherwise>
		                	</xsl:choose>
		                </fo:block>
		            </fo:list-item-label>
		            <fo:list-item-body xsl:use-attribute-sets="ul.li__body">
		                <fo:block xsl:use-attribute-sets="ul.li__content">
		                    <xsl:apply-templates select="node()" />
		                </fo:block>
		            </fo:list-item-body>
		        </fo:list-item>
        	</xsl:when>
        	<xsl:otherwise>
		        <fo:list-item xsl:use-attribute-sets="ul.li">
		            <xsl:call-template name="commonattributes"/>
        			<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
        				<xsl:attribute name="break-before">page</xsl:attribute>
        			</xsl:if>
					<xsl:if test="contains(@outputclass, 'pagebreak')">
        				<xsl:attribute name="break-before">page</xsl:attribute>
        			</xsl:if>
		            <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
		                <fo:block xsl:use-attribute-sets="ul.li__label__content">
		                	<xsl:choose>
		                		<xsl:when test="parent::*[contains(@class, ' topic/ul ')]/@outputclass='bullet:hyphen'">
				                    <xsl:call-template name="getVariable">
				                        <xsl:with-param name="id" select="'Unordered List bullet 2'"/>
				                    </xsl:call-template>
		                		</xsl:when>
		                		<xsl:otherwise>
				                    <xsl:call-template name="getVariable">
				                        <xsl:with-param name="id" select="concat('Unordered List bullet ', (($depth - 1) mod 4) + 1)"/>
				                    </xsl:call-template>
		                		</xsl:otherwise>
		                	</xsl:choose>
		                </fo:block>
		            </fo:list-item-label>
		            <fo:list-item-body xsl:use-attribute-sets="ul.li__body">
		                <fo:block xsl:use-attribute-sets="ul.li__content">
		                    <xsl:apply-templates select="node()" />
		                </fo:block>
		            </fo:list-item-body>
		        </fo:list-item>
        	</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/ol ')]/*[contains(@class, ' topic/li ')]">
        <xsl:variable name="depth" select="count(ancestor::*[contains(@class, ' topic/ol ')])"/>
        <xsl:variable name="format">
			<xsl:choose>
				<xsl:when test="parent::*[contains(@class, ' topic/ol ')]/@outputclass='suborderlist'">
					<xsl:call-template name="getVariable">
						<xsl:with-param name="id" select="concat('Sub Ordered List Format ', $depth)"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="getVariable">
						<xsl:with-param name="id" select="concat('Ordered List Format ', $depth)"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
        </xsl:variable>
        <xsl:choose>
        	<xsl:when test="not(preceding-sibling::li)">
		        <fo:list-item xsl:use-attribute-sets="ol.li.first">
		            <xsl:call-template name="commonattributes"/>
        			<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
        				<xsl:attribute name="break-before">page</xsl:attribute>
        			</xsl:if>
		            <fo:list-item-label xsl:use-attribute-sets="ol.li__label">
		            	<xsl:choose>
			            	<xsl:when test="contains(@class, ' task/stepsection ') and parent::*[contains(@class, ' task/steps ')][@outputclass='number:circle']">
				            </xsl:when>
			            	<xsl:otherwise>
				                <fo:block xsl:use-attribute-sets="ol.li__label__content">
									<xsl:choose>
										<xsl:when test="parent::*[contains(@class, ' topic/ol ')]/@outputclass='suborderlist'">
											<xsl:call-template name="getVariable">
												<xsl:with-param name="id" select="concat('Sub Ordered List Number ', $depth)"/>
												<xsl:with-param name="params" as="element()*">
												<number>
													<xsl:number format="{$format}"/>
												</number>
												</xsl:with-param>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="getVariable">
												<xsl:with-param name="id" select="concat('Ordered List Number ', $depth)"/>
												<xsl:with-param name="params" as="element()*">
												<number>
													<xsl:number format="{$format}"/>
												</number>
												</xsl:with-param>
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
				                </fo:block>
				            </xsl:otherwise>
				        </xsl:choose>
		            </fo:list-item-label>
		            <fo:list-item-body xsl:use-attribute-sets="ol.li__body">
		                <fo:block xsl:use-attribute-sets="ol.li__content">
		                    <xsl:apply-templates select="node()" />
		                </fo:block>
		            </fo:list-item-body>
		        </fo:list-item>
        	</xsl:when>
        	<xsl:otherwise>
		        <fo:list-item xsl:use-attribute-sets="ol.li">
		            <xsl:call-template name="commonattributes"/>
        			<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
        				<xsl:attribute name="break-before">page</xsl:attribute>
        			</xsl:if>
		            <fo:list-item-label xsl:use-attribute-sets="ol.li__label">
		                <fo:block xsl:use-attribute-sets="ol.li__label__content">
		                    <xsl:choose>
								<xsl:when test="parent::*[contains(@class, ' topic/ol ')]/@outputclass='suborderlist'">
									<xsl:call-template name="getVariable">
										<xsl:with-param name="id" select="concat('Sub Ordered List Number ', $depth)"/>
										<xsl:with-param name="params" as="element()*">
										<number>
											<xsl:number format="{$format}"/>
										</number>
										</xsl:with-param>
				                    </xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="getVariable">
										<xsl:with-param name="id" select="concat('Ordered List Number ', $depth)"/>
										<xsl:with-param name="params" as="element()*">
										<number>
											<xsl:number format="{$format}"/>
										</number>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
		                </fo:block>
		            </fo:list-item-label>
		            <fo:list-item-body xsl:use-attribute-sets="ol.li__body">
		                <fo:block xsl:use-attribute-sets="ol.li__content">
		                    <xsl:apply-templates select="node()" />
		                </fo:block>
		            </fo:list-item-body>
		        </fo:list-item>
        	</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/sl ')]/*[contains(@class, ' topic/sli ')]">
    	<xsl:choose>
    		<xsl:when test="not(preceding-sibling::sli)">
		        <fo:list-item xsl:use-attribute-sets="sl.sli.first">
		            <xsl:call-template name="commonattributes"/>
        			<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
        				<xsl:attribute name="break-before">page</xsl:attribute>
        			</xsl:if>
		            <fo:list-item-label xsl:use-attribute-sets="sl.sli__label">
		                <fo:block xsl:use-attribute-sets="sl.sli__label__content">
		                </fo:block>
		            </fo:list-item-label>
		            <fo:list-item-body xsl:use-attribute-sets="sl.sli__body">
		                <fo:block xsl:use-attribute-sets="sl.sli__content">
		                    <xsl:apply-templates/>
		                </fo:block>
		            </fo:list-item-body>
		        </fo:list-item>
    		</xsl:when>
    		<xsl:otherwise>
		        <fo:list-item xsl:use-attribute-sets="sl.sli">
		            <xsl:call-template name="commonattributes"/>
        			<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
        				<xsl:attribute name="break-before">page</xsl:attribute>
        			</xsl:if>
		            <fo:list-item-label xsl:use-attribute-sets="sl.sli__label">
		                <fo:block xsl:use-attribute-sets="sl.sli__label__content">
		                </fo:block>
		            </fo:list-item-label>
		            <fo:list-item-body xsl:use-attribute-sets="sl.sli__body">
		                <fo:block xsl:use-attribute-sets="sl.sli__content">
		                    <xsl:apply-templates/>
		                </fo:block>
		            </fo:list-item-body>
		        </fo:list-item>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/ul ')]">
        <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline"/>
		<xsl:if test="node()[2][self::processing-instruction('pagebreak')]">
			<fo:block break-before="page"/>
		</xsl:if>
        <fo:list-block xsl:use-attribute-sets="ul">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:list-block>
        <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/ol ')]">
        <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline"/>
		<xsl:if test="node()[2][self::processing-instruction('pagebreak')]">
			<fo:block break-before="page"/>
		</xsl:if>
        <fo:list-block xsl:use-attribute-sets="ol">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:list-block>
        <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/sl ')]">
        <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline"/>
		<xsl:if test="node()[2][self::processing-instruction('pagebreak')]">
			<fo:block break-before="page"/>
		</xsl:if>
        <fo:list-block xsl:use-attribute-sets="sl">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:list-block>
        <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline"/>
    </xsl:template>

</xsl:stylesheet>