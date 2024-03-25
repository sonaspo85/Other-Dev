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

	<xsl:param name="output" as="xs:string" required="yes"/>
    <xsl:output method="xml" encoding="UTF-8" indent="no" />

	<xsl:key name="notrans" match="sdl:tag[contains(sdl:bpt/@name, 'Notrans')]" use="@id" />
	<xsl:key name="C_OSD" match="sdl:tag[matches(sdl:bpt/@name, '(C_OSD-NoBold|C_OSD)')]" use="@id" />
	<xsl:key name="notemark" match="sdl:cxt-def[contains(@type,'sdl:note')]" use="@id" />
	
	 <xsl:template match="/">
		 <xsl:result-document method="xml" href="file:////{$output}">
			 <xsl:apply-templates />
		 </xsl:result-document>
	 </xsl:template>

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
			<xsl:apply-templates select="//trans-unit/target//mrk" />
			<xsl:text>&#xA;</xsl:text>
        </xsl:element>
	</xsl:template>

	<xsl:template match="mrk">
        <xsl:variable name="i">
        	<xsl:number from="target" level="any" format="1" />
       	</xsl:variable>
		<xsl:if test="not(matches(., '^OSD\s+')) and 
					  not(matches(., '^&quot;&quot;$')) and 
					  not(matches(., '\^Q\^Q')) and
					  not(matches(., '^\(쪽\)')) and
					  not(matches(., '^ 페이지의 &quot;&quot;$')) and
					  not(matches(., '^ 페이지:$')) and
					  not(matches(., '^ 페이지$')) and
					  not(matches(., '^내용$')) and
					  not(matches(., '^색인$')) and
					  not(matches(., '^[\.▶]$')) and
					  not(matches(., '^&#xFEFF;?[a-zA-Z]\d?(\++)?$')) and 
					  not(matches(., '^[&#xFEFF;\s%:±+\-/\d\.]+$')) and
					  normalize-space(replace(., '&#xFEFF;', '')) and not(contains(., 'textanchor:'))">
			<xsl:text>&#xA;&#x9;</xsl:text>
	        <xsl:element name="p" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
		        <xsl:attribute name="pid" select="concat(ancestor::trans-unit/@id, '#', $i)" />
				<xsl:apply-templates />
	        </xsl:element>
	    </xsl:if>
	</xsl:template>

	<xsl:template match="x">
		<xsl:choose>
			<xsl:when test="parent::mrk and not(preceding-sibling::*) and not(normalize-space(replace(preceding-sibling::node(), '&#xFEFF;', '')))">
				<xsl:text>&#xFEFF;</xsl:text>
		        <xsl:element name="{local-name()}" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
		            <xsl:apply-templates select="@*" />
		        </xsl:element>
			</xsl:when>
			<xsl:otherwise>
		        <xsl:element name="{local-name()}" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
		            <xsl:apply-templates select="@*" />
		        </xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="g">
		<xsl:choose>
			<xsl:when test="parent::mrk and not(preceding-sibling::*) and 
					  		not(normalize-space(replace(preceding-sibling::node(), '&#xFEFF;', ''))) and 
					  		starts-with(@id, 'g')">
		        <xsl:element name="notrans" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
		            <xsl:apply-templates select="@id" />
		            <xsl:apply-templates select="node()" />
		        </xsl:element>
			</xsl:when>
			
			<xsl:when test="parent::mrk and not(preceding-sibling::*) and 
							not(normalize-space(replace(preceding-sibling::node(), '&#xFEFF;', ''))) and 
							starts-with(@id, 'osd_text')">
				<xsl:element name="OSD" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
					<xsl:apply-templates select="@id" />
					<xsl:apply-templates select="node()" />
				</xsl:element>
			</xsl:when>
			
			<xsl:when test="key('notrans', @id)">
		        <xsl:element name="notrans" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
		            <xsl:apply-templates select="@id" />
		            <xsl:apply-templates select="node()" />
		        </xsl:element>
			</xsl:when>
			
			<xsl:when test="key('C_OSD', @id)">
				<xsl:if test="matches(., '\s+$') and preceding-sibling::node()[1][self::text()][not(matches(., '\s$'))]">
					<xsl:text>&#x20;</xsl:text>
				</xsl:if>
				
				<xsl:element name="OSD" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
					<xsl:apply-templates select="@id" />
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="self::text()">
								<xsl:apply-templates select="." mode="OSD" />
                            </xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="." />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
				</xsl:element>
				
				<xsl:if test="matches(., '\s+$') and following-sibling::node()[1][self::text()][not(matches(., '^\s'))]">
					<xsl:text>&#x20;</xsl:text>
				</xsl:if>
			</xsl:when>

			<xsl:otherwise>
		        <xsl:element name="{local-name()}" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
		            <xsl:apply-templates select="@id" />
		            <xsl:apply-templates select="node()" />
		        </xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="group[key('notemark', sdl:cxts/sdl:cxt[2]/@id)]" />

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

	<xsl:template match="text()" mode="OSD">
		<xsl:choose>
			<xsl:when test="not(following-sibling::node())">
				<xsl:value-of select="replace(., '\s+$', '')" />
			</xsl:when>
			<xsl:when test="not(preceding-sibling::node())">
				<xsl:value-of select="replace(., '^\s+', '')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="." />
            </xsl:otherwise>
		</xsl:choose>
    </xsl:template>

    <xsl:template match="text()">
		<xsl:analyze-string select="." regex="(&#x9;+)">
			<xsl:matching-substring>
				<xsl:processing-instruction name="AST">
					<xsl:value-of select="concat('t', string-length(regex-group(1)))" />
				</xsl:processing-instruction>
				<xsl:text>&#x20;</xsl:text>
			</xsl:matching-substring>
			<xsl:non-matching-substring>
				<xsl:analyze-string select="." regex="(&#x20;&#x20;+)">
					<xsl:matching-substring>
						<xsl:processing-instruction name="AST">
							<xsl:value-of select="concat('s', string-length(regex-group(1)))" />
						</xsl:processing-instruction>
						<xsl:text>&#x20;</xsl:text>
					</xsl:matching-substring>
					<xsl:non-matching-substring>
						<xsl:analyze-string select="." regex="&#xA;">
							<xsl:matching-substring>
								<xsl:processing-instruction name="AST">8232</xsl:processing-instruction>
								<xsl:text>&#x20;</xsl:text>
							</xsl:matching-substring>
							<xsl:non-matching-substring>
								<xsl:value-of select="." />
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
