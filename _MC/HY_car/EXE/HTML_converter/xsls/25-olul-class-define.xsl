<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	
	<xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="yes" />
	<xsl:strip-space elements="*"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

	<xsl:template match="*[matches(name(), '(ul|ol)')]">
		<xsl:variable name="child_class" select="*[1]/@class" />
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="matches(@class, '(Hyp(\d)?$|_mark$)')">
					<xsl:value-of select="concat('Nobullet', ' ', $child_class)" />
				</xsl:when>

				<xsl:when test="matches(@class, '(Chapter_TOC|Step\d|Description_NumB|OrderList|UnorderList_Alp|_Number)')">
					<xsl:value-of select="concat('number', ' ', $child_class)" />
				</xsl:when>

				<xsl:when test="matches(@class, 'UnorderList')">
					<xsl:value-of select="concat('bullet', ' ', $child_class)" />
				</xsl:when>

				<xsl:otherwise>
					<xsl:value-of select="if (self::ol) then concat('number', ' ', $child_class) else concat('bullet', ' ', $child_class)" />
                </xsl:otherwise>
			</xsl:choose>
        </xsl:variable>
		
		<xsl:copy>
			<xsl:attribute name="class" select="$class" />
			<xsl:apply-templates select="node()" />
        </xsl:copy>
    </xsl:template>

	<xsl:template match="li">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="matches(@class, 'Hyp(\d)?$')">
					<xsl:value-of select="'dash'" />
				</xsl:when>

				<xsl:otherwise>
					<xsl:value-of select="@class" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:copy>
			<xsl:attribute name="class" select="$class" />
			<xsl:apply-templates select="node()" />
		</xsl:copy>
    </xsl:template>

	<xsl:template match="@class">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="matches(., 'Hyp(\d)?$')">
					<xsl:value-of select="'dash'" />
	    		</xsl:when>

				<xsl:when test="matches(., '(.+)(\.)(.+)')">
					<xsl:value-of select="replace(., '(.+)(\.)(.+)', '$1-$3')" />
				</xsl:when>

				<xsl:otherwise>
					<xsl:value-of select="." />
                </xsl:otherwise>
	    	</xsl:choose>
		</xsl:variable>
		
		<xsl:attribute name="class" select="$class" />
    </xsl:template>
	
	<xsl:template match="text()" priority="10">
		<xsl:value-of select="replace(replace(., '&#8269;', '&lt;'), '&#8268;', '&gt;')" />
	</xsl:template>
	
</xsl:stylesheet>