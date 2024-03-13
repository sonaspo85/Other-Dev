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


	<xsl:output method="xml" encoding="UTF-8" indent="no" cdata-section-elements="Contents" />
	<xsl:strip-space elements="*"/>
	
	<xsl:param name="region" />
	<xsl:param name="zipName" />
	<xsl:variable name="files" select="collection(concat(son:getpath(base-uri(.), '/'), '/../temp/cleanSource/', '?select=*.xml;recurse=yes'))" />
	<xsl:variable name="filename" select="concat(son:getpath(base-uri(.), '/'), '/../temp', '/04-resource_merged.xml')" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

	<xsl:template match="/">
		<xsl:result-document href="{$filename}" method="xml">
			<root>
				<xsl:attribute name="region" select="$region" />
				<xsl:attribute name="zipName" select="$zipName" />
				<xsl:for-each select="$files/node()">
					<doc lang="{tokenize(son:last(base-uri(.), '/'), '_')[last()]}" ori-filename="{son:last(base-uri(.), '/')}">
						<xsl:attribute name="lang">
							<xsl:variable name="fileName" select="tokenize(replace(son:last(base-uri(.), '/'), '.xml', ''), '_')[last()]"/>
							<xsl:value-of select="$fileName"/>
						</xsl:attribute>
						
						<xsl:apply-templates select="@*, node()" />
					</doc>
				</xsl:for-each>
			</root>
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
		<xsl:copy-of select="tokenize($arg1, $arg2)[last()]" />
	</xsl:function>

</xsl:stylesheet>