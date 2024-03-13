<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="*"/>
	<xsl:param name="modelname" />
	<xsl:param name="language" />
	<xsl:param name="cartype" />

	<xsl:variable name="model-input">
		<xsl:choose>
			<xsl:when test="$modelname = 1">
				<xsl:value-of select="if (lower-case($language) = 'portuguese') then 'KAUAI Hybrid' else 'KONA Hybrid'" />
            </xsl:when>
			<xsl:when test="$modelname = 2">
				<xsl:value-of select="'VENUE'" />
            </xsl:when>

            <xsl:when test="$modelname = 3">
                <xsl:value-of select="'GENESIS'" />
            </xsl:when>
    	</xsl:choose>
    </xsl:variable>

	<xsl:variable name="lang-input">
		<xsl:value-of select="upper-case(substring($language, 1, 1))" />
		<xsl:value-of select="lower-case(substring($language, 2))" />
    </xsl:variable>
	
	<xsl:template match="/">
		<xsl:variable name="files" select="collection(concat(son:getpath(base-uri(.), '/'), '/resource?select=*.xml;recurse=yes'))" />
		<xsl:variable name="filename" select="concat(son:getpath(base-uri(.), '/'), '/temp', '/01-merged.xml')" />
		
		<xsl:result-document href="{$filename}" method="xml">
			<body modelname="{$model-input}" language="{$lang-input}" cartype="{if ($cartype = 1) then 'genesis' else 'hyundai'}">
				<xsl:for-each select="$files/node()">
					<chapter ori-filename="{son:last(base-uri(.), '/')}">
						<xsl:apply-templates select="@*, node()" />
					</chapter>
				</xsl:for-each>
			</body>
		</xsl:result-document>
	</xsl:template>

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