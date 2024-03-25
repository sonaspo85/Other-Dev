<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:sdl="http://sdl.com/FileTypes/SdlXliff/1.0"
	xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:son="http://astkorea.net"
	xpath-default-namespace="urn:oasis:names:tc:xliff:document:1.2"
	exclude-result-prefixes="xsl xs sdl xliff son xsi"
	version="2.0">
	<xsl:strip-space elements="*" />
	<xsl:preserve-space elements="source seg-source target mrk g" />

	<xsl:character-map name="a"> 
		<xsl:output-character character="&lt;" string="&amp;lt;"/>
		<xsl:output-character character="&gt;" string="&amp;gt;"/>
		<xsl:output-character character="&quot;" string="&amp;quot;"/>
	</xsl:character-map>

	<xsl:param name="output" as="xs:string" required="yes"/>
	<xsl:param name="osdfile" as="xs:string" required="yes"/>   <!--termbase.xml-->
	<xsl:variable name="termbase" select="document($osdfile)" />
	<xsl:output method="xml" encoding="UTF-8" indent="no" use-character-maps="a"/>
	
	<xsl:key name="cxtid_text" match="sdl:cxt-def[matches(sdl:props/sdl:value[@key='node']/text(),'\[No character style\]&quot;')]" use="@id" />
	<xsl:key name="notrans" match="sdl:cxt-def[matches(sdl:props/sdl:value[@key='node']/text(),'(C_Notrans(%0d)?(\s+)?&quot;|C_Notrans\-NoBold(%0d)?(\s+)?&quot;)')]" use="@id" />
	<xsl:key name="tag_notrans" match="sdl:tag[matches(sdl:bpt-props/sdl:value[@key='node']/text(),'(C_Notrans(%0d)?(\s+)?&quot;|C_Notrans\-NoBold(%0d)?(\s+)?&quot;)')]" use="@id" />
	<xsl:key name="C_Osd" match="sdl:tag[matches(sdl:bpt-props/sdl:value[@key='node']/text(),'(C_OSD-NoBold(%0d)?(\s*)?&quot;|C_OSD(%0d)?(\s+)?&quot;)')]" use="@id" />
	
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

	<xsl:template match="xliff">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
			<xsl:element name="osd_table">
				<xsl:apply-templates select="$termbase/*[name()='root']/*" />
			</xsl:element>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="*[parent::*[name()='test']]">
		<xsl:copy>
			<xsl:if test="matches(., '\s###$')">
				<xsl:attribute name="class" select="'abreast'" />
			</xsl:if>
			<xsl:apply-templates select="@*" />
			<xsl:for-each select="node()">
				<xsl:choose>
					<xsl:when test="self::text()">
						<xsl:value-of select="replace(., '\s###$', '')" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy>
							<xsl:apply-templates select="@*, node()" />
						</xsl:copy>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="g[parent::mrk]">
		<xsl:variable name="id" select="@id" />
		<xsl:variable name="cxt-id" select="ancestor::group/sdl:cxts/sdl:cxt[1]/@id"/>
		<xsl:variable name="cur" select="name()" />
		<xsl:variable name="id" select="@id" />

		<xsl:choose>
			<xsl:when test="key('cxtid_text', $cxt-id)">
				<xsl:for-each select="node()">
					<xsl:choose>
						<xsl:when test="self::text() and key('tag_notrans', ancestor::mrk/parent::g/@id)">
							<xsl:apply-templates select="." />
						</xsl:when>
					
						<xsl:when test="self::text() and key('notrans', ancestor::mrk/parent::g/@id)">
							<xsl:apply-templates select="." />
						</xsl:when>
						
						<xsl:when test="self::text() and key('C_Osd', ancestor::mrk/parent::g/@id)">
							<xsl:apply-templates select="." />
						</xsl:when>

						<xsl:otherwise>
							<xsl:element name="{$cur}" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
								<xsl:attribute name="id" select="$id" />
								<xsl:copy>
									<xsl:apply-templates select="@*, node()" />
								</xsl:copy>
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="trans-unit/target//mrk">
		<xsl:variable name="i">
			<xsl:number from="target" level="any" format="1" />
	   	</xsl:variable>
		<xsl:choose>
			<xsl:when test="not(matches(., '^OSD\s+')) and 
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
				<xsl:element name="replace" xmlns="urn:oasis:names:tc:xliff:document:1.2">
					<xsl:attribute name="pid" select="concat(ancestor::trans-unit/@id, '#', $i)" />
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@* | node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>