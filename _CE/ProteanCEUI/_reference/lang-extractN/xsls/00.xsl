<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

    <xsl:output method="xml" encoding="UTF-8" indent="no" />

    <xsl:variable name="import_lang" select="document(resolve-uri('xsls/lang.xml', base-uri(.)))" />
    
    <xsl:param name="language" />

    <xsl:variable name="compare">
        <xsl:for-each select="$import_lang/root/language">
            <xsl:choose>
                <xsl:when test="$language = position()">
                    <xsl:value-of select="@lang" />
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:variable>

</xsl:stylesheet>