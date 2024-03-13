<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
	xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
	xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:ast="http://www.astkorea.net/"
    exclude-result-prefixes="xs ot-placeholder opentopic ditaarch dita-ot ast"
    version="2.0">

	<xsl:variable name="job" select="document(resolve-uri('.job.xml', base-uri(.)))" as="document-node()?"/>
  	<xsl:key name="jobFile" match="file" use="@uri"/>
  	<xsl:key name="titles" match="title" use="parent::*/@id"/>
  	<xsl:key name="topics" match="*[contains(@class, ' topic/topic ')]" use="@id"/>
	<xsl:variable name="image_alt_contents" select="document(concat(ast:getPath(base-uri(.), '/'), '/../../../../../_reference/meta_data/image_alt_contents.xml'))" as="document-node()"/>
	
	<xsl:variable name="pltf" select="/map/@platform" />
	<xsl:variable name="tvLV" select="document(concat(ast:getPath(base-uri(.), '/'), '/../../../../../_reference/LV/', 'Language_Variable.xml'))" />
	<xsl:variable name="ebtLV" select="document(concat(ast:getPath(base-uri(.), '/'), '/../../../../../_reference/LV/EBT/', 'Language_Variable.xml'))" />
  	<xsl:variable name="Language_Variable" select="if ($pltf = 'ebt') then $ebtLV else $tvLV" as="document-node()?"/>
	<xsl:variable name="LV_name" select="/map/@otherprops" />
	<xsl:variable name="mapId" select="/map/@id" />

    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="title li p cmd note"/>

    <xsl:template match="/*/*[1]">
    </xsl:template>

    <xsl:template match="xref">
        <xsl:element name="{local-name()}">
        	<xsl:variable name="temp_id" select="generate-id(key('topics', key('titles', substring-after(@href, '#'))/parent::*/@id))" />
        	<xsl:variable name="href" select="if ( string-length($temp_id) &lt; 8) then concat($temp_id, 'i') else $temp_id" />
        	<xsl:attribute name="href" select="$href"/>
        	<xsl:attribute name="rev" select="@rev"/>
            <xsl:apply-templates select="key('titles', substring-after(@href, '#'))/node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="processing-instruction('pagebreak')">
    	<xsl:if test="preceding-sibling::node()[1][name()='table'] and following-sibling::node()[1][name()='table']">
    		<xsl:copy/>
    	</xsl:if>
    </xsl:template>

    <xsl:template match="@base">
    </xsl:template>

    <xsl:template match="p[count(*)=1][image][not(string(.))]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*"/>
            <xsl:if test="matches(local-name(), '^(p|cmd)$')">
	            <xsl:attribute name="id">
	            	<xsl:variable name="temp_id" select="generate-id(.)" />
	            	<xsl:value-of select="if ( string-length($temp_id) &lt; 8) then concat($temp_id, 'i') else $temp_id" />
					<!-- <xsl:value-of select="generate-id(.)" /> -->
	            </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="note">
		<xsl:variable name="id" select="ancestor::*[contains(@class, ' topic/topic ')]/@id" />
		<xsl:choose>
			<xsl:when test="@props = 'remote_reference' and not(ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@props)">
			</xsl:when>
			<xsl:otherwise>
		        <xsl:element name="{local-name()}">
		            <xsl:apply-templates select="@*"/>
		            <xsl:attribute name="id">
		            	<xsl:variable name="temp_id" select="generate-id(.)" />
		            	<xsl:value-of select="if ( string-length($temp_id) &lt; 8) then concat($temp_id, 'i') else $temp_id" />
						<!-- <xsl:value-of select="generate-id(.)" /> -->
		            </xsl:attribute>
		            <xsl:apply-templates select="node()"/>
		        </xsl:element>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>

    <xsl:template match="linktext | parmname">
    </xsl:template>

    <xsl:template match="image">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@* except (@src, @href)"/>
            <xsl:attribute name="src">
            	<xsl:value-of select="if ( @outputclass = 'gif') then replace(key('jobFile', @href, $job)/@src, '\.svg', '.gif') else key('jobFile', @href, $job)/@src"/>
            </xsl:attribute>
            <xsl:choose>
	            <xsl:when test="@otherprops='alt:yes'">
	            	<xsl:variable name="image" select="substring-before(ast:getFile(key('jobFile', @href, $job)/@src, '/'), '.svg')"/>
	            	<xsl:variable name="lv-id" select="$image_alt_contents/root/alt[@image=$image]/@lv-id"/>
	            	<xsl:variable name="item" select="$Language_Variable/root/listitem[@CR-ID=$lv-id]/item[@LV_name=$LV_name]"/>
		            <xsl:attribute name="alt">
		            	<xsl:value-of select="$item"/>
		            </xsl:attribute>
		        </xsl:when>
		        <xsl:when test="@otherprops='alt:no'">
		        </xsl:when>
		    </xsl:choose>
        </xsl:element>
    </xsl:template>

    <xsl:template match="image/@outputclass[.='gif']">
    </xsl:template>

    <xsl:template match="concept[parent::map]">
		<xsl:variable name="id" select="@id" />
        <group>
			<xsl:if test="ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@outputclass[.='troubleshooting']">
	            <xsl:attribute name="outputclass">troubleshooting</xsl:attribute>
			</xsl:if>
            <xsl:attribute name="title">
            	<xsl:value-of select="normalize-space(string(title))" />
            </xsl:attribute>
            <xsl:attribute name="description">
            	<xsl:value-of select="normalize-space(string(abstract/shortdesc))" />
            </xsl:attribute>
        	<xsl:apply-templates select="*[not(matches(name(), '^(title|abstract)$'))]"/>
        </group>
    </xsl:template>

    <xsl:template match="concept | task | reference">
		<xsl:variable name="id" select="@id" />
    	<xsl:choose>
			<xsl:when test="count(ancestor::*) = 2 and not(concept or task or reference)">
		        <xsl:element name="{local-name()}">
			        <xsl:element name="{local-name()}">
			            <xsl:attribute name="url">
			            	<xsl:variable name="temp_id" select="generate-id(.)" />
			            	<xsl:value-of select="if ( string-length($temp_id) &lt; 8) then concat($temp_id, 'i') else $temp_id" />
							<!-- <xsl:value-of select="generate-id(.)" /> -->
			            </xsl:attribute>
						<xsl:if test="ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@search[.='no']">
				            <xsl:attribute name="search">no</xsl:attribute>
						</xsl:if>
			            <xsl:apply-templates select="node()"/>
			        </xsl:element>
		        </xsl:element>
			</xsl:when>
			<xsl:otherwise>
		        <xsl:element name="{local-name()}">
		            <xsl:attribute name="url">
		            	<xsl:variable name="temp_id" select="generate-id(.)" />
		            	<xsl:value-of select="if ( string-length($temp_id) &lt; 8) then concat($temp_id, 'i') else $temp_id" />
						<!-- <xsl:value-of select="generate-id(.)" /> -->
		            </xsl:attribute>
					<xsl:if test="ancestor::*[contains(@class, ' map/map ')]/opentopic:map//*[contains(@class, ' map/topicref ')][@id=$id]/@search[.='no']">
			            <xsl:attribute name="search">no</xsl:attribute>
					</xsl:if>
		            <xsl:apply-templates select="node()"/>
		        </xsl:element>
			</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

    <xsl:template match="title">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="id">
            	<xsl:variable name="temp_id" select="generate-id(.)" />
            	<xsl:value-of select="if ( string-length($temp_id) &lt; 8) then concat($temp_id, 'i') else $temp_id" />
				<!-- <xsl:value-of select="generate-id(.)" /> -->
            </xsl:attribute>
            <xsl:if test="contains(@id, '_Connect_42_')">
	            <xsl:attribute name="icon">
	            	<xsl:value-of select="concat(substring-after(@id, '_Connect_42_'), '.png')" />
	            </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="li[not(p)]">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="id">
            	<xsl:variable name="temp_id" select="generate-id(.)" />
            	<xsl:value-of select="if ( string-length($temp_id) &lt; 8) then concat($temp_id, 'i') else $temp_id" />
				<!-- <xsl:value-of select="generate-id(.)" /> -->
            </xsl:attribute>
            <p>
            	<xsl:apply-templates select="node()"/>
            </p>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@*">
    	<xsl:choose>
    		<xsl:when test="local-name() = ('cascade', 'class', 'DITAArchVersion', 'domains', 'xtrc', 'xtrf', 'ohref', 'oid', 'first_topic_id', 'conkeyref', 'x', 'y')">
    		</xsl:when>
    		<xsl:when test="local-name() = 'conkeyref' and .='pv/'">
    		</xsl:when>
    		<xsl:otherwise>
		        <xsl:attribute name="{local-name()}">
		            <xsl:value-of select="."/>
		        </xsl:attribute>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

    <xsl:template match="text()" priority="10">
		<xsl:analyze-string select="." regex="\s*~~\s*">
			<xsl:matching-substring>
            	<xsl:variable name="image" select="if ( $LV_name = ('ARA', 'PER', 'HEB') ) then 'next-rtl' else 'next'"/>
            	<xsl:variable name="lv-id" select="$image_alt_contents/root/alt[@image=$image]/@lv-id"/>
            	<xsl:variable name="item" select="$Language_Variable/root/listitem[@CR-ID=$lv-id]/item[@LV_name=$LV_name]"/>
				<xsl:text>&#x20;</xsl:text>
				<img>
		            <xsl:attribute name="alt" select="$item"/>
						<xsl:choose>
							<xsl:when test="matches($mapId, '2022_project')">
								<xsl:attribute name="src" select="if ( $LV_name = ('ARA', 'PER', 'HEB') ) then '../_common/images/content/next-rtl.png' else '../_common/images/content/next.png'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="src" select="if ( $LV_name = ('ARA', 'PER', 'HEB') ) then '../_common/images/content/next-rtl.svg' else '../_common/images/content/next.svg'"/>							
							</xsl:otherwise>
						</xsl:choose>					
		        	<xsl:attribute name="class" select="'ico_img'"/>
				</img>
				<xsl:text>&#x20;</xsl:text>
			</xsl:matching-substring>
			<xsl:non-matching-substring>
				<xsl:analyze-string select="." regex="&#x2028;">
					<xsl:matching-substring>
						<br/>
					</xsl:matching-substring>
					<xsl:non-matching-substring>
						<xsl:value-of select="replace(replace(replace(., '[&#x0A;&#x09;]+', '&#x20;'), '\s+', '&#x20;'), '&#x200B;', '')"/>
					</xsl:non-matching-substring>
				</xsl:analyze-string>
			</xsl:non-matching-substring>
		</xsl:analyze-string>
    </xsl:template>

	<xsl:function name="ast:getPath">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], '/')" />
	</xsl:function>

	<xsl:function name="ast:getFile">
		<xsl:param name="str"/>
		<xsl:param name="char"/>
		<xsl:value-of select="tokenize($str, $char)[last()]" />
	</xsl:function>

</xsl:stylesheet>