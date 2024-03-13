<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
	xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
	xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:ast="http://www.astkorea.net/"
    exclude-result-prefixes="xs ot-placeholder opentopic ditaarch dita-ot ast"
    version="2.0">

	<xsl:variable name="job" select="document(resolve-uri('.job.xml', base-uri(.)))" as="document-node()?"/>
  	<xsl:key name="jobFile" match="file" use="@uri"/>
  	<xsl:key name="titles" match="title" use="parent::*/@id"/>

    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="title li p cmd note xref"/>

    <xsl:template match="/*/*[1]">
    </xsl:template>

    <xsl:template match="xref">
        <xsl:element name="{local-name()}">
        	<xsl:attribute name="href" select="@href"/>
            <xsl:apply-templates select="key('titles', substring-after(@href, '#'))/node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@base">
    </xsl:template>

    <xsl:template match="*">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="linktext | parmname">
    </xsl:template>

    <xsl:template match="note">
		<xsl:variable name="id" select="ancestor::*[contains(@class, ' topic/topic ')]/@id" />
		<xsl:choose>
			<xsl:when test="@props = 'remote_reference' and 
							not(ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@props)">
			</xsl:when>
			<xsl:otherwise>
		        <xsl:element name="{local-name()}">
		            <xsl:apply-templates select="@* | node()"/>
		        </xsl:element>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>

    <xsl:template match="image">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@* except (@src, @href, @class)"/>
            <xsl:attribute name="src">
            	<xsl:value-of select="ast:getFile(key('jobFile', @href, $job)/@src, '/')"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="processing-instruction('pagebreak')">
    	<xsl:copy/>
    </xsl:template>

    <xsl:template match="concept | task | reference">
    	<xsl:variable name="id" select="@id" />
    	<xsl:choose>
	    	<xsl:when test="ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@product='html'">
	    	</xsl:when>
	    	<xsl:otherwise>
		    	<xsl:if test="ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@outputclass='pagebreak'">
					<xsl:processing-instruction name="pagebreak"/>
		    	</xsl:if>
		        <xsl:element name="{local-name()}">
		            <xsl:apply-templates select="@*"/>
		            <xsl:attribute name="url">
		            	<xsl:variable name="temp_id" select="generate-id(.)" />
		            	<xsl:value-of select="if ( string-length($temp_id) &lt; 8) then concat($temp_id, '0') else $temp_id" />
		            </xsl:attribute>
		            <xsl:apply-templates select="node()"/>
		        </xsl:element>
	    	</xsl:otherwise>
	    </xsl:choose>
    </xsl:template>

    <xsl:template match="title">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="id">
            	<xsl:variable name="temp_id" select="generate-id(.)" />
            	<xsl:value-of select="if ( string-length($temp_id) &lt; 8) then concat($temp_id, '0') else $temp_id" />
            </xsl:attribute>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@*">
    	<xsl:choose>
    		<xsl:when test="local-name() = ('cascade', 'class', 'DITAArchVersion', 'domains', 'xtrc', 'xtrf', 'ohref', 'oid', 'first_topic_id', 'conkeyref')">
    		</xsl:when>
    		<xsl:when test="local-name() = 'conkeyref' and .='pv/'">
    		</xsl:when>
    		<xsl:otherwise>
		        <xsl:attribute name="{local-name()}">
		            <xsl:value-of select="."/>
		        </xsl:attribute>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

    <xsl:template match="text()" priority="10">
		<xsl:analyze-string select="." regex="\s*~~\s*">
			<xsl:matching-substring>
				<xsl:text>&#x20;</xsl:text>
				<image src="next.svg"/>
				<xsl:text>&#x20;</xsl:text>
			</xsl:matching-substring>
			<xsl:non-matching-substring>
				<xsl:value-of select="replace(replace(replace(., '[&#x20;&#x0A;]+&#x09;+', ''), '\s+', '&#x20;'), '&#x200B;', '')"/>
			</xsl:non-matching-substring>
		</xsl:analyze-string>
    </xsl:template>

	<xsl:function name="ast:getName">
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