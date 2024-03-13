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
	exclude-result-prefixes="xs son functx xsi xd fo axf" 
	version="2.0">


	<xsl:output method="xml" encoding="UTF-8" indent="no" />
	<xsl:strip-space elements="*" />

	<xsl:variable name="resource" select="document(concat(son:getpath(base-uri(), '/'), '/../resource/before.xml'))" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
		</xsl:copy>
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

	<xsl:template match="root">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:for-each select="node">
				<xsl:variable name="ancesCnt" select="@pos" as="xs:integer"/>
				<xsl:variable name="presCnt" select="@match" as="xs:integer"/>
				
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					
					<xsl:variable name="targetNode">
						<xsl:for-each select="$target/root//*[count(ancestor-or-self::*) = $ancesCnt][count(preceding-sibling::*) + 1 = $presCnt]">
							<xsl:variable name="cur" select="." />
							<xsl:variable name="curNodeName" select="local-name()"/>
							<xsl:value-of select="$curNodeName"/>
						</xsl:for-each>
					</xsl:variable>
					<xsl:variable name="targetNode1" select="$target/root//*[count(ancestor-or-self::*) = $ancesCnt][count(preceding-sibling::*) + 1 = $presCnt]"/>
					
					<xsl:attribute name="curNodeName" select="$targetNode" />
					
					<xsl:if test="node">
						<xsl:call-template name="node">
							<xsl:with-param name="targetNode" select="$targetNode1"  />
						</xsl:call-template>
					</xsl:if>
				</xsl:copy>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="node" name="node">
		<xsl:param name="targetNode" />
		
		<xsl:variable name="ancesCnt" select="@pos" as="xs:integer"/>
		<xsl:variable name="presCnt" select="@match" as="xs:integer"/>
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			
			<xsl:variable name="targetNode1">
				<xsl:for-each select="$targetNode[count(preceding-sibling::*) + 1 = $presCnt]">
					<xsl:variable name="cur" select="." />
					<xsl:variable name="curNodeName" select="local-name()"/>
					<xsl:value-of select="$curNodeName"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:variable name="targetNode2" select="$targetNode[count(preceding-sibling::*) + 1 = $presCnt]/*"/>
			
			<xsl:attribute name="curNodeName" select="$targetNode1" />

			<xsl:choose>
				<xsl:when test="node">
					<xsl:for-each select="node">
						<xsl:call-template name="node">
							<xsl:with-param name="targetNode" select="$targetNode2" />
						</xsl:call-template>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="node()">
						<xsl:with-param name="targetNode" select="$targetNode2" />
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>
	
	
	<xsl:template match="remove">
		<xsl:param name="targetNode" />
		
		<xsl:variable name="presCnt" select="@match" />
		<xsl:variable name="presCnt01" select="tokenize($presCnt, '-')" />
		
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			
			<xsl:for-each select="$presCnt01">
				<xsl:variable name="cur" select="xs:integer(.)" />

				<xsl:for-each select="$targetNode[count(preceding-sibling::*) + 1 = $cur]">
					<xsl:apply-templates select="." />
				</xsl:for-each>
			</xsl:for-each>
		</xsl:copy>
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