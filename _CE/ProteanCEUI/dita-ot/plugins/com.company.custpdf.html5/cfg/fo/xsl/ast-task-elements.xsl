<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="opentopic opentopic-index dita2xslfo xs"
    version="2.0">

	<xsl:template match="*[contains(@class, ' task/cmd ')]" priority="1">
        <fo:block xsl:use-attribute-sets="cmd">
            <xsl:if test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">
            	<xsl:choose>
            		<xsl:when test="matches(substring-before($locale, '_'), 'ar|he|fa')">
            			<xsl:choose>
            				<xsl:when test="parent::*[contains(@class, ' task/step ')]">
            					<xsl:attribute name="margin-right" select="if ( parent::*[@outputclass='number:none'] ) then '0pt' else '2mm'"/>
            				</xsl:when>
							<!-- 200214 substeps outputclass="bullet" 일 경우 하위 목록의 인덴트 조정 -->
							<xsl:when test="ancestor::*[contains(@class, ' task/substeps ')][@outputclass='bullet']">
								<xsl:attribute name="margin-right">body-start()</xsl:attribute>
            				</xsl:when>
							<!-- 200214 위 경우를 제외하고 하위 목록의 인덴트 조정 -->
            				<xsl:otherwise>
            					<xsl:attribute name="margin-left">body-start()</xsl:attribute>
            				</xsl:otherwise>
            			</xsl:choose>
            		</xsl:when>
            		<xsl:otherwise>
            			<xsl:attribute name="margin-left" select="if ( parent::*[contains(@class, ' task/step ')]/@outputclass='number:none' ) then '0pt' else 'body-start()'"></xsl:attribute>
            		</xsl:otherwise>
            	</xsl:choose>
            </xsl:if>
            <xsl:call-template name="commonattributes"/>
            <xsl:if test="../@importance='optional'">
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Optional Step'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:if test="../@importance='required'">
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Required Step'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/steps ')]/*[contains(@class, ' task/step ')]">
        <xsl:variable name="format">
			<xsl:call-template name="getVariable">
				<xsl:with-param name="id" select="'Step Format'"/>
			</xsl:call-template>
        </xsl:variable>
        <fo:list-item xsl:use-attribute-sets="steps.step">
            <xsl:call-template name="commonattributes"/>
            <fo:list-item-label xsl:use-attribute-sets="steps.step__label">
				<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
					<xsl:attribute name="break-before">page</xsl:attribute>
				</xsl:if>
				<xsl:if test="contains(@outputclass, 'pagebreak')">
					<xsl:attribute name="break-before">page</xsl:attribute>
				</xsl:if>
                <fo:block xsl:use-attribute-sets="ast.step.number">
                    <xsl:if test="preceding-sibling::*[contains(@class, ' task/step ')] | following-sibling::*[contains(@class, ' task/step ')]">
                    	<xsl:choose>
                        	<xsl:when test="contains(@outputclass, 'number:none')">
		                        <xsl:call-template name="getVariable">
		                            <xsl:with-param name="id" select="'Step Number'"/>
		                            <xsl:with-param name="params" as="element()*">
		                                <number/>
	                            	</xsl:with-param>
	                            </xsl:call-template>
                            </xsl:when>
                        	<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">
		                        <xsl:call-template name="getVariable">
		                            <xsl:with-param name="id" select="'Step Number'"/>
		                            <xsl:with-param name="params" as="element()*">
		                            	<number>
			                            	<xsl:variable name="number" as="xs:integer">
			                                	<xsl:number format="{$format}" count="*[contains(@class, ' task/step ')][not(@outputclass='number:none')]"/>
			                                </xsl:variable>
			                                <xsl:choose>
			                                	<xsl:when test="$number &lt;= 9">
			                                		<xsl:value-of select="$number"/>
			                                	</xsl:when>
			                                	<xsl:when test="$number = 10">0</xsl:when>
			                                	<xsl:when test="$number = 11">!</xsl:when>
			                                	<xsl:when test="$number = 12">@</xsl:when>
			                                	<xsl:when test="$number = 13">#</xsl:when>
			                                	<xsl:when test="$number = 14">$</xsl:when>
			                                	<xsl:when test="$number = 15">%</xsl:when>
			                                	<xsl:when test="$number = 16">^</xsl:when>
			                                	<xsl:when test="$number = 17">&amp;</xsl:when>
			                                	<xsl:when test="$number = 18">*</xsl:when>
			                                	<xsl:when test="$number = 19">(</xsl:when>
			                                	<xsl:when test="$number = 20">)</xsl:when>
			                                </xsl:choose>
			                            </number>
			                        </xsl:with-param>
			                   	</xsl:call-template>
                           	</xsl:when>
		                    <xsl:otherwise>
			                    <xsl:call-template name="getVariable">
			                        <xsl:with-param name="id" select="'Step Number'"/>
			                        <xsl:with-param name="params" as="element()*">
			                           	<number>
		                            		<xsl:number format="{$format}" count="*[contains(@class, ' task/step ')][not(@outputclass='number:none')]"/>
		                            	</number>
		                            </xsl:with-param>
		                        </xsl:call-template>
		                    </xsl:otherwise>
		                </xsl:choose>
                    </xsl:if>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body xsl:use-attribute-sets="steps.step__body">
            	<xsl:if test="@outputclass='number:none'">
        			<xsl:choose>
        				<xsl:when test="matches(substring-before($locale, '_'), 'ar|he|fa')">
        					<xsl:attribute name="start-indent">0mm</xsl:attribute>
        				</xsl:when>
        				<xsl:otherwise>
        					<xsl:attribute name="start-indent">body-start()</xsl:attribute>
        				</xsl:otherwise>
        			</xsl:choose>
            	</xsl:if>
            	<xsl:choose>
            		<xsl:when test="ancestor::*[contains(@class, ' task/steps ')]/@outputclass='number:circle'">
		                <fo:block xsl:use-attribute-sets="ast.steps.step__content">
		                    <xsl:apply-templates select="node()" />
		                </fo:block>
            		</xsl:when>
            		<xsl:otherwise>
		                <fo:block xsl:use-attribute-sets="steps.step__content">
		                    <xsl:apply-templates select="node()" />
		                </fo:block>
            		</xsl:otherwise>
            	</xsl:choose>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>


	<xsl:template match="*[contains(@class, ' task/steps ')]" name="steps">
		<xsl:apply-templates select="." mode="dita2xslfo:task-heading">
			<xsl:with-param name="use-label">
				<xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
					<xsl:with-param name="pdf2-string">Task Steps</xsl:with-param>
					<xsl:with-param name="common-string">task_procedure</xsl:with-param>
				</xsl:apply-templates>
			</xsl:with-param>
		</xsl:apply-templates>
		<xsl:choose>
			<xsl:when test="count(*[contains(@class, ' task/step ')]) eq 1">
				<xsl:if test="node()[2][self::processing-instruction('pagebreak')]">
					<fo:block break-before="page"/>
				</xsl:if>
				<fo:block>
					<xsl:call-template name="commonattributes"/>
					<xsl:apply-templates mode="onestep"/>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<fo:list-block xsl:use-attribute-sets="steps">
					<xsl:call-template name="commonattributes"/>
					<xsl:apply-templates/>
				</fo:list-block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*[contains(@class, ' task/steps-unordered ')]" name="steps-unordered">
		<xsl:apply-templates select="." mode="dita2xslfo:task-heading">
			<xsl:with-param name="use-label">
				<xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
					<xsl:with-param name="pdf2-string">#steps-unordered-label</xsl:with-param>
					<xsl:with-param name="common-string">task_procedure_unordered</xsl:with-param>
				</xsl:apply-templates>
			</xsl:with-param>
		</xsl:apply-templates>
		<fo:list-block xsl:use-attribute-sets="steps-unordered">
			<xsl:call-template name="commonattributes"/>
			<xsl:apply-templates select="node()" />
		</fo:list-block>
	</xsl:template>

	<xsl:template match="*[contains(@class, ' task/stepsection ')]">
		<xsl:choose>
			<xsl:when test="parent::*[contains(@class, ' task/steps-unordered ')]">
			    <fo:list-item>
			        <xsl:call-template name="commonattributes"/>
			        <fo:list-item-label>
						<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
							<fo:block break-before="page"/>
						</xsl:if>
			        </fo:list-item-label>
			        <fo:list-item-body>
			            <fo:block>
			                <xsl:apply-templates/>
			            </fo:block>
			        </fo:list-item-body>
			    </fo:list-item>
			</xsl:when>
			<xsl:otherwise>
			    <fo:list-item xsl:use-attribute-sets="stepsection">
			        <xsl:call-template name="commonattributes"/>
			        <fo:list-item-label xsl:use-attribute-sets="stepsection__label">
						<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
							<fo:block break-before="page"/>
						</xsl:if>
						<fo:block xsl:use-attribute-sets="stepsection__label__content">
						</fo:block>
			        </fo:list-item-label>
			        <fo:list-item-body xsl:use-attribute-sets="stepsection__body">
			            <fo:block xsl:use-attribute-sets="stepsection__content">
			                <xsl:apply-templates/>
			            </fo:block>
			        </fo:list-item-body>
			    </fo:list-item>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

    <xsl:template match="*[contains(@class, ' task/substeps ')]/*[contains(@class, ' task/substep ')]">
        <xsl:variable name="format">
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Step Format'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
        	<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')]">
		        <fo:list-item xsl:use-attribute-sets="substeps.substep">
		            <xsl:call-template name="commonattributes"/>
		            <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
            			<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
            				<fo:block break-before="page"/>
            			</xsl:if>
						<xsl:if test="contains(@outputclass, 'pagebreak')">
							<xsl:attribute name="break-before">page</xsl:attribute>
						</xsl:if>
		                <fo:block xsl:use-attribute-sets="ul.li__label__content">
		                    <xsl:call-template name="getVariable">
		                        <xsl:with-param name="id" select="'Unordered List bullet 2'"/>
		                    </xsl:call-template>
		                </fo:block>
		            </fo:list-item-label>
		            <fo:list-item-body xsl:use-attribute-sets="ul.li__body">
		                <fo:block xsl:use-attribute-sets="ul.li__content">
		                    <xsl:apply-templates select="node()" />
		                </fo:block>
		            </fo:list-item-body>
		        </fo:list-item>
        	</xsl:when>
        	<xsl:when test="*[contains(@class, ' task/info ')] or parent::*[contains(@outputclass, 'bullet')]">
		        <fo:list-item xsl:use-attribute-sets="substeps.substep">
		            <xsl:call-template name="commonattributes"/>
		            <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
            			<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
            				<fo:block break-before="page"/>
            			</xsl:if>
						<xsl:if test="contains(@outputclass, 'pagebreak')">
							<fo:block break-before="page"/>
						</xsl:if>
		                <fo:block xsl:use-attribute-sets="ul.li__label__content">
		                    <xsl:call-template name="getVariable">
		                        <xsl:with-param name="id" select="'Unordered List bullet 1'"/>
		                    </xsl:call-template>
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
		        <fo:list-item xsl:use-attribute-sets="substeps.substep">
		            <xsl:call-template name="commonattributes"/>
		            <fo:list-item-label xsl:use-attribute-sets="substeps.substep__label">
            			<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
            				<fo:block break-before="page"/>
            			</xsl:if>
						<xsl:if test="contains(@outputclass, 'pagebreak')">
							<xsl:attribute name="break-before">page</xsl:attribute>
						</xsl:if>
		                <fo:block xsl:use-attribute-sets="substeps.substep__label__content">
		                    <xsl:call-template name="getVariable">
		                      <xsl:with-param name="id" select="'Step Number'"/>
		                      <xsl:with-param name="params" as="element()*">
		                        <number>
		                        	<xsl:number format="{$format}"/>
		                        </number>
		                      </xsl:with-param>
		                    </xsl:call-template>
		                </fo:block>
		            </fo:list-item-label>
		            <fo:list-item-body xsl:use-attribute-sets="substeps.substep__body">
		                <fo:block xsl:use-attribute-sets="ast.substeps.substep__content">
		                    <xsl:apply-templates select="node()" />
		                </fo:block>
		            </fo:list-item-body>
		        </fo:list-item>
        	</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/stepresult ')]">
		<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
			<fo:block break-before="page"/>
		</xsl:if>
        <fo:block xsl:use-attribute-sets="stepresult">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/result ')]">
		<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
			<fo:block break-before="page"/>
		</xsl:if>
        <fo:block xsl:use-attribute-sets="result">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                <xsl:with-param name="use-label">
                    <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                      <xsl:with-param name="pdf2-string">Task Result</xsl:with-param>
                      <xsl:with-param name="common-string">task_results</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:with-param>
            </xsl:apply-templates>
            <fo:block xsl:use-attribute-sets="result__content">
              <xsl:apply-templates/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/steps-unordered ')]/*[contains(@class, ' task/step ')]">
        <fo:list-item xsl:use-attribute-sets="steps-unordered.step">
            <xsl:call-template name="commonattributes"/>
            <fo:list-item-label xsl:use-attribute-sets="steps-unordered.step__label">
				<xsl:if test="preceding-sibling::node()[2][self::processing-instruction('pagebreak')]">
					<fo:block break-before="page"/>
				</xsl:if>
				<xsl:if test="contains(@outputclass, 'pagebreak')">
					<xsl:attribute name="break-before">page</xsl:attribute>
				</xsl:if>
                <fo:block xsl:use-attribute-sets="steps-unordered.step__label__content">
                	<xsl:choose>
                		<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')]/@outputclass='div-step'">
                		</xsl:when>
                		<xsl:otherwise>
		                    <xsl:call-template name="getVariable">
		                        <xsl:with-param name="id" select="'Unordered List bullet'"/>
		                    </xsl:call-template>
                		</xsl:otherwise>
                	</xsl:choose>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body xsl:use-attribute-sets="steps-unordered.step__body">
                <fo:block xsl:use-attribute-sets="steps-unordered.step__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

</xsl:stylesheet>
