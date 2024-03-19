<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:sdl="http://sdl.com/FileTypes/SdlXliff/1.0"
    xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2"
    xmlns:gom="http://www.astkorea.net/gom"
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
	exclude-result-prefixes="xsl gom">

	<xsl:output method="xml" version="1.0" indent="no" encoding="UTF-8" standalone="yes" />
	<xsl:strip-space elements="*" />

	<xsl:variable name="filename" select="if (ends-with(/body/@original, '.html')) then substring-before(/body/@original, '.html') else substring-before(/body/@original, '.doc')" />
	<xsl:variable name="target" select="/body/@target" />
	<xsl:variable name="codes" select="document(concat(gom:getPath(base-uri(.), '/'), '/xsls/', 'lang-code.xml'))" />
	<xsl:variable name="code" select="$codes/codes/code[@xml:lang=$target]/text()" />

	<xsl:template match="/">
		<xsl:result-document href="{concat($filename, '_', $code, '.doc')}" method="xml">
			<xsl:apply-templates select="body" />
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="body">
		<w:wordDocument xml:space="preserve">
			<w:docPr><w:view w:val="print"/></w:docPr>
			<w:body>
				<w:sectPr>
					<w:pgSz w:w="15840" w:h="12240" w:orient="landscape"/>
					<w:pgMar w:top="720" w:right="720" w:bottom="720" w:left="720" w:header="720" w:footer="720" w:gutter="0"/><w:cols w:space="720"/>
				</w:sectPr>
				<w:tbl>
					<w:tblPr>
						<w:tblW w:w="0" w:type="auto"/>
							<w:tblBorders>
								<w:top w:val="single" w:sz="4"/>
								<w:left w:val="single" w:sz="4"/>
								<w:bottom w:val="single" w:sz="4"/>
								<w:right w:val="single" w:sz="4"/>
								<w:insideH w:val="single" w:sz="4"/>
								<w:insideV w:val="single" w:sz="4"/>
							</w:tblBorders>
							<w:tblCellMar>
								<w:top w:w="0" w:type="dxa"/>
								<w:left w:w="108" w:type="dxa"/>
								<w:bottom w:w="0" w:type="dxa"/>
								<w:right w:w="108" w:type="dxa"/>
							</w:tblCellMar>
					</w:tblPr>
					<w:tblGrid>
						<w:gridCol w:w="684"/>
						<w:gridCol w:w="6795"/>
						<w:gridCol w:w="7137"/>
					</w:tblGrid>
					<w:tr>
						<w:tc>
							<w:tcPr><w:tcW w:w="684" w:type="dxa"/><w:shd w:val="clear" w:color="auto" w:fill="8DB3E2"/></w:tcPr>
							<w:p>
								<w:pPr><w:spacing w:after="0" w:line="240" w:line-rule="auto"/></w:pPr>
								<w:r>
									<w:rPr><w:rFonts w:ascii="Arial" w:fareast="맑은 고딕" w:h-ansi="Arial" w:cs="Arial"/></w:rPr>
									<w:t>Page</w:t>
								</w:r>
							</w:p>
						</w:tc>
						<w:tc>
							<w:tcPr><w:tcW w:w="6795" w:type="dxa"/><w:shd w:val="clear" w:color="auto" w:fill="8DB3E2"/></w:tcPr>
							<w:p>
								<w:pPr><w:spacing w:after="0" w:line="240" w:line-rule="auto"/></w:pPr>
								<w:r>
									<w:rPr><w:rFonts w:ascii="Arial" w:fareast="맑은 고딕" w:h-ansi="Arial" w:cs="Arial"/></w:rPr>
									<w:t>Source segment</w:t>
								</w:r>
							</w:p>
						</w:tc>
						<w:tc>
							<w:tcPr><w:tcW w:w="7137" w:type="dxa"/><w:shd w:val="clear" w:color="auto" w:fill="8DB3E2"/></w:tcPr>
							<w:p>
								<w:pPr><w:spacing w:after="0" w:line="240" w:line-rule="auto"/></w:pPr>
								<w:r>
									<w:rPr><w:rFonts w:ascii="Arial" w:fareast="맑은 고딕" w:h-ansi="Arial" w:cs="Arial"/></w:rPr>
									<w:t>Target segment</w:t>
								</w:r>
							</w:p>
						</w:tc>
					</w:tr>
					<xsl:apply-templates select="p" />
				</w:tbl>
			</w:body>
		</w:wordDocument>
	</xsl:template>

	<xsl:template match="p">
		<w:tr>
			<w:tc>
				<w:tcPr><w:tcW w:w="684" w:type="dxa"/></w:tcPr>
				<w:p>
					<w:pPr><w:spacing w:after="0" w:line="240" w:line-rule="auto"/></w:pPr>
					<w:r>
						<w:rPr><w:rFonts w:ascii="Arial" w:fareast="맑은 고딕" w:h-ansi="Arial" w:cs="Arial"/></w:rPr>
						<w:t></w:t>
					</w:r>
				</w:p>
			</w:tc>
			<w:tc>
				<w:tcPr><w:tcW w:w="6795" w:type="dxa"/></w:tcPr>
				<w:p>
					<w:pPr><w:spacing w:after="0" w:line="240" w:line-rule="auto"/></w:pPr>
					<xsl:call-template name="wr1">
						<xsl:with-param name="context" select="source" />
					</xsl:call-template>
				</w:p>
			</w:tc>
			<w:tc>
				<w:tcPr><w:tcW w:w="7137" w:type="dxa"/></w:tcPr>
				<w:p>
					<w:pPr>
						<xsl:if test="$target = ('ar-SA', 'he-IL', 'fa-IR')">
							<w:bidi/>
						</xsl:if>
						<w:spacing w:after="0" w:line="240" w:line-rule="auto"/>
					</w:pPr>
					<xsl:call-template name="wr2">
						<xsl:with-param name="context" select="target" />
					</xsl:call-template>
				</w:p>
			</w:tc>
		</w:tr>
	</xsl:template>

	<xsl:template name="wr1">
		<xsl:param name="context" />
		<xsl:for-each select="$context/node()">
			<xsl:choose>
				<xsl:when test="self::*">
					<w:r>
						<w:rPr>
							<w:rFonts w:ascii="Arial" w:fareast="맑은 고딕" w:h-ansi="Arial" w:cs="Arial"/>
							<xsl:choose>
								<xsl:when test="name()='b'">
									<w:b/>
								</xsl:when>
								<xsl:when test="name()='i'">
									<w:i/>
								</xsl:when>
								<xsl:when test="name()='u'">
									<w:u w:val="single"/>
								</xsl:when>
								<xsl:when test="name()='span'">
									<!--<w:color w:val="FF0000"/>-->
									<w:b/>
								</xsl:when>
							</xsl:choose>
						</w:rPr>
						<w:t><xsl:value-of select="." /></w:t>
					</w:r>
				</xsl:when>
				<xsl:when test="self::text()">
					<w:r>
						<w:rPr>
							<w:rFonts w:ascii="Arial" w:fareast="맑은 고딕" w:h-ansi="Arial" w:cs="Arial"/>
						</w:rPr>
						<w:t><xsl:value-of select="." /></w:t>
					</w:r>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="wr2">
		<xsl:param name="context" />
		<xsl:for-each select="$context/node()">
			<xsl:choose>
				<xsl:when test="self::*">
					<w:r>
						<w:rPr>
							<w:rFonts w:ascii="Arial" w:fareast="맑은 고딕" w:h-ansi="Arial" w:cs="Arial"/>
							<xsl:choose>
								<xsl:when test="name()='b'">
									<w:b/>
								</xsl:when>
								<xsl:when test="name()='i'">
									<w:i/>
								</xsl:when>
								<xsl:when test="name()='u'">
									<w:u w:val="single"/>
								</xsl:when>
								<xsl:when test="name()='span'">
									<!--<w:color w:val="FF0000"/>-->
									<w:b/>
								</xsl:when>
							</xsl:choose>
							<xsl:if test="$target = ('ar-SA', 'he-IL', 'fa-IR')">
								<w:rtl/>
							</xsl:if>
						</w:rPr>
						<w:t><xsl:value-of select="." /></w:t>
					</w:r>
				</xsl:when>
				<xsl:when test="self::text()">
					<w:r>
						<w:rPr>
							<w:rFonts w:ascii="Arial" w:fareast="맑은 고딕" w:h-ansi="Arial" w:cs="Arial"/>
							<xsl:if test="$target = ('ar-SA', 'he-IL', 'fa-IR')">
								<w:rtl/>
							</xsl:if>
						</w:rPr>
						<w:t><xsl:value-of select="." /></w:t>
					</w:r>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:function name="gom:getPath">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], $char)" />
	</xsl:function>

</xsl:stylesheet>