<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/"
    exclude-result-prefixes="xs ast"
    version="2.0">

	<xsl:variable name="LV_name" select="/CategoryData/@LV_name"/>

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="no" />
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="div li p cmd"/>

	<xsl:variable name="lang" select="/*/@lang"/>
	<xsl:variable name="indexes">
		 <xsl:for-each select="/*//*[@index='yes']">
		 	<xsl:sort />
		 	<xsl:variable name="value" select="."/>
		 	<xsl:if test="not(ancestor::page[@search='no'])">
	 			<item page="{concat(ancestor::page/@id, '.html')}" anchor="{ancestor-or-self::*[@id][1]/@id}" content="{.}">
	 				<xsl:attribute name="char">
	 					<xsl:choose>
	 						<xsl:when test="matches(upper-case(substring(., 1, 1)), '\p{IsBasicLatin}')">
	 							<xsl:value-of select="upper-case(substring(., 1, 1))"/>
	 						</xsl:when>
	 					    
	 						<xsl:otherwise>
	 							<xsl:variable name="code" select="(string-to-codepoints(substring(., 1, 1)) - 44032) idiv (21 * 28) + 4352" />
	 							<xsl:choose>
	 								<xsl:when test="$code = (4353, 4356, 4360, 4362, 4365)">
	 									<xsl:value-of select="codepoints-to-string($code - 1)"/>
	 								</xsl:when>
	 								<xsl:otherwise>
	 									<xsl:value-of select="codepoints-to-string($code)"/>
	 								</xsl:otherwise>
	 							</xsl:choose>
	 						</xsl:otherwise>
	 					</xsl:choose>
	 				</xsl:attribute>
	 			</item>
	 		</xsl:if>
		 </xsl:for-each>
	</xsl:variable>

	<xsl:template match="/">
		<xsl:variable name="filename" select="concat('../../2_HTML/container/', $LV_name, '/xml/indexes', '.xml')" />
		<xsl:if test="not($lang = ('zh-TW', 'zh-HK', 'zh-CN'))">
			<xsl:result-document href="{$filename}">
				<indexes>
					<xsl:value-of select="ast:indent(1)" />
					<languages>
						<xsl:value-of select="ast:indent(2)" />

						<language name="{$lang}">
							<xsl:variable name="group">
								<xsl:for-each-group select="$indexes/item[matches(@content, '^\i')]" group-by="@char">
									<xsl:variable name="char" select="string-to-codepoints(substring(current-group()[1]/@content, 1, 1))"/>
									<xsl:variable name="headword" select="current-grouping-key()"/>
									<xsl:variable name="first">
										<xsl:choose>
											<xsl:when test="matches(current-grouping-key(), '\p{IsBasicLatin}')">
												<xsl:value-of select="current-grouping-key()"/>
											</xsl:when>
										    
											<xsl:otherwise>
												<xsl:value-of select="substring(current-group()[1]/@content, 1, 1)"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									
								    <xsl:if test="($char &gt;= 65 and $char &lt; 90) or 
								                  matches(substring(current-group()[1]/@content, 1, 1), '[가-힣]')">
    								    <items lang="{$lang}" headword="{$headword}" char="{$char}" first="{$first}">
    								        <xsl:for-each select="current-group()">
    								            <item>
    								                <xsl:apply-templates select="@* except @char" />
    								                <xsl:attribute name="char">
    								                    <xsl:value-of select="string-to-codepoints(substring(@content, 1, 1))"/>
    								                </xsl:attribute>
    								                <xsl:apply-templates select="node()" />
    								            </item>
    								        </xsl:for-each>
    								    </items>
								    </xsl:if>
								</xsl:for-each-group>
							</xsl:variable>

							<xsl:for-each select="$group/items[not(matches(@first, '\p{IsBasicLatin}'))]">
								<xsl:apply-templates select="." />
							</xsl:for-each>

							<xsl:for-each select="$group/items[matches(@first, '\p{IsBasicLatin}')]">
								<xsl:apply-templates select="." />
							</xsl:for-each>

							<xsl:value-of select="ast:indent(2)" />
						</language>

						<xsl:if test="$indexes/item[matches(@content, '^[^\i]')]">
							<xsl:value-of select="ast:indent(2)" />
							<language name="symbols-etc">
								<xsl:for-each-group select="$indexes/item[matches(@content, '^[^\i]')]" group-by="@char">
									<xsl:for-each select="current-group()">
										<xsl:value-of select="ast:indent(3)" />
										<item>
											<xsl:apply-templates select="@* | node()" />
										</item>
									</xsl:for-each>
								</xsl:for-each-group>
								<xsl:value-of select="ast:indent(2)" />
							</language>
						</xsl:if>
						<xsl:value-of select="ast:indent(1)" />
					</languages>
					<xsl:text>&#xA;</xsl:text>
				</indexes>
			</xsl:result-document>
		</xsl:if>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="items">
		<xsl:value-of select="ast:indent(3)" />
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
			<xsl:value-of select="ast:indent(3)" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="item">
		<xsl:value-of select="ast:indent(4)" />
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:function name="ast:indent">
		<xsl:param name="depth" />
		<xsl:text>&#xA;</xsl:text>
		<xsl:for-each select="1 to $depth">
			<xsl:text>&#x9;</xsl:text>
		</xsl:for-each>
	</xsl:function>

</xsl:stylesheet>