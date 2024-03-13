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

	<xsl:variable name="modelname" select="body/@modelname" />

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
	
	<xsl:template match="/body">
		<xsl:variable name="index" select="concat('output/', 'index.html')" />
		<xsl:result-document href="{$index}">
			<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html></xsl:text>
			<xsl:text>&#xA;</xsl:text>
			<html>
				<xsl:apply-templates select="root()/body/@*" />
				<head>
					<meta charset="UTF-8" />
					<meta name="viewport" content="width=device-width, initial-scale=1" />
					<title>
						<xsl:value-of select="$modelname" />
					</title>

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
					<link href="css/common.css" rel="stylesheet" />
					<link href="css/index.css" rel="stylesheet" />
					<link href="css/RTL.css" rel="stylesheet" />

					<script src="js/searchLib.js">
						<xsl:text>&#xFEFF;</xsl:text>
					</script>
					<script src="js/jquery-1.8.3.min.js">
						<xsl:text>&#xFEFF;</xsl:text>
					</script>
					<script src="js/common.js">
						<xsl:text>&#xFEFF;</xsl:text>
					</script>
					<script>
						<xsl:text disable-output-escaping="yes">
						function searchClick()
						{
						MyApp_HighlightAllOccurencesOfString('the');
						}
						</xsl:text>
					</script>
				</head>

				<body>
					<xsl:comment>page_wrap</xsl:comment>
					<div id="page_wrap">
						<xsl:comment>page_in</xsl:comment>
						<div class="page_in">
							<section class="index">
								<article class="tableof">
									<div>
										<h2>
											<xsl:value-of select="$modelname" />
										</h2>
										<ol>
											<xsl:for-each select="chapter/CHAPTER_TITLE">
												<xsl:variable name="pos">
													<xsl:number from="body" count="CHAPTER_TITLE" level="any" format="01" />
												</xsl:variable>
												<li>
													<a href="{concat($pos, '.html')}">
														<xsl:text>&#x20;</xsl:text>
														<strong>
															<xsl:value-of select="." />
	                                                    </strong>
													</a>
												</li>
	                                        </xsl:for-each>
	                                    </ol>
									</div>
								</article>
							</section>
						</div>
					</div>
				</body>
			</html>
		</xsl:result-document>
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