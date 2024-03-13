<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ast="http://www.astkorea.net/"
	exclude-result-prefixes="xs ast"
    version="2.0">

	<xsl:variable name="LV_name" select="/CategoryData/@LV_name"/>
	<xsl:variable name="lang" select="tokenize(/*/@lang, '-')[1]"/>

	<xsl:output method="xml" version="1.0" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:strip-space elements="*" />
    <xsl:preserve-space elements="div li p cmd"/>

	<xsl:variable name="cr1" select="'&#xA;'" />
	<xsl:variable name="sp1" select="'&#x20;'" />
	<xsl:variable name="crt1" select="'&#xA;&#x9;'" />
	<xsl:variable name="crt2" select="'&#xA;&#x9;&#x9;'" />
	<xsl:variable name="crt3" select="'&#xA;&#x9;&#x9;&#x9;'" />
	<xsl:variable name="crt4" select="'&#xA;&#x9;&#x9;&#x9;&#x9;'" />
	<xsl:variable name="crt5" select="'&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;'" />
	<xsl:variable name="crt6" select="'&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;'" />
	<xsl:variable name="crt7" select="'&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;'" />
	<xsl:variable name="crt8" select="'&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;'" />
	<xsl:variable name="crt9" select="'&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;'" />

	<xsl:template match="/">
		<xsl:variable name="filename" select="concat('../../2_HTML/container/', $LV_name, '/start_here', '.html')" />
		<xsl:result-document href="{$filename}">
	    	<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
	    	<xsl:value-of select="$cr1" />
			<html lang="{$lang}">
				<xsl:value-of select="$crt1" />
				<head>
					<xsl:value-of select="$crt2" />
					<meta http-equiv="content-type" content="text/html; charset=utf-8" />
					<xsl:value-of select="$crt2" />
					<title>User Manual</title>
					<xsl:value-of select="$crt2" />
					<link rel="stylesheet" href="../../_common/stylesheets/720/LtoR/ViewerContent.css"/>
					<xsl:value-of select="$crt2" />
					<link rel="stylesheet" href="../_common/css/toc.css" />
					<xsl:value-of select="$crt2" />
					<script src="jsons/search.js"/>
					<xsl:value-of select="$crt2" />
					<script src="../_common/js/jquery.js" type="text/javascript"/>
					<xsl:value-of select="$crt2" />
					<script src="../_common/js/jquery.history.js" type="text/javascript"/>
					<xsl:value-of select="$crt2" />
					<script src="js/init.js" type="text/javascript"/>
					<xsl:value-of select="$crt1" />
				</head>
				<xsl:value-of select="$crt1" />
				<body>
					<xsl:value-of select="$crt2" />
					<div id="top">
						<xsl:value-of select="$crt3" />
						<img src="../_common/images/toc/header_logo.png" alt="e-manual" class="logo" />
						<xsl:value-of select="$crt3" />
						<div id="breadcrumbs"/>
						<xsl:value-of select="$crt2" />
					</div>
					
					<xsl:value-of select="$crt2" />
					<div id="container">
						<xsl:value-of select="$crt3" />
						<div id="navicontainer">
							<xsl:value-of select="$crt4" />
							<div id="navigationview">
								<xsl:value-of select="$crt5" />
								<div id="search_blank"/>
								<xsl:value-of select="$crt5" />
								<div id="toc">
									<xsl:value-of select="$crt6" />
									<h1 class="toc-chap icon_search">
										<xsl:value-of select="$crt7" />
										<span class="chapter_text">Search</span>
										<xsl:value-of select="$crt6" />
									</h1>
									<xsl:value-of select="$crt6" />
									<h1 class="toc-chap icon_index">
										<xsl:value-of select="$crt7" />
										<span class="chapter_text">Index</span>
										<xsl:value-of select="$crt6" />
									</h1>
									<xsl:value-of select="$crt6" />
									<h1 class="toc-chap icon_open">
										<xsl:value-of select="$crt7" />
										<span class="chapter_text">Opened page</span>
										<xsl:value-of select="$crt6" />
									</h1>

									<xsl:for-each select="/CategoryData/CategoryData/chapter">
										<xsl:if test="following-sibling::chapter">
											<xsl:value-of select="$crt6" />
											<h1 class="toc-chap icon_open">
												<xsl:value-of select="@title" />
												<xsl:value-of select="$crt7" />
												<ul class="toc-sect">
													<xsl:for-each select=".//page">
														<xsl:value-of select="$crt8" />
														<li>
															<xsl:value-of select="$crt9" />
															<a href="{concat('contents/', @url)}">
																<xsl:value-of select="@title" />
															</a>
															<xsl:value-of select="$crt8" />
														</li>
													</xsl:for-each>
													<xsl:value-of select="$crt7" />
												</ul>
												<xsl:value-of select="$crt6" />
											</h1>
										</xsl:if>
									</xsl:for-each>

									<xsl:value-of select="$crt5" />
								</div>
								<xsl:value-of select="$crt4" />
							</div>
							<xsl:value-of select="$crt4" />
							<div id="search_area">
								<xsl:value-of select="$crt5" />
								<div id="search-keyword">
									<xsl:value-of select="$crt6" />
									<input type="text" id="id_search" placeholder="Enter search keyword..." onKeyDown="fncSearchKeyDown(event.keyCode, this.value);" />
									<xsl:value-of select="$crt6" />
									<img id="id_search_button" src="../_common/images/toolbar/search.png" alt="search" onClick="fncDoSearch(); " />
									<xsl:value-of select="$crt6" />
									<img id="search-close-button" src="../_common/css/images/close.png" alt="close" />
									<xsl:value-of select="$crt5" />
								</div>
								<xsl:value-of select="$crt5" />
								<div id="id_results"/>
								<xsl:value-of select="$crt4" />
							</div>
							<xsl:value-of select="$crt3" />
						</div>
						<xsl:value-of select="$crt3" />
						<div id="content"/>
						<xsl:value-of select="$crt2" />
					</div>
					<xsl:value-of select="$crt2" />
					<script src="js/search.js"/>
					<xsl:value-of select="$crt2" />
					<script src="js/current.js"/>
					<xsl:value-of select="$crt1" />
				</body>
				<xsl:value-of select="$cr1" />
			</html>
		</xsl:result-document>
	</xsl:template>

</xsl:stylesheet>