<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:sdl="http://sdl.com/FileTypes/SdlXliff/1.0"
	xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2"
	xpath-default-namespace="urn:oasis:names:tc:xliff:document:1.2"
	xmlns:gom="http://www.astkorea.net/gom"
	xmlns:functx="http://www.functx.com"
	xmlns:son="http://astkorea.net"
	exclude-result-prefixes="xsl xs sdl xliff gom functx son"
	version="2.0">

	<xsl:character-map name="a">
		<xsl:output-character character="&lt;" string="&amp;lt;"/>
		<xsl:output-character character="&gt;" string="&amp;gt;"/>
		<xsl:output-character character="&quot;" string="&amp;quot;"/>
	</xsl:character-map>

	<xsl:param name="output" as="xs:string" required="yes"/>
	<xsl:param name="xml" as="xs:string" required="yes"/>
  	<xsl:param name="codexml" as="xs:string" required="yes"/>

  	<xsl:output method="xml" encoding="UTF-8" byte-order-mark="yes" indent="no" use-character-maps="a"/>
	<xsl:strip-space elements="*" />
	<xsl:preserve-space elements="source seg-source target mrk g p" />

	<xsl:key name="none" match="sdl:tag[matches(sdl:bpt-props/sdl:value[@key='node']/text(),'(\[No character style\]&quot;|
			 					C_OSD-NoBold(%0d)?(\s+)?&quot;|
			 					C_OSD(%0d)?(\s+)?&quot;|
			 					C_Notrans(%0d)?(\s+)?&quot;|
			 					C_Notrans\-NoBold(%0d)?(\s+)?&quot;)')]" use="@id" />
	<xsl:key name="notemark" match="sdl:cxt-def[contains(@type,'sdl:note')]" use="@id" />
	<xsl:key name="noteref" match="sdl:tag[contains(sdl:ph[@name='noteref']/text(),'&lt;noteref')]" use="@id" />

	<xsl:variable name="lgs" select="/xliff/file/@target-language" />
	<xsl:variable name="codes" select="document($codexml)/codes/code/@lang"/>
	<xsl:variable name="codesabbr" select="$codes/parent::*[matches(@lang, $lgs)]" />
	<xsl:variable name="rename" select="if ($codesabbr) then $codesabbr/@abbr else ''" />

	<xsl:variable name="target" select="document($xml)"/>
	<xsl:variable name="lang" select="/xliff/file/@target-language" />
	<xsl:variable name="osdtable" select="/xliff/*[name()='osd_table']" />

	<xsl:template match="/">
		<xsl:result-document method="xml"  href="file:////{$output}">
			<xsl:apply-templates />
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="xliff">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="target//replace">
		<xsl:variable name="i" select="xs:integer(substring-after(@pid, '#'))" />
		<xsl:variable name="pid" select="@pid" />
		<xsl:variable name="mrks" select="ancestor::target/preceding-sibling::seg-source//mrk" />
		<xsl:variable name="true_false" select="if ( key('none', parent::*/@id) ) then 'true' else 'false'" />
		<xsl:variable name="pre-xid" select="ancestor::target/preceding-sibling::source/*[x[key('noteref', @id)]]/@id" />
		<xsl:variable name="pre-x" select="ancestor::target/preceding-sibling::source/*/x[key('noteref', @id)]" />

		<xsl:if test="string($target/body/p[@pid=$pid])">
			<mrk xmlns="urn:oasis:names:tc:xliff:document:1.2">
				<xsl:apply-templates select="$mrks[$i]/@*" />
				<xsl:apply-templates select="$target/body/p[@pid=$pid]/node()">
					<xsl:with-param name="true_false" select="$true_false"/>
					<xsl:with-param name="pre-xid" select="$pre-xid" />
					<xsl:with-param name="pre-x" select="$pre-x" />
				</xsl:apply-templates>
			</mrk>
		</xsl:if>
	</xsl:template>

	<xsl:template match="notrans">
		<xsl:param name="true_false" />
		<xsl:choose>
			<xsl:when test="$true_false = 'true'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="preceding-sibling::node()[1][name()='g'] and following-sibling::node()[1][name()='g']">
				<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
					<xsl:apply-templates select="@* | node()" />
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
					<xsl:apply-templates select="@* | node()" />
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="g[matches(@class, 'osd_text')]">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="OSD">
		<xsl:param name="true_false" />
		<xsl:param name="pre-xid" />
		<xsl:param name="pre-x" />

		<xsl:choose>
			<xsl:when test="matches(@id, 'osd_text')">
				<xsl:for-each select="node()">
					<xsl:call-template name="changed">
						<xsl:with-param name="cur" select="." />
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>

			<xsl:when test="preceding-sibling::node()[1][name()='OSD'] and following-sibling::node()[1][name()='OSD']">
				<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
					<xsl:apply-templates select="@*" />

					<xsl:for-each select="node()">
						<xsl:variable name="pos" select="parent::*/@id" />
						<xsl:call-template name="changed">
							<xsl:with-param name="cur" select="." />
							<xsl:with-param name="pre-xid" select="$pre-xid" />
							<xsl:with-param name="pre-x" select="$pre-x" />
							<xsl:with-param name="pos" select="$pos" />
						</xsl:call-template>
					</xsl:for-each>
				</xsl:element>
			</xsl:when>

			<xsl:otherwise>
				<xsl:element name="g" namespace="urn:oasis:names:tc:xliff:document:1.2" inherit-namespaces="no">
					<xsl:apply-templates select="@*" />
					<xsl:for-each select="node()">
						<xsl:variable name="pos" select="parent::*/@id" />
						<xsl:call-template name="changed">
							<xsl:with-param name="cur" select="." />
							<xsl:with-param name="pre-xid" select="$pre-xid" />
							<xsl:with-param name="pre-x" select="$pre-x" />
							<xsl:with-param name="pos" select="$pos" />
						</xsl:call-template>
					</xsl:for-each>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="changed">
		<xsl:param name="cur" />
		<xsl:param name="pre-xid" />
		<xsl:param name="pre-x" />
		<xsl:param name="pos" />

		<xsl:choose>
			<xsl:when test="$cur/self::text()">
				<xsl:variable name="cur" select="replace(replace(., '(\s+)?(\()(\s+)?', '$2'), '(\s+)?(\))(\s+)?', '$2')" />

				<xsl:variable name="target_class" select="$osdtable/*[name()='test'][*[name()='TERM'][son:normalize(replace(replace(., '(\s+)?(\()(\s+)?', '$2'), '(\s+)?(\))(\s+)?', '$2'))=son:normalize($cur)]]/*[local-name()=$rename]" />

				<xsl:choose>
					<xsl:when test="count($osdtable/*[name()='test'][*[name()='TERM'][son:normalize(replace(replace(., '(\s+)?(\()(\s+)?', '$2'), '(\s+)?(\))(\s+)?', '$2'))=son:normalize($cur)]]/*[local-name()=$rename]) &gt; 1">
						<xsl:variable name="str">
							<xsl:for-each select="$osdtable/*[name()='test'][*[name()='TERM'][son:normalize(replace(replace(., '(\s+)?(\()(\s+)?', '$2'), '(\s+)?(\))(\s+)?', '$2'))=son:normalize($cur)]]/*[local-name()=$rename]/node()">
								<xsl:sequence select="." />
								<xsl:text>###</xsl:text>
							</xsl:for-each>
						</xsl:variable>
						<xsl:variable name="seq" select="tokenize($str, '###')" />
						<xsl:variable name="note_integer">
							<xsl:choose>
								<xsl:when test="key('notemark', ancestor::group/following-sibling::*[1][name()='group']/sdl:cxts/sdl:cxt[2]/@id)">
									<xsl:value-of select="tokenize(ancestor::group/following-sibling::*[1][name()='group']/trans-unit/source//text()[starts-with(., 'OSD')], ' ')[2]" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="1" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<!-- <xsl:variable name="class_ckeck" select="if ($target_class/@class[matches(., 'abreast')]) then concat($cur, ' (', $seq[number($note_integer)], ')') else $seq[number($note_integer)]" /> -->
						<xsl:variable name="class_ckeck">
							<xsl:choose>
								<xsl:when test="$target_class/@class[matches(., 'abreast')]">
									<xsl:value-of select="concat($cur, ' (', $seq[number($note_integer)], ')')" />
								</xsl:when>
								
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="string($seq[number($note_integer)])">
											<xsl:value-of select="$seq[number($note_integer)]" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="concat('&lt;&lt;&lt;', ., '&gt;&gt;&gt;')" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

						<xsl:value-of select="$class_ckeck" />

						<xsl:if test="$pos = $pre-xid">
							<xsl:copy-of select="$pre-x" />
						</xsl:if>
					</xsl:when>
					
					<xsl:when test="count($osdtable/*[name()='test'][*[name()='TERM'][son:normalize(replace(replace(., '(\s+)?(\()(\s+)?', '$2'), '(\s+)?(\))(\s+)?', '$2'))=son:normalize($cur)]]/*[local-name()=$rename]) = 1">
						<xsl:variable name="cur_target" select="$osdtable/*[name()='test'][*[name()='TERM'][son:normalize(replace(replace(., '(\s+)?(\()(\s+)?', '$2'), '(\s+)?(\))(\s+)?', '$2'))=son:normalize($cur)]]/*[local-name()=$rename]/node()" />
						<xsl:choose>
							<xsl:when test="$target_class/@class[matches(., 'abreast')]">
								<xsl:value-of select="concat($cur, ' (', $cur_target, ')')" />
							</xsl:when>

							<xsl:when test="$target_class">
								<xsl:choose>
									<xsl:when test="string($cur_target)">
										<xsl:value-of select="$cur_target" />
                                    </xsl:when>
									
									<xsl:otherwise>
										<xsl:value-of select="concat('&lt;&lt;&lt;', ., '&gt;&gt;&gt;')" />
                                    </xsl:otherwise>
                                </xsl:choose>
							</xsl:when>

							<xsl:otherwise>
								<xsl:value-of select="concat('&lt;&lt;&lt;', ., '&gt;&gt;&gt;')" />
							</xsl:otherwise>
						</xsl:choose>

						<xsl:if test="$pos = $pre-xid">
							<xsl:copy-of select="$pre-x" />
						</xsl:if>
					</xsl:when>
					
					<xsl:otherwise>
						<xsl:value-of select="concat('&lt;&lt;&lt;', ., '&gt;&gt;&gt;')" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<xsl:otherwise>
				<xsl:apply-templates select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*[name()='osd_table']" />

	<xsl:template match="processing-instruction('AST')">
		<xsl:variable name="value" select="." />
		<xsl:choose>
			<xsl:when test="$value='8232'">
				<xsl:text>&#xA;</xsl:text>
			</xsl:when>
			<xsl:when test="starts-with($value, 't')">
				<xsl:variable name="count" select="substring-after($value, 't')" />
				<xsl:for-each select="1 to xs:integer($count)">
					<xsl:text>&#x9;</xsl:text>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="starts-with($value, 's')">
				<xsl:variable name="count" select="substring-after($value, 's')" />
				<xsl:for-each select="1 to xs:integer($count)">
					<xsl:text>&#x20;</xsl:text>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="target//text() | p/text()" priority="10">
		<xsl:choose>
			<xsl:when test="preceding-sibling::node()[1][self::processing-instruction('AST')]">
				<xsl:value-of select="replace(., '^&#x20;', '')" />
			</xsl:when>
			<xsl:when test="functx:value-intersect($lang, $codes[parent::*[not(matches(@class, 'fullstop'))]])">
				<xsl:value-of select="replace(., '(\d+)\.(\d+)', '$1,$2')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:function name="functx:value-intersect" as="xs:anyAtomicType*" xmlns:functx="http://www.functx.com">
		<xsl:param name="arg1" as="xs:anyAtomicType*"/>
		<xsl:param name="arg2" as="xs:anyAtomicType*"/>
		<xsl:sequence select="distinct-values($arg1[.=$arg2])"/>
	</xsl:function>

	<xsl:function name="son:getpath">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], $char)" />
	</xsl:function>

	<xsl:function name="son:normalize">
		<xsl:param name="str"/>
		<xsl:value-of select="normalize-space(lower-case($str))"/>
	</xsl:function>

</xsl:stylesheet>
