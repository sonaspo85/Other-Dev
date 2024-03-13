<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
    exclude-result-prefixes="xs son xsi aid"
    version="2.0">

    <xsl:output method="xml" encoding="UTF-8" indent="no"/>
    
	<xsl:variable name="modelname" select="body/@modelname" />
	<xsl:variable name="language" select="body/@language" />
	
	<!--<xsl:variable name="model-input">
		<xsl:choose>
			<xsl:when test="matches($modelname, 'OS HEV')">
				<xsl:value-of select="if (lower-case($language) = 'portuguese') then 'KAUAI Hybrid' else 'KONA Hybrid'" />
			</xsl:when>
            
			<xsl:when test="matches($modelname, 'QX')">
				<xsl:value-of select="'VENUE'" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>-->

	<!--<xsl:template match="*">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*">
		<xsl:attribute name="{local-name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>-->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
	<xsl:template match="Root">
		<xsl:element name="chapter">
			<xsl:apply-templates select="@* | node()" />
        </xsl:element>
	</xsl:template>

	<xsl:template match="body/@modelname">
		<!-- jar 파일로 할때 -->
		<!--<xsl:attribute name="modelname" select="substring-before(., ' (')" />-->
		
		<!-- bat 파일로 할때 -->
		<xsl:attribute name="modelname" select="." />
		<!--<xsl:value-of select="substring-before(., ' (')" />-->
    </xsl:template>

	<!--<xsl:template match="body">
		<xsl:copy>
			<xsl:attribute name="modelname" select="$model-input" />
			<xsl:apply-templates select="@* except @modelname" />
            <xsl:apply-templates select="node()" />
		</xsl:copy>
	</xsl:template>-->

	<xsl:template match="*[starts-with(name(), 'C_')]">
		<xsl:variable name="style" select="local-name()" />
		
		<span style="{$style}">
			<xsl:apply-templates select="@* | node()" />
		</span>
	</xsl:template>

	<xsl:template match="text()" priority="10">
		<xsl:choose>
			<xsl:when test="not(parent::C_Subscript)">
				<xsl:analyze-string select="." regex="(.*)(\*\d)">
					<xsl:matching-substring>
						<xsl:value-of select="regex-group(1)" />
						<span class="C_Subscript">
							<xsl:value-of select="regex-group(2)" />
						</span>
					</xsl:matching-substring>
					<xsl:non-matching-substring>
						<xsl:value-of select="replace(replace(., '&#x2028;', ''), '&#x2029;', '')" />
					</xsl:non-matching-substring>
				</xsl:analyze-string>
			</xsl:when>

			<xsl:otherwise>
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>