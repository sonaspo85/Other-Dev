<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/"
    exclude-result-prefixes="xs ast"
    version="2.0">

	<xsl:variable name="style" select="document('debug-style.xml')" as="document-node()?"/>
	<xsl:variable name="LV_name" select="/CategoryData/@LV_name"/>
	<xsl:variable name="trynows" select="/CategoryData//span[starts-with(@class, 'C_TryNow')]"/>

    <xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="yes" byte-order-mark="no"/>
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="div li p cmd"/>

	<xsl:template match="/">
		<xsl:variable name="filename" select="concat('../../2_HTML/debugs/', $LV_name, '/', 'trynows.html')" />
		<xsl:result-document href="{$filename}">
			<html>
				<xsl:value-of select="ast:indent(1)" />
				<head>
					<xsl:value-of select="ast:indent(2)" />
					<style type="text/css">
						<xsl:apply-templates select="$style/style/node()"/>
						<xsl:value-of select="ast:indent(2)" />
					</style>
					<xsl:value-of select="ast:indent(1)" />
				</head>
				<xsl:value-of select="ast:indent(1)" />
				<body>
					<xsl:value-of select="ast:indent(2)" />
    				<p id="summary" data-check="trynow" path="{ast:getPath(base-uri(.))}">
    					<span id="true">&#x200B;</span>
						<span id="false">&#x200B;</span>
    				</p>
    				<xsl:value-of select="ast:indent(2)" />
    				<table id="table">
   						<xsl:value-of select="ast:indent(3)" />
    					<col width="300" />
   						<xsl:value-of select="ast:indent(3)" />
    					<col width="330" />
						<xsl:value-of select="ast:indent(3)" />
    					<col width="300" />
    					<xsl:value-of select="ast:indent(3)" />
    					<col width="100" style="text-align:center;" />
    					<xsl:value-of select="ast:indent(3)" />
    					<tr style="font-weight:bold;">
	    					<xsl:value-of select="ast:indent(4)" />
	    					<th>item</th>
	    					<xsl:value-of select="ast:indent(4)" />
	    					<th>anchor</th>
	    					<xsl:value-of select="ast:indent(4)" />
	    					<th>target</th>
	    					<xsl:value-of select="ast:indent(4)" />
	    					<th>exist</th>
    						<xsl:value-of select="ast:indent(3)" />
    					</tr>
    					<xsl:for-each select="$trynows">
							<xsl:variable name="href" select="concat(replace(ast:getPath(base-uri(.)), '\\debugs', ''), ancestor::page/@url)"/>
							<xsl:variable name="uri" select="concat('file:///', replace($href, '\\', '/'))"/>
							<xsl:variable name="id" select="@id"/>

    					    <xsl:value-of select="ast:indent(3)" />
    						<tr>
    							<xsl:value-of select="ast:indent(4)" />
    							<td>
    								<xsl:value-of select="@class"/>
    							</td>

    							<xsl:value-of select="ast:indent(4)" />
    							<td>
    								<xsl:value-of select="$id"/>
    							</td>

    							<xsl:value-of select="ast:indent(4)" />
    							<td>
    								<xsl:value-of select="ast:indent(5)" />
    								<a href="{concat($href, '#', $id)}">
    									<xsl:value-of select="ancestor::page/@url"/>
    								</a>
    								<xsl:value-of select="ast:indent(4)" />
    							</td>

    							<xsl:value-of select="ast:indent(4)" />
    							<td>
    								<xsl:choose>
    									<xsl:when test="doc-available($uri)">
    										<span class="true">true</span>
    									</xsl:when>
    									<xsl:otherwise>
											<span class="false" style="color:red">false</span>
    									</xsl:otherwise>
    								</xsl:choose>
    							</td>

    						    <xsl:value-of select="ast:indent(3)" />
    						</tr>
    					</xsl:for-each>
    					<xsl:value-of select="ast:indent(2)" />
    				</table>
					<xsl:value-of select="ast:indent(1)" />
				</body>
				<xsl:value-of select="ast:indent(1)" />
				<script>
					<xsl:value-of select="ast:indent(2)" />
					<xsl:text>document.getElementById("true").innerHTML = "trynow items = " + document.querySelectorAll('.true').length;</xsl:text>
					<xsl:value-of select="ast:indent(2)" />
					<xsl:text>document.getElementById("false").innerHTML = ", broken = " + document.querySelectorAll('.false').length;</xsl:text>
					<xsl:value-of select="ast:indent(1)" />
				</script>
				<xsl:text>&#xA;</xsl:text>
			</html>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:function name="ast:indent">
		<xsl:param name="depth" />
		<xsl:text>&#xA;</xsl:text>
		<xsl:for-each select="1 to $depth">
			<xsl:text>&#x9;</xsl:text>
		</xsl:for-each>
	</xsl:function>

	<xsl:function name="ast:getPath">
		<xsl:param name="str"/>
		<xsl:value-of select="replace(concat(substring-before(substring-after($str, 'file:/'), '/out/'), '/out/2_HTML/debugs/container/', $LV_name, '/contents/'), '/', '\\')" />
	</xsl:function>

</xsl:stylesheet>