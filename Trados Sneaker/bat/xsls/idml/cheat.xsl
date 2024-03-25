<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:sdl="http://sdl.com/FileTypes/SdlXliff/1.0"
	xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2"
	xmlns:son="http://astkorea.net"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
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
	<xsl:param name="codexml" as="xs:string" required="yes"/>
	<xsl:output method="xml" encoding="UTF-8" indent="no" use-character-maps="a"/>

	<xsl:variable name="id-1st-tag" as="xs:integer">
		<xsl:value-of select="min(//sdl:tag/@id)" />
	</xsl:variable>

	<xsl:variable name="lgs" select="/xliff/file/@target-language" />
	
	<xsl:key name="none1" match="sdl:tag[matches(sdl:bpt-props/sdl:value[@key='node']/text(),'\[No character style\]&quot;')]" use="@id" />
	<xsl:key name="none2" match="sdl:tag[matches(sdl:bpt-props/sdl:value[@key='node']/text(),'\[No character style\]&quot;')] | sdl:tag[contains(sdl:bpt-props/sdl:value[@key='node']/text(),'TEXT-Emphasize(%0d)?(\s+)?&quot;')]" use="@id" />	
	<xsl:key name="emph" match="sdl:tag[matches(sdl:bpt-props/sdl:value[@key='node']/text(),'TEXT-Emphasize(%0d)?(\s+)?&quot;')]" use="@id" />
	<xsl:key name="tableHeader" match="sdl:tag[matches(sdl:bpt-props/sdl:value[@key='node']/text(),'TableHeader(%0d)?(\s+)?&quot;&gt;')]" use="@id" />
	<xsl:key name="notrans" match="sdl:cxt-def[matches(sdl:props/sdl:value[@key='node']/text(),'(C_Notrans(%0d)?(\s+)?&quot;|C_Notrans\-NoBold(%0d)?(\s+)?&quot;)')]" use="@id" />
	<xsl:key name="tag_notrans" match="sdl:tag[matches(sdl:bpt-props/sdl:value[@key='node']/text(),'(C_Notrans(%0d)?(\s+)?&quot;|C_Notrans\-NoBold(%0d)?(\s+)?&quot;)')]" use="@id" />
	<xsl:key name="cxtid_text" match="sdl:cxt-def[matches(sdl:props/sdl:value[@key='node']/text(),'\[No character style\]&quot;')]" use="@id" />
	<xsl:key name="C_Bold" match="sdl:tag[matches(sdl:bpt-props/sdl:value[@key='node']/text(),'C[_-]Bold(%0d)?(\s+)?&quot;')]" use="@id" />
	<xsl:key name="C_Osd" match="sdl:tag[matches(sdl:bpt-props/sdl:value[@key='node']/text(),'(C_OSD-NoBold(%0d)?(\s*)?&quot;|C_OSD(%0d)?(\s+)?&quot;)')]" use="@id" />
	<xsl:key name="osdproperty" match="sdl:cxt-def[matches(sdl:props/sdl:value[@key='node']/text(),'\[No character style\]&quot;')] | sdl:cxt-def[matches(sdl:props/sdl:value[@key='node']/text(),'(C_OSD-NoBold(%0d)?(\s+)?&quot;|C_OSD(%0d)?(\s+)?&quot;)')]" use="@id" />
	<xsl:key name="onlyosdprop" match="sdl:cxt-def[matches(sdl:props/sdl:value[@key='node']/text(),'(C_OSD-NoBold(%0d)?(\s+)?&quot;|C_OSD(%0d)?(\s+)?&quot;)')]" use="@id" />
	<xsl:key name="noteref" match="sdl:tag[matches(sdl:ph[@name='noteref']/text(),'&lt;noteref')]" use="@id" />
	<xsl:key name="chapter" match="sdl:tag[matches(sdl:ph[@name='Chapter']/text(),'Chapter&quot;')]" use="@id" />
	<xsl:key name="notemark" match="sdl:cxt-def[contains(@type,'sdl:note')]" use="@id" />
	<xsl:key name="sdltable" match="sdl:cxt-def[matches(@type,'(sdl:table|상호 참조 형식)')]" use="@id" />
	
	
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

	<xsl:template match="mrk">
		<xsl:variable name="cxt-id" select="ancestor::group/sdl:cxts/sdl:cxt[1]/@id"/>
		<xsl:variable name="cxt-table" select="ancestor::group/sdl:cxts/sdl:cxt[3]/@id"/>
		
		<xsl:choose>
			<xsl:when test="key('cxtid_text', $cxt-id)">
				<xsl:copy>
					<xsl:apply-templates select="@*"/>
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="self::text() and 
									  		key('notrans', ancestor::g/@id) and 
									  		key('sdltable', $cxt-table)">
								<xsl:apply-templates select="."/>
							</xsl:when>
						
							<xsl:when test="self::text() and key('none2', ancestor::g/@id)">
								<xsl:apply-templates select="."/>
							</xsl:when>
						
							<xsl:when test="self::text() and key('C_Bold', ancestor::g/@id)">
								<xsl:apply-templates select="."/>
							</xsl:when>
						
							<xsl:when test="self::text() and key('notrans', ancestor::g/@id)">
								<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
									<xsl:attribute name="id" select="if ($id-1st-tag = 0) then 'g1' else $id-1st-tag - 1" />
									<xsl:value-of select="." />
								</xsl:element>
							</xsl:when>
							
							<xsl:when test="self::text() and key('tag_notrans', ancestor::g/@id)">
								<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
									<xsl:attribute name="id" select="if ($id-1st-tag = 0) then 'g1' else $id-1st-tag - 1" />
									<xsl:value-of select="." />
								</xsl:element>
							</xsl:when>

							<xsl:when test="self::text() and key('C_Osd', ancestor::g/@id)">
								<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
									<xsl:attribute name="id" select="'osd_text'" />
									<xsl:apply-templates select="." />
								</xsl:element>
							</xsl:when>

							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:copy>
			</xsl:when>
		
			<xsl:when test="key('notrans', $cxt-id)[matches(sdl:props/sdl:value[@key='node']/text(),'C_Notrans(%0d)?(\s+)?&quot;')]">
				<xsl:copy>
					<xsl:apply-templates select="@*"/>
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="self::text() and key('notrans', ancestor::g/@id)">
								<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
									<xsl:attribute name="id" select="if ($id-1st-tag = 0) then 'g2' else $id-1st-tag - 2" />
									<xsl:value-of select="." />
								</xsl:element>
							</xsl:when>
							
							<xsl:when test="self::text() and not(key('none2', ancestor::g/@id))">
								<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
									<xsl:attribute name="id" select="if ($id-1st-tag = 0) then 'g2' else $id-1st-tag - 2" />
									<xsl:value-of select="." />
								</xsl:element>
							</xsl:when>
							
							<xsl:when test="self::g">
								<xsl:choose>
									<xsl:when test="key('none1', @id)">
										<xsl:apply-templates select="text()"/>
									</xsl:when>
									<xsl:when test="key('emph', @id)">
										<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
											<xsl:attribute name="id" select="@id" />
											<xsl:apply-templates select="node()" />
										</xsl:element>
									</xsl:when>
									<xsl:when test="key('tableHeader', @id)">
										<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
											<xsl:attribute name="id" select="@id" />
											<xsl:apply-templates select="node()" />
										</xsl:element>
									</xsl:when>
									<xsl:when test="key('C_Bold', @id)">
										<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
											<xsl:attribute name="id" select="@id" />
											<xsl:apply-templates select="node()" />
										</xsl:element>
									</xsl:when>
									
									<xsl:otherwise>
										<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
											<xsl:attribute name="id" select="if ($id-1st-tag = 0) then 'g2' else $id-1st-tag - 2" />
											<xsl:value-of select="." />
										</xsl:element>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:copy>
			</xsl:when>
			
			<xsl:when test="key('notrans', $cxt-id)[matches(sdl:props/sdl:value[@key='node']/text(),'C_Notrans\-NoBold(%0d)?(\s+)?&quot;')]">
				<xsl:copy>
					<xsl:apply-templates select="@*"/>
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="self::text() and key('notrans', ancestor::g/@id)">
								<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
									<xsl:attribute name="id" select="if ($id-1st-tag = 0) then 'g1' else $id-1st-tag - 1" />
									<xsl:value-of select="." />
								</xsl:element>
							</xsl:when>
							
							<xsl:when test="self::text() and not(key('none2', ancestor::g/@id))">
								<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
									<xsl:attribute name="id" select="if ($id-1st-tag = 0) then 'g1' else $id-1st-tag - 1" />
									<xsl:value-of select="." />
								</xsl:element>
							</xsl:when>
							
							<xsl:when test="self::g">
								<xsl:choose>
									<xsl:when test="key('none1', @id)">
										<xsl:apply-templates select="text()"/>
									</xsl:when>
									<xsl:when test="key('emph', @id)">
										<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
											<xsl:attribute name="id" select="@id" />
											<xsl:apply-templates select="node()" />
										</xsl:element>
									</xsl:when>
									<xsl:when test="key('C_Bold', @id)">
										<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
											<xsl:attribute name="id" select="@id" />
											<xsl:apply-templates select="node()" />
										</xsl:element>
									</xsl:when>
									
									<xsl:otherwise>
										<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
											<xsl:attribute name="id" select="if ($id-1st-tag = 0) then 'g1' else $id-1st-tag - 2" />
											<xsl:value-of select="." />
										</xsl:element>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:copy>
			</xsl:when>
			
			<xsl:when test="key('osdproperty', $cxt-id) and ancestor::*[name()!=source]">
				<xsl:copy>
					<xsl:apply-templates select="@*"/>
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="self::x and key('noteref', @id) and 
									  		key('notemark' ,ancestor::group/following-sibling::*[1][name()='group']/sdl:cxts/sdl:cxt[2]/@id)">
							</xsl:when>
							
							<xsl:when test="self::g and key('C_Osd', @id)">
								<xsl:variable name="cosd" select="." />
								<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
									<xsl:attribute name="id" select="@id" />
									<xsl:apply-templates select="@*" />
									<xsl:for-each select="node()">
										<xsl:choose>
											<xsl:when test="self::x and key('noteref', @id) and 
									  						key('notemark' ,ancestor::group/following-sibling::*[1][name()='group']/sdl:cxts/sdl:cxt[2]/@id)">
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="." />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</xsl:element>
							</xsl:when>

							<xsl:when test="self::text()[ancestor::mrk/parent::g[key('C_Osd', @id)]]">
								<xsl:choose>
									<xsl:when test=".=ancestor::*[name()='target']/preceding-sibling::source//text() or 
									  		self::text()[key('onlyosdprop', $cxt-id)][key('sdltable', ancestor::trans-unit/preceding-sibling::sdl:cxts/sdl:cxt[3]/@id)] or 
									  		self::text()[key('onlyosdprop', $cxt-id)][key('chapter', ancestor::trans-unit/preceding-sibling::sdl:cxts/sdl:cxt[2]/@id)]">
										<xsl:variable name="cosd" select="." />

										<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
											<xsl:attribute name="id" select="'osd_text'" />
											<xsl:apply-templates select="." />
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="." />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>

							<xsl:when test="self::text()[key('onlyosdprop', $cxt-id)]">
								<xsl:choose>
									<xsl:when test=".=ancestor::*[name()='target']/preceding-sibling::source//text() or 
									  		self::text()[key('onlyosdprop', $cxt-id)][key('sdltable', ancestor::trans-unit/preceding-sibling::sdl:cxts/sdl:cxt[3]/@id)] or 
									  		self::text()[key('onlyosdprop', $cxt-id)][key('chapter', ancestor::trans-unit/preceding-sibling::sdl:cxts/sdl:cxt[2]/@id)]">
										<xsl:variable name="cosd" select="." />

										<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
											<xsl:attribute name="id" select="'osd_text'" />
											<xsl:apply-templates select="." />
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="." />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							
							<xsl:otherwise>
								<xsl:copy>
									<xsl:apply-templates select="@* | node()"/>
								</xsl:copy>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:copy>
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@* | node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="sdl:tag-defs">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:for-each select="sdl:tag">
				<xsl:if test="position()=1">
					<xsl:element name="tag" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
						<xsl:attribute name="id" select="'g2'" />
						<xsl:element name="bpt" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
							<xsl:attribute name="name" select="'C_Notrans'" />
							<xsl:attribute name="word-end" select="'false'" />
							<xsl:text>&lt;cf style=&quot;C_Notrans&quot;&gt;</xsl:text>
						</xsl:element>
						<xsl:element name="bpt-props" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
							<xsl:element name="value" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
								<xsl:attribute name="key" select="'node'" />
								<xsl:text>&lt;CharacterStyleRange AppliedCharacterStyle="CharacterStyle/C_Notrans"&gt;</xsl:text>
							</xsl:element>
						</xsl:element>
						<xsl:element name="ept" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
							<xsl:attribute name="name" select="'C_Notrans'" />
							<xsl:attribute name="word-end" select="'false'" />
							<xsl:text>&lt;/cf&gt;</xsl:text>
						</xsl:element>
					</xsl:element>
					<xsl:element name="tag" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
						<xsl:attribute name="id" select="'g1'" />
						<xsl:element name="bpt" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
							<xsl:attribute name="name" select="'C_Notrans-NoBold'" />
							<xsl:attribute name="word-end" select="'false'" />
							<xsl:text>&lt;cf style=&quot;C_Notrans-NoBold&quot;&gt;</xsl:text>
						</xsl:element>
						<xsl:element name="bpt-props" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
							<xsl:element name="value" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
								<xsl:attribute name="key" select="'node'" />
								<xsl:text>&lt;CharacterStyleRange AppliedCharacterStyle=&quot;CharacterStyle/C_Notrans-NoBold&quot;&gt;</xsl:text>
							</xsl:element>
						</xsl:element>
						<xsl:element name="ept" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
							<xsl:attribute name="name" select="'C_Notrans-NoBold'" />
							<xsl:attribute name="word-end" select="'false'" />
							<xsl:text>&lt;/cf&gt;</xsl:text>
						</xsl:element>
					</xsl:element>

					<xsl:element name="tag" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
						<xsl:attribute name="id" select="'osd_text'" />
						<xsl:element name="bpt" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
							<xsl:attribute name="name" select="'C_OSD-NoBold'" />
							<xsl:attribute name="word-end" select="'false'" />
							<xsl:text>&lt;cf style=&quot;C_OSD-NoBold&quot;&gt;</xsl:text>
						</xsl:element>
						<xsl:element name="bpt-props" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
							<xsl:element name="value" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
								<xsl:attribute name="key" select="'node'" />
								<xsl:text>&lt;CharacterStyleRange AppliedCharacterStyle=&quot;CharacterStyle/C_OSD-NoBold&quot;&gt;</xsl:text>
							</xsl:element>
						</xsl:element>
						<xsl:element name="ept" namespace="http://sdl.com/FileTypes/SdlXliff/1.0" inherit-namespaces="no">
							<xsl:attribute name="name" select="'C_OSD-NoBold'" />
							<xsl:attribute name="word-end" select="'false'" />
							<xsl:text>&lt;/cf&gt;</xsl:text>
						</xsl:element>
					</xsl:element>

				</xsl:if>
				<xsl:copy>
					<xsl:apply-templates select="@* | node()"/>
				</xsl:copy>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>

	<xsl:function name="son:getpath">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], $char)"/>
	</xsl:function>

</xsl:stylesheet>
