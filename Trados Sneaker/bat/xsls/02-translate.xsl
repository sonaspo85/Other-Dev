<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:sdl="http://sdl.com/FileTypes/SdlXliff/1.0"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2"
    xmlns:gom="http://www.astkorea.net/gom"
    xpath-default-namespace="urn:oasis:names:tc:xliff:document:1.2"
	exclude-result-prefixes="xsl xs sdl xliff gom"
    version="2.0">

	<xsl:strip-space elements="*" />
	<xsl:preserve-space elements="source seg-source target mrk g" />
    <xsl:output method="xml" encoding="UTF-8" indent="no" />

	<xsl:param name="output" as="xs:string" required="yes"/>

	<xsl:template match="xliff | file">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="sdl:doc-info">
	</xsl:template>

	<xsl:template match="header">
	</xsl:template>

	<xsl:template match="body">
		<xsl:text>&#xA;</xsl:text>
        <xsl:element name="{local-name()}" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
        	<xsl:variable name="source" select="ancestor::file/@source-language" />
        	<xsl:variable name="target" select="ancestor::file/@target-language" />
        	<xsl:attribute name="original" select="concat(gom:getName(ancestor::file/@original, '\\'), '_', $source, '_', $target, '.sdlxliff')" />
			<xsl:apply-templates select="//trans-unit" />
			<xsl:text>&#xA;</xsl:text>
        </xsl:element>
	</xsl:template>

	<xsl:template match="trans-unit">
		<xsl:choose>
			<xsl:when test="source[count(*)=1][x]">
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="target//mrk" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="mrk">
		<xsl:text>&#xA;&#x9;</xsl:text>
        <xsl:variable name="i">
        	<xsl:number from="target" level="any" format="1" />
       	</xsl:variable>
		<xsl:choose>
			<xsl:when test="count(g) &gt; 1 and not(*[name()!='g'])">
		        <xsl:element name="p" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
			        <xsl:attribute name="pid" select="concat(ancestor::trans-unit/@id, '#', $i)" />
	            	<xsl:value-of select="g[1]" />
		            <xsl:text>&#x20;</xsl:text>
	            	<xsl:for-each select="g[position() &gt; 1]">
	            		<xsl:value-of select="." />
		            	<xsl:if test="position()!=last()">
		            		<xsl:text>&#x20;</xsl:text>
		            	</xsl:if>
	            	</xsl:for-each>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
		        <xsl:element name="p" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
			        <xsl:attribute name="pid" select="concat(ancestor::trans-unit/@id, '#', $i)" />
					<xsl:apply-templates />
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="g">
        <xsl:element name="{local-name()}" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
            <xsl:apply-templates select="@* | node()" />
        </xsl:element>
	</xsl:template>

	<xsl:template match="x">
		<xsl:choose>
			<xsl:when test="parent::mrk and not(preceding-sibling::*) and not(normalize-space(replace(preceding-sibling::node(), '&#xFEFF;', '')))">
				<xsl:text>&#xFEFF;</xsl:text>
		        <xsl:element name="{local-name()}" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
		            <xsl:apply-templates select="@* | node()" />
		        </xsl:element>
			</xsl:when>
			<xsl:otherwise>
		        <xsl:element name="{local-name()}" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
		            <xsl:apply-templates select="@* | node()" />
		        </xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="/">
		<xsl:result-document method="xml" href="file:////{$output}">
			<xsl:apply-templates />
		</xsl:result-document>
	</xsl:template>

    <xsl:template match="*">
        <xsl:element name="{local-name()}" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="@*">
        <xsl:attribute name="{local-name()}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:variable name="i">
        	<xsl:number from="target" level="any" format="1" />
       	</xsl:variable>
		<xsl:analyze-string select="." regex="(&#x9;+)">
			<xsl:matching-substring>
				<xsl:processing-instruction name="AST">
					<xsl:value-of select="concat('t', string-length(regex-group(1)))" />
				</xsl:processing-instruction>
			</xsl:matching-substring>
			<xsl:non-matching-substring>
				<xsl:analyze-string select="." regex="(&#x20;&#x20;+)">
					<xsl:matching-substring>
						<xsl:processing-instruction name="AST">
							<xsl:value-of select="concat('s', string-length(regex-group(1)))" />
						</xsl:processing-instruction>
					</xsl:matching-substring>
					<xsl:non-matching-substring>
						<xsl:analyze-string select="." regex="&#xA;">
							<xsl:matching-substring>
								<xsl:text>&#x20;</xsl:text>
								<!--<xsl:processing-instruction name="AST">8232</xsl:processing-instruction>-->
							</xsl:matching-substring>
							<xsl:non-matching-substring>
								<xsl:value-of select="replace(., '&#xFEFF;', '')" />
							</xsl:non-matching-substring>
						</xsl:analyze-string>
					</xsl:non-matching-substring>
				</xsl:analyze-string>
			</xsl:non-matching-substring>
		</xsl:analyze-string>
    </xsl:template>

	<xsl:function name="gom:getName">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="tokenize($str, $char)[last()]" />
	</xsl:function>

</xsl:stylesheet>