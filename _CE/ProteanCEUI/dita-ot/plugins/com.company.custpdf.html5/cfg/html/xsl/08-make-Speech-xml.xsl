<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:ast="http://www.astkorea.net/"
    exclude-result-prefixes="xs ast svg"
    version="2.0">

	<xsl:variable name="job" select="document(resolve-uri('.job.xml', base-uri(.)))" as="document-node()?"/>
  	<xsl:key name="jobFile" match="file" use="@uri"/>
	<xsl:variable name="LV_name" select="/CategoryData/@LV_name"/>
	<xsl:variable name="image_alt_contents" select="document(concat(ast:getPath(base-uri(.), '/'), '/../../../../../_reference/meta_data/image_alt_contents.xml'))" as="document-node()"/>
  	
	<xsl:variable name="pltf" select="/CategoryData/@platform" />
	<xsl:variable name="tvLV" select="document(concat(ast:getPath(base-uri(.), '/'), '/../../../../../_reference/LV/', 'Language_Variable.xml'))" />
	<xsl:variable name="ebtLV" select="document(concat(ast:getPath(base-uri(.), '/'), '/../../../../../_reference/LV/EBT/', 'Language_Variable.xml'))" />
  	<xsl:variable name="Language_Variable" select="if ($pltf = 'ebt') then $ebtLV else $tvLV" as="document-node()?"/>

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="no" indent="no" />
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="div li p cmd"/>

	<xsl:template match="/">
		<xsl:variable name="filename" select="concat('../../2_HTML/container/', $LV_name, '/xml/Speech', '.xml')" />
		<xsl:result-document href="{$filename}">
			<xsl:apply-templates select="CategoryData/CategoryData"/>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="CategoryData">
		<xsl:text>&#xA;</xsl:text>
		<docs>
			<xsl:apply-templates select="//page" />
			<xsl:text>&#xA;</xsl:text>
		</docs>
	</xsl:template>

	<xsl:template match="page">
		<xsl:if test="ancestor::chapter/following-sibling::chapter">
			<xsl:value-of select="ast:indent(1)" />
			<doc title="{@title}" id="{@id}" url="{@url}">
				<xsl:variable name="titles">
					<xsl:apply-templates select=".//div[@class='real-con']"/>
				</xsl:variable>
				<xsl:apply-templates select="$titles" mode="retouch"/>
				<xsl:value-of select="ast:indent(1)" />
			</doc>
		</xsl:if>
	</xsl:template>

	<xsl:template match="section">
		<title>
			<xsl:attribute name="class" select="@style"/>
			<xsl:attribute name="text" select="normalize-space(replace(concat(@title, '.'), '\?\.', '.'))"/>
			<xsl:apply-templates select="* except section"/>
		</title>
	</xsl:template>

	<xsl:template match="div[@class='real-con']">
		<title>
			<xsl:attribute name="class">Heading1</xsl:attribute>
			<xsl:attribute name="text" select="normalize-space(replace(concat(preceding-sibling::*[1], '.'), '\?\.', '.'))"/>
			<xsl:apply-templates select="* except section"/>
		</title>
		<xsl:apply-templates select=".//section"/>
	</xsl:template>

	<xsl:template match="div[@class='Heading1-Info'] | h1 | h2 | h3">
	</xsl:template>

	<xsl:template match="div[@class='navigate']">
		<para>
			<xsl:apply-templates select="node()" />
			<xsl:text>..</xsl:text>
		</para>
	</xsl:template>

	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	<xsl:template match="title" mode="retouch">
		<xsl:choose>
			<xsl:when test="title">
				<xsl:apply-templates mode="retouch"/>
			</xsl:when>
			<xsl:when test=". = '&#x20;'">
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="ast:indent(2)" />
				<xsl:copy>
					<xsl:apply-templates select="@*" mode="retouch"/>
					<xsl:apply-templates select="para" mode="retouch"/>
					<xsl:if test="*">
						<xsl:value-of select="ast:indent(2)" />
					</xsl:if>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="para" mode="retouch">
		<xsl:if test="string(.)">
			<xsl:value-of select="ast:indent(3)" />
			<xsl:copy>
				<xsl:apply-templates select="@class" mode="retouch"/>
				<xsl:apply-templates select="text()" mode="retouch"/>
			</xsl:copy>
		</xsl:if>
	</xsl:template>

	<xsl:template match="@* | node()" mode="retouch">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" mode="retouch"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="text()" mode="retouch">
		<xsl:value-of select="replace(replace(replace(normalize-space(.), '\.\.\.', '..'), '\.&quot;\.\.', '..&quot;'), '\s+\.\.$', '..')" />
	</xsl:template>
	<!-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ -->
	<!-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ -->

	<xsl:template match="li">
		<xsl:choose>
			<xsl:when test="p">
				<xsl:apply-templates />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="ast:indent(3)" />
				<para>
					<xsl:apply-templates select="node()" />
					<xsl:text>..</xsl:text>
				</para>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="table | tr | td | b | i | u | ul | ol | span">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="col">
	</xsl:template>

	<xsl:template match="p[p]">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="p">
		<xsl:choose>
			<xsl:when test="@class = 'note' and not(preceding-sibling::*[@class = 'note'])">
				<xsl:value-of select="ast:indent(3)" />
				<xsl:call-template name="admonition">
					<xsl:with-param name="lv-id" select="'adm_note'"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="parent::p/@class = 'note' and not(preceding-sibling::p)">
				<xsl:value-of select="ast:indent(3)" />
				<xsl:call-template name="admonition">
					<xsl:with-param name="lv-id" select="'adm_note'"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@class = 'warning' and not(preceding-sibling::*[@class = 'warning'])">
				<xsl:value-of select="ast:indent(3)" />
				<xsl:call-template name="admonition">
					<xsl:with-param name="lv-id" select="'adm_warning'"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="parent::p/@class = 'warning' and not(preceding-sibling::p)">
				<xsl:value-of select="ast:indent(3)" />
				<xsl:call-template name="admonition">
					<xsl:with-param name="lv-id" select="'adm_warning'"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="ast:indent(3)" />
		<para>
			<xsl:apply-templates select="node()" />
			<xsl:text>..</xsl:text>
		</para>
	</xsl:template>

	<xsl:template name="admonition">
    	<xsl:param name="lv-id"/>
    	<xsl:variable name="item" select="$Language_Variable/root/listitem[@CR-ID=$lv-id]/item[@LV_name=$LV_name]"/>
    	<para>
    		<xsl:value-of select="concat($item, '..')"/>
    	</para>
    </xsl:template>

	<xsl:template match="span[parent::span]">
	</xsl:template>

	<xsl:template match="img">
		<xsl:choose>
			<xsl:when test="@alt">
            	<xsl:variable name="image" select="substring-before(ast:getName(@src, '/'), '.')"/>
            	<xsl:variable name="lv-id" select="$image_alt_contents/root/alt[@image=$image]/@lv-id"/>
            	<xsl:variable name="item" select="$Language_Variable/root/listitem[@CR-ID=$lv-id]/item[@LV_name=$LV_name]"/>
            	<xsl:value-of select="if ($lv-id = 'OSD_0247') then concat('.', $item, '.') else $item"/>
			</xsl:when>
			<xsl:when test="@class='break'">
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="text()" priority="10">
		<xsl:value-of select="replace(replace(., '\s+', '&#x20;'), '\(\s', '(')" />
	</xsl:template>

	<xsl:function name="ast:indent">
		<xsl:param name="depth" />
		<xsl:text>&#xA;</xsl:text>
		<xsl:for-each select="1 to $depth">
			<xsl:text>&#x9;</xsl:text>
		</xsl:for-each>
	</xsl:function>

	<xsl:function name="ast:getPath">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], '/')" />
	</xsl:function>

	<xsl:function name="ast:getName">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="tokenize($str, $char)[last()]" />
	</xsl:function>

</xsl:stylesheet>