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
	
	<xsl:template match="topic">
		<xsl:variable name="h2_id" select="h2/@id" />
		<xsl:result-document href="{concat('output/', @id, '.html')}">
			<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html></xsl:text>
			<xsl:text>&#xA;</xsl:text>
			<html>
				<xsl:apply-templates select="root()/body/@*" />
				<head>
					<meta charset="UTF-8" />
					<meta name="viewport" content="width=device-width, initial-scale=1" />
					<title>
						<xsl:value-of select="preceding-sibling::CHAPTER_TITLE" />
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
					<link href="css/RTL.css" rel="stylesheet" />
					<script src="js/searchLib.js">
						<xsl:text disable-output-escaping="yes">&amp; nbsp;</xsl:text>
					</script>
					<script>
						<xsl:text disable-output-escaping="yes">
						function searchClick() {
						MyApp_HighlightAllOccurencesOfString('the');
						}

						function goBack() {
						window.history.back();
						}</xsl:text>
					</script>
				</head>

				<body>
					<div id="page_wrap">
						<div class="page_in">
							<header>
								<h1>
									<xsl:value-of select="preceding-sibling::CHAPTER_TITLE" />
                                </h1>
                            </header>
							
							<xsl:if test="preceding-sibling::*[1][name()='insert_template']">
								<xsl:copy-of select="preceding-sibling::*[1][name()='insert_template']/node()" />
                            </xsl:if>
							<xsl:for-each select=".">
								<xsl:apply-templates />
							</xsl:for-each>
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

	
</xsl:stylesheet>