<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:fo="http://www.w3.org/1999/XSL/Format" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
	xmlns:suitesol="http://suite-sol.com/namespaces/mapcounts" 
	xmlns:ast="http://www.astkorea.net/"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	exclude-result-prefixes="xsl opentopic-func xs ast xsi" version="2.0">

  	<xsl:variable name="map.dir" select="ast:getPath(/dita-merge/*[contains(@class,' map/map ')][1]/@xtrf, '/')"/>
  	<xsl:variable name="prj.dir" select="ast:getPath($map.dir, '/')"/>
  	<xsl:variable name="map.name" select="substring-before(ast:getFile(/dita-merge/*[contains(@class,' map/map ')][1]/@xtrf, '/'), '.ditamap')"/>
  	<xsl:variable name="job" select="document(concat($prj.dir, '/out/', $map.name, '_temp/.job.xml'))" as="document-node()"/>
  	<xsl:variable name="image-files" select="$job/job/files/file[@format='image']"/>
	<xsl:variable name="smart-ui-svgs" select="$image-files[starts-with(ast:getFile(@src, '/'), 'smart-ui')]/@src"/>
	<xsl:variable name="checksum1" select="replace(unparsed-text(concat($map.dir, '/../../../_Reference/xsls/checksum1'), 'UTF-8'), '\s', '')"/>
	<xsl:variable name="checksum2" select="replace(unparsed-text(concat($map.dir, '/../../../_Reference/xsls/checksum2'), 'UTF-8'), '\s', '')"/>
	<xsl:variable name="pltf" select="/dita-merge/*[contains(@class,' map/map ')][1]/@platform"/>
	<xsl:variable name="tvLV" select="document(concat($map.dir, '/../../../_Reference/LV/', 'Language_Variable.xml'))"/>
	<xsl:variable name="ebtLV" select="document(concat($map.dir, '/../../../_Reference/LV/EBT/', 'Language_Variable.xml'))"/>
	<xsl:variable name="Language_Variable" select="if ($pltf = 'ebt') then $ebtLV else $tvLV"/>
  	<xsl:variable name="Paragraph_Variable" select="document(concat($map.dir, '/../_pvdb/', 'Paragraph_Variable.xml'))"/>
  	<xsl:variable name="image_alt_contents" select="document(concat($map.dir, '/../../../_Reference/meta_data/', 'image_alt_contents.xml'))"/>
	<xsl:variable name="LV_name" select="/dita-merge/*[contains(@class,' map/map ')][1]/@otherprops"/>

	<xsl:template match="/dita-merge/*[contains(@class,' map/map ')][1]/@status">
	</xsl:template>

	<xsl:template match="/">
		<xsl:variable name="filename" select="concat($prj.dir, '/out/mergedXML.xml')"/>
		<!--<xsl:if test="$checksum1 = $checksum2">
			<xsl:apply-templates/>
		</xsl:if>-->
		<xsl:apply-templates/>

		<xsl:for-each select="$smart-ui-svgs">
			<xsl:variable name="svg" select="document(.)" as="document-node()"/>
			<xsl:variable name="tmpSVG" select="replace(., '\.svg', '_tmp.svg')"/>
			<xsl:result-document href="{$tmpSVG}">
				<xsl:apply-templates select="$svg" mode="copy"/>
			</xsl:result-document>
		</xsl:for-each>

		<xsl:if test="/dita-merge/*[contains(@class,' map/map ')][1]/@status='custpdf_merge'">
			<xsl:result-document href="{$filename}">
				<xsl:apply-templates mode="copy"/>
			</xsl:result-document>
		</xsl:if>

	</xsl:template>

	<xsl:template match="svg:tspan" mode="copy">
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="tspan" select="$Language_Variable/root/listitem[@CR-ID=$id]/item[@LV_name=$LV_name][1]"/>
		<xsl:copy>
			<xsl:apply-templates select="@*" mode="copy"/>
			<xsl:value-of select="if ( $tspan != '' ) then $tspan else ."/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@* | node()" mode="copy">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" mode="copy"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[contains(@class, ' topic/table ')][descendant::processing-instruction('pagebreak')]">
		<xsl:variable name="filename" select="concat($prj.dir, '/out/table', count(preceding::table), '.xml')"/>
		<xsl:variable name="table" select="."/>
		<xsl:variable name="tgroup" select="$table/tgroup"/>
		<xsl:variable name="thead" select="$tgroup/thead"/>
		<xsl:variable name="tbody" select="$tgroup/tbody"/>

		<xsl:for-each-group select="$tbody/node()" group-starting-with="processing-instruction('pagebreak')">
			<xsl:if test="current-group()[1][self::processing-instruction('pagebreak')]">
				<xsl:processing-instruction name="pagebreak"/>
				<xsl:text>&#x20;</xsl:text>
			</xsl:if>
			<table>
				<xsl:apply-templates select="$table/@*" mode="break"/>
				<tgroup>
					<xsl:apply-templates select="$tgroup/@*" mode="break"/>
					<xsl:apply-templates select="$tgroup/colspec" mode="break"/>
					<xsl:apply-templates select="$thead"/>
					<tbody>
						<xsl:apply-templates select="$tbody/@*"/>
						<xsl:for-each select="current-group()[name()='row']">
							<xsl:variable name="i" select="position() + 1"/>
							<row>
								<xsl:apply-templates select="@*" mode="break"/>
								<xsl:call-template name="makeEntry">
									<xsl:with-param name="i" select="$i"/>
									<xsl:with-param name="entries" select="entry"/>
								</xsl:call-template>
							</row>
						</xsl:for-each>
					</tbody>
				</tgroup>
			</table>
		</xsl:for-each-group>
	</xsl:template>

	<xsl:template name="makeEntry">
		<xsl:param name="i"/>
		<xsl:param name="entries"/>
		<xsl:for-each select="$entries">
			<entry>
				<xsl:apply-templates select="@* except @dita-ot:y" mode="break"/>
				<xsl:attribute name="dita-ot:y" select="$i"/>
				<xsl:apply-templates select="node()"/>
			</entry>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="@* | node()" mode="break">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" mode="break"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="processing-instruction('pagebreak')" mode="break">
	</xsl:template>

	<xsl:template match="*[matches(name(), 'varname|cmdname|apiname|ph|b')][@rev]">
		<xsl:variable name="CR-ID" select="@rev"/>
		<xsl:copy>
			<xsl:apply-templates select="@* except @rev"/>
			<xsl:choose>
				<xsl:when test="name()='varname'">
					<xsl:attribute name="class">+ topic/keyword sw-d/varname </xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='cmdname'">
					<xsl:attribute name="class">+ topic/keyword sw-d/cmdname </xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='apiname'">
					<xsl:attribute name="class">+ topic/keyword pr-d/apiname </xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='ph'">
					<xsl:attribute name="class">- topic/ph </xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='b'">
					<xsl:attribute name="class">+ topic/ph hi-d/b </xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<xsl:value-of select="$Language_Variable/root/listitem[@CR-ID=$CR-ID]/item[@LV_name=$LV_name][1]"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[@base]">
		<xsl:variable name="current" select="."/>
		<xsl:choose>
			<xsl:when test="matches($LV_name, '^(KOR|ENG|ENG\-US)$')">
				<xsl:copy>
					<xsl:apply-templates select="@* | node()"/>
				</xsl:copy>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="base" select="@base"/>
				<xsl:variable name="rev" select="@rev"/>
			 	<xsl:choose>
			 		<xsl:when test="$Paragraph_Variable/root/listitem[@ID=$base]/item[@LV_name=$LV_name]">
			 			<xsl:variable name="pv" select="$Paragraph_Variable/root/listitem[@ID=$base]/item[@LV_name=$LV_name]"/>
			 			<xsl:call-template name="PV-Process">
			 				<xsl:with-param name="pv" select="$pv"/>
							<xsl:with-param name="current" select="$current"/>
			 			</xsl:call-template>
			 		</xsl:when>
			 		<xsl:when test="@rev != '' and $Paragraph_Variable/root/listitem[@ID=$rev]/item[@LV_name=$LV_name]">
						<xsl:variable name="pv" select="$Paragraph_Variable/root/listitem[@ID=$rev]/item[@LV_name=$LV_name]"/>
			 			<xsl:call-template name="PV-Process">
			 				<xsl:with-param name="pv" select="$pv"/>
							<xsl:with-param name="current" select="$current"/>
			 			</xsl:call-template>
			 		</xsl:when>
			 		<xsl:when test="@rev = '' and $Paragraph_Variable/root/listitem[@ID=$base]">
						<xsl:copy>
							<xsl:apply-templates select="@*"/>
						</xsl:copy>
			 		</xsl:when>
			 		<xsl:otherwise>
			 		</xsl:otherwise>
			 	</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="PV-Process">
		<xsl:param name="pv"/>
		<xsl:param name="current"/>
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:choose>
				<xsl:when test="string($pv)">
					<xsl:for-each select="$pv/node()">
						<xsl:choose>
							<xsl:when test="name()='image'">
								<xsl:variable name="href" select="ast:getFile(@href, '/')"/>
								<xsl:variable name="uri" select="$image-files[ast:getFile(@src, '/')=$href]/@uri"/>
								<xsl:variable name="image" select="substring-before($href, '.')"/>
								<xsl:variable name="CR-ID" select="$image_alt_contents/root/alt[@image=$image]/@lv-id"/>
								<xsl:if test="$uri != ''">
									<xsl:copy>
										<xsl:apply-templates select="$current/image[@href=$uri]/@*"/>
										<xsl:if test="@otherprops = 'alt:yes'">
											<xsl:attribute name="alt" select="$Language_Variable/root/listitem[@CR-ID=$CR-ID]/item[@LV_name=$LV_name][1]"/>
										</xsl:if>
									</xsl:copy>
								</xsl:if>
							</xsl:when>
							<xsl:when test="name()='varname' or name()='cmdname' or name()='apiname' or name()='ph' or name()='b'">
								<xsl:choose>
									<xsl:when test="@rev">
										<xsl:apply-templates select="."/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:copy>
											<xsl:apply-templates select="@*"/>
											<xsl:choose>
												<xsl:when test="name()='varname'">
													<xsl:attribute name="class">+ topic/keyword sw-d/varname </xsl:attribute>
												</xsl:when>
												<xsl:when test="name()='cmdname'">
													<xsl:attribute name="class">+ topic/keyword sw-d/cmdname </xsl:attribute>
												</xsl:when>
												<xsl:when test="name()='apiname'">
													<xsl:attribute name="class">+ topic/keyword pr-d/apiname </xsl:attribute>
												</xsl:when>
												<xsl:when test="name()='ph'">
													<xsl:attribute name="class">- topic/ph </xsl:attribute>
												</xsl:when>
												<xsl:when test="name()='b'">
													<xsl:attribute name="class">+ topic/ph hi-d/b </xsl:attribute>
												</xsl:when>
											</xsl:choose>
											<xsl:value-of select="."/>
										</xsl:copy>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="name()='xref'">
								<xsl:variable name="i" select="count(preceding-sibling::xref) + 1"/>
								<xsl:apply-templates select="$current/xref[$i]"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="href" select="ast:getFile(image/@href, '/')"/>
					<xsl:variable name="en-svg-name" select="ast:getFile($image-files[@uri=$href]/@src, '/')"/>
					<xsl:variable name="pv-svg-name" select="ast:getFile($pv/image/@href, '/')"/>
					<xsl:variable name="image" select="substring-before($href, '.')"/>
					<xsl:variable name="CR-ID" select="$image_alt_contents/root/alt[@image=$image]/@lv-id"/>
					<xsl:choose>
						<xsl:when test="$en-svg-name != $pv-svg-name">
							<xsl:copy>
								<xsl:attribute name="href" select="concat(ast:getPath($image-files[@uri=$href]/@src, '/'), '/', $pv-svg-name)"/>
								<xsl:apply-templates select="$current/image[@href=$href]/@* except ($current/image[@href=$href]/@href)"/>
								<xsl:if test="$current/image[@href=$href]/@otherprops = 'alt:yes'">
									<xsl:attribute name="alt" select="$Language_Variable/root/listitem[@CR-ID=$CR-ID]/item[@LV_name=$LV_name][1]"/>
								</xsl:if>
							</xsl:copy>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
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