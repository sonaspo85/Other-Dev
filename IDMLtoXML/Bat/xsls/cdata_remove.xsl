<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
    xmlns:functx="http://www.functx.com"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:idPkg="http://ns.adobe.com/AdobeInDesign/idml/1.0/packaging"
    xmlns:x="adobe:ns:meta/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:xmp="http://ns.adobe.com/xap/1.0/"
	xmlns:xmpGImg="http://ns.adobe.com/xap/1.0/g/img/"
	xmlns:xmpMM="http://ns.adobe.com/xap/1.0/mm/"
	xmlns:stRef="http://ns.adobe.com/xap/1.0/sType/ResourceRef#"
	xmlns:stEvt="http://ns.adobe.com/xap/1.0/sType/ResourceEvent#"
	xmlns:illustrator="http://ns.adobe.com/illustrator/1.0/"
	xmlns:xmpTPg="http://ns.adobe.com/xap/1.0/t/pg/"
	xmlns:stDim="http://ns.adobe.com/xap/1.0/sType/Dimensions#"
	xmlns:xmpG="http://ns.adobe.com/xap/1.0/g/"
	xmlns:pdf="http://ns.adobe.com/pdf/1.3/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    exclude-result-prefixes="xs son xsi idPkg functx x dc xmp xmpGImg xmpMM stRef stEvt illustrator xmpTPg stDim xmpG pdf rdf"
    version="2.0">

	<xsl:character-map name="a">
		<xsl:output-character character='&lt;' string="&lt;"/>
		<xsl:output-character character='&gt;' string="&gt;"/>
	</xsl:character-map>
	
	<xsl:output method="xml" encoding="UTF-8" indent="no" use-character-maps="a" />
	<xsl:strip-space elements="*"/>

	<xsl:template match="*">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*">
		<xsl:attribute name="{local-name()}">
			<xsl:value-of select="replace(replace(., '&lt;\?.*\?&gt;', ''), '[&lt;&gt;]', '')" />
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="Contents">
		<xsl:copy>
			<xsl:value-of select="substring-before(., '&lt;&#x3F;xpacket')" />
			<xsl:value-of select="substring-before(substring-after(., '&lt;?xpacket begin=&quot;﻿&quot; id=&quot;W5M0MpCehiHzreSzNTczkc9d&quot;?&gt;'), '&lt;?xpacket end=&quot;r&quot;?')" />
			<xsl:value-of select="substring-after(., '&lt;?xpacket end=&quot;r&quot;?&gt;') " />
		</xsl:copy>
	</xsl:template>



	<!--<xsl:template match="text()">
		<xsl:value-of select="replace(., '&lt;?AID 001b?&gt;', 'sonaspo')" />
    </xsl:template>
	-->
	
	<!--	
		// xslt 3.0 버전
	<xsl:template match="Contents">
		<xsl:copy>
			<xsl:variable name="content">
				<xsl:apply-templates select="parse-xml(.)"/>
			</xsl:variable>
			
			<xsl:variable name="ser-params">
				<output:serialization-parameters xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization">
					<output:omit-xml-declaration value="yes"/>
				</output:serialization-parameters>
			</xsl:variable>
			
			<xsl:value-of select="serialize($content, $ser-params/*)"/>
		</xsl:copy>
	</xsl:template>-->


	<xsl:function name="son:getpath">
		<xsl:param name="arg1" />
		<xsl:param name="arg2" />
		<xsl:value-of select="string-join(tokenize($arg1, $arg2)[position() ne last()], $arg2)" />
	</xsl:function>

	<xsl:function name="son:last">
		<xsl:param name="arg1" />
		<xsl:param name="arg2" />
		<xsl:copy-of select="tokenize($arg1, $arg2)[last()]" />
	</xsl:function>

</xsl:stylesheet>