<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:sdl="http://sdl.com/FileTypes/SdlXliff/1.0"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2"
    xpath-default-namespace="urn:oasis:names:tc:xliff:document:1.2"
	exclude-result-prefixes="xsl xs sdl xliff"
    version="2.0">
	<xsl:strip-space elements="*" />
	<xsl:preserve-space elements="source seg-source target mrk g" />

	<xsl:character-map name="a"> 
		<xsl:output-character character="&lt;" string="&amp;lt;"/>
		<xsl:output-character character="&gt;" string="&amp;gt;"/>
		<xsl:output-character character="&quot;" string="&amp;quot;"/>
	</xsl:character-map>

    <xsl:output method="xml" encoding="UTF-8" indent="no" use-character-maps="a"/>
	<xsl:param name="output" as="xs:string" required="yes"/>

	<xsl:template match="/">
		<xsl:result-document method="xml" href="file:////{$output}">
			<xsl:apply-templates />
		</xsl:result-document>
	</xsl:template>

    <xsl:template match="@* | node()">
    	<xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@* | node()" mode="replace">
    	<xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="replace" />
        </xsl:copy>
    </xsl:template>

	<xsl:template match="trans-unit">
		<xsl:choose>
			<xsl:when test=".//mrk">
		    	<xsl:copy>
		            <xsl:apply-templates select="@*" />
		            <xsl:apply-templates select="node()" mode="replace"/>
		        </xsl:copy>
		    </xsl:when>
		    <xsl:otherwise>
		    	<xsl:copy>
		            <xsl:apply-templates select="@* | node()"/>
		        </xsl:copy>
		    </xsl:otherwise>
		</xsl:choose>
	</xsl:template>

    <xsl:template match="mrk" mode="replace">
    	<xsl:choose>
    		<xsl:when test="parent::seg-source">
		    	<xsl:copy>
		            <xsl:apply-templates select="@* | node()" />
		        </xsl:copy>
    		</xsl:when>
    		<xsl:when test="ancestor::target">
		        <xsl:variable name="i">
		        	<xsl:number from="target" level="any" format="1" />
		       	</xsl:variable>
		       	<xsl:choose>
		       		<xsl:when test="count(g) &gt; 1 and not(*[name()!='g'])">
		       			<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
    						<xsl:apply-templates select="g[1]/@*" />
							<xsl:element name="replace" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
			    				<xsl:attribute name="pid" select="concat(ancestor::trans-unit/@id, '#', $i)" />
							</xsl:element>
						</xsl:element>
		       		</xsl:when>
		       		<xsl:otherwise>
						<xsl:element name="replace" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
		    				<xsl:attribute name="pid" select="concat(ancestor::trans-unit/@id, '#', $i)" />
						</xsl:element>
		       		</xsl:otherwise>
		       	</xsl:choose>
    		</xsl:when>
		    <xsl:otherwise>
		    	<xsl:copy>
		            <xsl:apply-templates select="@* | node()"/>
		        </xsl:copy>
		    </xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

</xsl:stylesheet>