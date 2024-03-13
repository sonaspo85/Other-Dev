<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:son="http://www.astkorea.net/"
	xmlns:functx="http://www.functx.com" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions" 
	xmlns:xd="http://schemas.microsoft.com/xmltools/2002/xmldiff"
	xpath-default-namespace="http://schemas.microsoft.com/xmltools/2002/xmldiff" 
	exclude-result-prefixes="xs son functx xsi xd fo axf" 
	version="2.0">


	<xsl:output method="xml" encoding="UTF-8" indent="no" />
	<xsl:strip-space elements="*" />

	<xsl:variable name="resource" select="document(concat(son:getpath(base-uri(), '/'), '/before.xml'))" />


	<xsl:template match="*">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@* | node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*">
		<xsl:attribute name="{local-name()}">
			<xsl:value-of select="." />
		</xsl:attribute>
	</xsl:template>
	
	<xsl:variable name="target">
		<xsl:for-each select="$resource/node()">
			<xsl:element name="{local-name()}">
				<xsl:attribute name="ancesCnt">
					<xsl:value-of select="count(ancestor::*)"/>
				</xsl:attribute>
				<xsl:attribute name="currentPos">
					<xsl:value-of select="position()"/>
				</xsl:attribute>
				<xsl:apply-templates select="node()" />
			</xsl:element>
		</xsl:for-each>
	</xsl:variable>

	<xsl:template match="xmldiff" >
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="node">
		<xsl:element name="{if(parent::xmldiff) then 'root' else local-name()}">
			<xsl:variable name="matchEdited" select="if(parent::xmldiff) then '1' else @match"/>
			<xsl:attribute name="match">
				<xsl:value-of select="$matchEdited"/>
			</xsl:attribute>
			
			<xsl:attribute name="pos">
				<xsl:value-of select="count(ancestor::*)"/>
			</xsl:attribute>

			<xsl:apply-templates select="node()" />
		</xsl:element>
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
</xsl:stylesheet>