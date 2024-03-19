<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	<xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="*">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*">
		<xsl:attribute name="{local-name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>
	
	<xsl:template match="chapter">
		<xsl:variable name="numbering">
			<xsl:for-each select="CHAPTER_TITLE">
				<xsl:number from="body" count="CHAPTER_TITLE" level="any" format="01" />
            </xsl:for-each>
        </xsl:variable>
		<xsl:variable name="filename" select="concat('../output/', $numbering)" />
		
		<xsl:result-document href="{concat($filename, '.html')}">
			<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html></xsl:text>
			<xsl:text>&#xA;</xsl:text>
			<html>
				<xsl:apply-templates select="root()/body/@*" />
				<head>
					<meta charset="UTF-8" />
					<meta name="viewport" content="width=device-width, initial-scale=1" />
					<title>
						<xsl:value-of select="CHAPTER_TITLE" />   <!--  chapter title  -->
					</title>
					<html5 />

					<xsl:choose>
						<xsl:when test="root()/body[matches(@cartype, 'genesis')]">
							<link href="fonts/genesis/stylesheet.css" rel="stylesheet" />
	                    </xsl:when>
						<xsl:otherwise>
							<link href="fonts/hyundai/stylesheet.css" rel="stylesheet" />
                        </xsl:otherwise>
                    </xsl:choose>
					<link href="fonts/adobeArabic_R/stylesheet.css" rel="stylesheet" />
					<link href="fonts/MCS_QudsS_U_normal/stylesheet.css" rel="stylesheet" />
					<link href="css/html5Reset.css" rel="stylesheet" />
					<link href="css/basic.css" rel="stylesheet" />
					<link href="css/index.css" rel="stylesheet" />
					<link href="css/common.css" rel="stylesheet" />
					<link href="css/RTL.css" rel="stylesheet" />
					<ie8 />

					<script src="js/searchLib.js">
						<xsl:text disable-output-escaping="yes">&amp; nbsp;</xsl:text>
					</script>
					<script src="js/jquery-1.8.3.min.js">
						<xsl:text disable-output-escaping="yes">&amp; nbsp;</xsl:text>
					</script>
					<script src="js/common.js">
						<xsl:text disable-output-escaping="yes">&amp; nbsp;</xsl:text>
					</script>

					<script>
						<xsl:text disable-output-escaping="yes">function searchClick() {
						MyApp_HighlightAllOccurencesOfString('the');
						}</xsl:text>
					</script>
					<scripts />
				</head>

				<body>
					<page-wrap />
					<div id="page_wrap" class="">
						<page-in />
						<div class="tableOfContents">
							<header>
								<h1>
									<xsl:value-of select="CHAPTER_TITLE" />
								</h1>
							</header>
							
							<section>
								<article>
									<ol class="l2">
										<xsl:for-each select="topic/h2">
											<xsl:variable name="cur" select="parent::*" />
											<li>
												<a href="#none" class="icon">
													<i>open/close</i>
												</a>
												<a href="{concat(@id, '.html')}">
													<xsl:value-of select="." />
												</a>
												
												<xsl:call-template name="h3_insert">
													<xsl:with-param name="cur" select="$cur" />
													<xsl:with-param name="h2_id" select="@id" />
                                                </xsl:call-template>
											</li>
                                        </xsl:for-each>
									</ol>
                                </article>
                            </section>
						</div>
						<page-in-close />
					</div>
					<page-wrap-close />
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>

	<xsl:template name="h3_insert">
		<xsl:param name="cur" />
		<xsl:param name="h2_id" />

		<xsl:if test="$cur/h3">
			<ol class="l3">
				<xsl:for-each select="$cur/h3">
					<li>
						<a href="{concat($h2_id, '.html', '#', @id)}">
							<xsl:text>•&#x20;</xsl:text>
							<xsl:value-of select="." />
						</a>
					</li>
				</xsl:for-each>
			</ol>
		</xsl:if>
    </xsl:template>

	<xsl:function name="son:getpath">
		<xsl:param name="arg1" />
		<xsl:param name="arg2" />
		<xsl:value-of select="string-join(tokenize($arg1, $arg2)[position() ne last()], $arg2)" />
	</xsl:function>

	<xsl:function name="son:last">
		<xsl:param name="arg1" />
		<xsl:param name="arg2" />
		<xsl:value-of select="tokenize($arg1, $arg2)[last()]" />
	</xsl:function>

	<xsl:function name="son:normalize">
		<xsl:param name="value" />
		<xsl:value-of select="replace(normalize-space($value), '[!@#$%&amp;();:.,]+', '')" />
    </xsl:function>
	
</xsl:stylesheet>