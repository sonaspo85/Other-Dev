<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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
    xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
	exclude-result-prefixes="xsl aml dt ve o v w10 w wx wsp sl wpc mc wne">

	<xsl:output method="xml" version="1.0" indent="no" encoding="UTF-8" />
	<xsl:strip-space elements="*" />
	
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

    <xsl:template match="w:wordDocument">
       	<xsl:text>&#xA;</xsl:text>
    	<html>
       	<xsl:text>&#xA;</xsl:text>
		<head>
       		<xsl:text>&#xA;&#x9;</xsl:text>
			<title>
			
			<meta charset="UTF-8"/>
			</title>
       		<xsl:text>&#xA;</xsl:text>
		</head>
    	<xsl:text>&#xA;</xsl:text>
    	<body>
    		<xsl:apply-templates select="w:body//w:p"/>
    		<xsl:text>&#xA;</xsl:text>
    	</body>
    	<xsl:text>&#xA;</xsl:text>
    	</html>
    </xsl:template>

    <xsl:template match="w:p">
    	<xsl:text>&#xA;&#x9;</xsl:text>
    	<p>
    		<xsl:apply-templates select="w:r"/>
    	</p>
    </xsl:template>

    <xsl:template match="w:r">
    	<xsl:choose>
	    	<xsl:when test="w:rPr/w:b | w:rPr/w:i | w:rPr/w:u | w:rPr/w:color">
	    		<xsl:choose>
	    			<xsl:when test="w:rPr/w:b">
	    				<b><xsl:value-of select="." /></b>
	    			</xsl:when>
	    			<xsl:when test="w:rPr/w:i">
	    				<i><xsl:value-of select="." /></i>
	    			</xsl:when>
	    			<xsl:when test="w:rPr/w:u">
	    				<u><xsl:value-of select="." /></u>
	    			</xsl:when>
	    			<xsl:when test="w:rPr/w:color">
	    				<span>
	    					<xsl:attribute name="style" select="concat('color:', w:rPr/w:color/@w:val)" />
	    					<xsl:value-of select="." />
	    				</span>
	    			</xsl:when>
	    		</xsl:choose>
	    	</xsl:when>
	    	<xsl:otherwise>
    			<xsl:value-of select="." />
	    	</xsl:otherwise>
	    </xsl:choose>
    </xsl:template>

</xsl:stylesheet>