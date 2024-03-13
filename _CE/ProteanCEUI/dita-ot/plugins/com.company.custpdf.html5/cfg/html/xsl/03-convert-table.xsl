<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/"
    exclude-result-prefixes="xs ast"
    version="2.0">

  	<xsl:key name="targets" match="*[@id]" use="@id"/>
    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="div li p cmd"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="chapter/@title">
		<xsl:attribute name="title" select="if ( . = '' ) then parent::chapter/page[1]/@title else ."/>
	</xsl:template>

	<xsl:template match="chapter/@description">
		<xsl:attribute name="description" select="if ( . = '' ) then parent::chapter/page[1]/@description else ."/>
	</xsl:template>

	<xsl:template match="text()" priority="10">
		<xsl:choose>
			<xsl:when test="parent::p and not(following-sibling::node())">
				<xsl:value-of select="replace(., '\s+$', '')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="ol">
		<xsl:variable name="container" select="."/>
		<xsl:for-each-group select="*" group-adjacent="boolean(self::li)">
			<xsl:choose>
				<xsl:when test="current-grouping-key()">
					<ol>
						<xsl:if test="$container/@class='number-circle'">
							<xsl:attribute name="class">number-circle</xsl:attribute>
						</xsl:if>
						<xsl:if test="$container/@class='suborderlist'">
							<xsl:attribute name="class">suborderlist</xsl:attribute>
						</xsl:if>
						<xsl:if test="$container/preceding-sibling::ol[@class='number-circle']">
							<xsl:attribute name="start">
								<xsl:value-of select="count($container/preceding-sibling::ol[@class='number-circle']/li) + 1"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:apply-templates select="current-group()" />
					</ol>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="current-group()" mode="unwrap"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each-group>
	</xsl:template>

	<!--| from: unwrap processing -->
	<xsl:template match="ul[@class='none']" mode="unwrap">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="stepsection" mode="unwrap">
		<xsl:apply-templates select="node()" />
	</xsl:template>
	<!-- to: unwrap processing |-->

	<xsl:template match="entry/@x | entry/@y | entry/@colname">
	</xsl:template>

	<xsl:template match="table">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:choose>
				<xsl:when test="@class='Table_Remote-Text'">
					<xsl:attribute name="id">remoteTable</xsl:attribute>
				</xsl:when>
				<xsl:when test="@class='Table_Remote-Img'">
					<xsl:attribute name="id">remoteImg</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<xsl:apply-templates select="node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="table/@frame">
	</xsl:template>

	<xsl:template match="table/@class">
		<xsl:attribute name="class">
			<xsl:value-of select="lower-case(.)"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="colspec">
	</xsl:template>

	<xsl:template match="tgroup">
		<xsl:variable name="num" select="count(colspec)" />
		<xsl:for-each select="colspec">
			<col class="{concat('c', $num, '-', @colname)}" />
		</xsl:for-each>
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="thead | tbody">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="thead/row | tbody/row">
		<tr>
			<xsl:apply-templates select="@* | node()" />
		</tr>
	</xsl:template>

	<xsl:template match="entry">
		<td>
			<xsl:choose>
				<xsl:when test="ancestor::thead">
					<xsl:attribute name="class">tableheader</xsl:attribute>
				</xsl:when>
				<xsl:when test="not(ancestor::tgroup/thead) and not(ancestor::row/preceding-sibling::row) and ancestor::tgroup/colspec[@rowheader='headers']">
					<xsl:attribute name="class">tableheader</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<xsl:apply-templates select="@* | node()" />
		</td>
	</xsl:template>

	<xsl:template match="entry/@morerows">
		<xsl:attribute name="rowspan" select="xs:integer(.) + 1" />
	</xsl:template>

	<xsl:template match="entry/p[not(img)][string(.)='']">
	</xsl:template>

	<xsl:template match="img[starts-with(ast:getFile(@src, '/'), 'Smart_remote')]">
		<table class="table_remote-img" id="remoteImg">
			<col class="c1-col1" />
			<tr>
				<td>
					<xsl:copy>
						<xsl:apply-templates select="@* except @class"/>
					</xsl:copy>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template match="div[@class='heading1']">
		<xsl:copy>
			<xsl:attribute name="id" select="parent::page/@id" />
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="a[parent::span[@class='see-page']]">
		<xsl:variable name="target" select="key('targets', @href)[1]"/>
		<a>
			<xsl:attribute name="href" select="if ( name($target) = 'page' ) then concat($target/@url, '#', @href) else concat($target/ancestor::page/@url, '#', @href)"/>
			<xsl:apply-templates select="node()" />
		</a>
	</xsl:template>

	<xsl:template match="@btnidx">
		<xsl:variable name="idx" as="xs:integer">
			<xsl:number level="any" from="page" count="*[@btnidx]" format="1"/>
		</xsl:variable>
		<xsl:attribute name="btnidx" select="$idx - 1" />
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