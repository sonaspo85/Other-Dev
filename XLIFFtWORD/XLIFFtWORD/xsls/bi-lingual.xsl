<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:sdl="http://sdl.com/FileTypes/SdlXliff/1.0"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2"
    xmlns:gom="http://www.astkorea.net/gom"
	xmlns:aml="http://schemas.microsoft.com/aml/2001/core"
    xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"
    xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:v="urn:schemas-microsoft-com:vml"
    xmlns:w10="urn:schemas-microsoft-com:office:word"
    xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml"
    xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint"
    xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2"
    xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core"    
    
    xpath-default-namespace="urn:oasis:names:tc:xliff:document:1.2"
	exclude-result-prefixes="xsl xs sdl xliff gom"
    version="2.0">

	<xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8" />
	<xsl:key name="tags" match="sdl:tag-defs/sdl:tag" use="@id" />

	<xsl:strip-space elements="*" />
	<xsl:preserve-space elements="source target mrk g" />

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

	<xsl:template match="xliff | file">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="sdl:doc-info">
	</xsl:template>

	<xsl:template match="header">
	</xsl:template>

	<xsl:template match="body">
     	<xsl:variable name="original" select="gom:getName(ancestor::file/@original, '\\')" />
     	<xsl:variable name="target" select="ancestor::file/@target-language" />

		<body original="{$original}" target="{$target}">
			<xsl:apply-templates select="group/trans-unit" />
		</body>

	</xsl:template>

	<xsl:template match="trans-unit">
		<xsl:choose>
			<xsl:when test="seg-source/mrk">
				<xsl:element name="p">
					<xsl:apply-templates select="source" />
					<xsl:apply-templates select="target" />
				</xsl:element>
			</xsl:when>
			
			<xsl:when test="seg-source/g">
				<xsl:element name="p">
					<xsl:apply-templates select="source" />
					<xsl:apply-templates select="target" />
				</xsl:element>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="source">
		<source>
            <xsl:apply-templates select="@* | node()" />
		</source>
	</xsl:template>

	<xsl:template match="target">
        <target>
			<xsl:apply-templates select="@* | node()" />
        </target>
	</xsl:template>

	<xsl:template match="mrk">
    	<xsl:apply-templates select="node()" />
    	<xsl:if test="following-sibling::mrk">
    		<xsl:text>&#x20;</xsl:text>
    	</xsl:if>
	</xsl:template>

	<xsl:template match="g">
		<!--<xsl:variable name="qq">
			<xsl:value-of select="key('tags', @id)/sdl:bpt-props/sdl:value[@key='StartTag']/text()" />
		</xsl:variable>
		<xsl:value-of select="$qq" />-->
		<xsl:choose>
			<xsl:when test="key('tags', @id)/sdl:bpt-props/sdl:value[@key='StartTag']">
		        <xsl:element name="{key('tags', @id)/sdl:bpt-props/sdl:value[@key='StartTag']/text()}" >
		        	<xsl:attribute name="id" select="@id" />
		        	<xsl:if test="key('tags', @id)/sdl:bpt-props/sdl:value[@key='FormattingItemTextColor']">
		        		<xsl:attribute name="style" select="concat('color:', lower-case(key('tags', @id)/sdl:bpt-props/sdl:value[@key='FormattingItemTextColor']/text()), ';')" />
		        		<xsl:attribute name="id" select="@id" />
		        	</xsl:if>
		        	<xsl:apply-templates select="@* | node()" />
		        </xsl:element>
			</xsl:when>
			<xsl:otherwise>
		        <xsl:element name="span" >
		        	<xsl:attribute name="id" select="@id" />
		        	<xsl:if test="key('tags', @id)/sdl:bpt-props/sdl:value[@key='FormattingItemTextColor']">
		        		<xsl:attribute name="style" select="concat('color:', lower-case(key('tags', @id)/sdl:bpt-props/sdl:value[@key='FormattingItemTextColor']/text()), ';')" />
		        		<xsl:attribute name="id" select="@id" />
		        	</xsl:if>
		        	<xsl:apply-templates select="@* | node()" />
		        </xsl:element>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:function name="gom:getName">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="tokenize($str, $char)[last()]" />
	</xsl:function>

</xsl:stylesheet>