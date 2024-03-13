<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs ast svg xlink"
    version="2.0">

	<xsl:variable name="locale" select="/map/@lang" />
	<xsl:variable name="LV_name" select="/map/@otherprops" />
	<xsl:variable name="mapId" select="/map/@id" />
	<xsl:variable name="pltf" select="/map/@platform" />
	<xsl:variable name="tvLV" select="document(concat(ast:getPath(base-uri(.), '/'), '/../../../../../_reference/LV/', 'Language_Variable.xml'))" />
	<xsl:variable name="ebtLV" select="document(concat(ast:getPath(base-uri(.), '/'), '/../../../../../_reference/LV/EBT/', 'Language_Variable.xml'))" />
  	<xsl:variable name="Language_Variable" select="if ($pltf = 'ebt') then $ebtLV else $tvLV" as="document-node()?"/>

    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="shortdesc title div li p cmd note"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="table">
		<xsl:variable name="table" select="."/>
		<xsl:variable name="tgroup" select="$table/tgroup"/>
		<xsl:variable name="thead" select="$tgroup/thead"/>
		<xsl:variable name="tbody" select="$tgroup/tbody"/>
		<table>
			<xsl:apply-templates select="@*" />
			<tgroup>
				<xsl:apply-templates select="$tgroup/@*"/>
				<xsl:apply-templates select="$tgroup/colspec"/>
				<xsl:apply-templates select="$thead"/>
				<tbody>
					<xsl:apply-templates select="$tbody/@*"/>
					<xsl:apply-templates select="$tbody/node()"/>
					<xsl:if test="following-sibling::node()[1][self::processing-instruction('pagebreak')] and following-sibling::node()[2][name()='table']">
						<xsl:call-template name="getRows">
							<xsl:with-param name="nextTable" select="following-sibling::node()[2]"/>
						</xsl:call-template>
					</xsl:if>
				</tbody>
			</tgroup>
		</table>
	</xsl:template>

	<xsl:template name="getRows">
		<xsl:param name="nextTable"/>
		<xsl:for-each select="$nextTable//tbody/row">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
		<xsl:if test="$nextTable/following-sibling::node()[1][self::processing-instruction('pagebreak')] and $nextTable/following-sibling::node()[2][name()='table']">
			<xsl:call-template name="getRows">
				<xsl:with-param name="nextTable" select="$nextTable/following-sibling::node()[2]"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template match="processing-instruction('pagebreak')">
	</xsl:template>

	<xsl:template match="table[preceding-sibling::node()[1][self::processing-instruction('pagebreak')] and preceding-sibling::node()[2][name()='table']]">
	</xsl:template>

	<xsl:template match="@outputclass">
		<xsl:choose>
			<xsl:when test=". = 'troubleshooting'">
				<xsl:attribute name="outputclass">troubleshooting</xsl:attribute>
			</xsl:when>
			<xsl:when test=". = 'bullet:hyphen'">
				<xsl:attribute name="class">hyphen</xsl:attribute>
			</xsl:when>
			<xsl:when test=". = 'number:circle'">
				<xsl:attribute name="class">number-circle</xsl:attribute>
			</xsl:when>
			<xsl:when test=". = 'number:none'">
				<xsl:attribute name="class">number-none</xsl:attribute>
			</xsl:when>
			<xsl:when test=". = 'cell:center'">
				<xsl:attribute name="class">cell-center</xsl:attribute>
			</xsl:when>
			<xsl:when test=". = 'index'">
				<xsl:attribute name="index">yes</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class" select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="map">
		<xsl:choose>
			<xsl:when test="$locale = 'ru-RU' and $LV_name = 'BUL'">
				<CategoryData lang="bg-BG" LV_name="{$LV_name}" platform="{$pltf}">
					<CategoryData>
						<xsl:apply-templates select="group" />
					</CategoryData>
				</CategoryData>
			</xsl:when>
			<xsl:otherwise>
				<CategoryData lang="{@lang}" LV_name="{$LV_name}" platform="{$pltf}">
					<CategoryData>
						<xsl:apply-templates select="group" />
					</CategoryData>
				</CategoryData>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="xref">
		<xsl:variable name="CR-ID" select="@rev"/>
		<span class="xref">
			<xsl:for-each select="node()[name()!='desc']">
				<xsl:choose>
					<xsl:when test="name()='ph' and @dir='ltr'">
						<span dir="ltr">
							<xsl:value-of select="."/>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="." />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<span class="tooltip">
				<span class="tool_text">
					<xsl:choose>
						<xsl:when test="$Language_Variable/root/listitem[@CR-ID=$CR-ID]/item[@LV_name=$LV_name][1]">
							<xsl:value-of select="$Language_Variable/root/listitem[@CR-ID=$CR-ID]/item[@LV_name=$LV_name][1]"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>Link</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</span>
			</span>
			<span class="see-page" btnidx="">
				<a href="{@href}"/>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="image[@placement='inline']">
		<xsl:variable name="src" select="ast:getFile(@src, '/')"/>
		<xsl:if test="preceding-sibling::node()[1][self::text()][.!='&#x20;'][not(ends-with(., '&#x20;'))]">
			<xsl:text>&#x20;</xsl:text>
		</xsl:if>
		<img>
			<xsl:if test="@otherprops='alt:yes'">
				<xsl:attribute name="alt" select="@alt" />
			</xsl:if>
			<xsl:choose>
				<xsl:when test="matches($mapId, '2022_project')">
					<xsl:attribute name="src" select="concat('../_common/images/content/', replace($src, '\.svg', '.png'))" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="src" select="concat('../_common/images/content/', $src)" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="class" select="if ( starts-with(ast:getFile(@src, '/'), 'btn_') ) then 'btn' else 'ico_img'" />
		</img>
	</xsl:template>

	<xsl:template match="image[@placement='break']">
		<xsl:variable name="src" select="ast:getFile(@src, '/')"/>
		<xsl:choose>
			<xsl:when test="starts-with(ast:getFile(@src, '/'), 'smart-ui')">
				<xsl:variable name="svg" select="document(replace(@src, '\.svg', '_tmp.svg'))" as="document-node()"/>
				<div id="{substring-before(ast:getFile(@src, '/'), '.svg')}">
					<xsl:for-each select="$svg/svg:svg//svg:text">
						<xsl:variable name="i" select="position()"/>
						<xsl:variable name="CR-ID" select="@id"/>
						<div id="{concat('menu', $i)}">
							<p>
								<xsl:for-each select="svg:tspan">
									<xsl:variable name="tspan" select="if ( $Language_Variable/root/listitem[@CR-ID=$CR-ID]/item[@LV_name=$LV_name][1] )
																	   then $Language_Variable/root/listitem[@CR-ID=$CR-ID]/item[@LV_name=$LV_name][1]
																	   else ."/>
									<xsl:value-of select="$tspan"/>
									<xsl:if test="following-sibling::svg:tspan">
										<xsl:text>&#x20;</xsl:text>
									</xsl:if>
								</xsl:for-each>
							</p>
						</div>
					</xsl:for-each>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<img>
					<xsl:if test="@otherprops='alt:yes'">
						<xsl:attribute name="alt" select="@alt" />
					</xsl:if>
					<xsl:choose>
						<xsl:when test="matches($mapId, '2022_project')">
							<xsl:attribute name="src" select="concat('../_common/images/content/', replace($src, '\.svg', '.png'))" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="src" select="concat('../_common/images/content/', $src)" />
						</xsl:otherwise>
					</xsl:choose>
					<xsl:attribute name="class" select="'break'" />
				</img>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="apiname">
		<span class="trynow_tooltip">
			<span class="tool_text">
				<xsl:value-of select="."/>
			</span>
		</span>
		<span>
			<xsl:attribute name="btnidx" select="''" />
			<xsl:attribute name="class" select="if ( @outputclass = 'invisible' ) then 'C_TryNow-Invisible' else 'C_TryNow'" />
			<xsl:attribute name="id"><xsl:value-of select="generate-id()" /></xsl:attribute>
			<xsl:attribute name="data-trynow"><xsl:value-of select="@otherprops" /></xsl:attribute>
		</span>
	</xsl:template>

	<xsl:template name="ltor">
		<xsl:if test="matches(substring-before($locale, '-'), 'ar|he|fa') and ( @dir = 'ltr' or contains(., '+') or matches(., '\d+\s*x\s*\d+') )">
			<xsl:attribute name="dir">ltr</xsl:attribute>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cmdname">
		<span class="cmdname">
			<xsl:apply-templates select="@outputclass" />
			<xsl:call-template name="ltor"/>
			<xsl:apply-templates select="node()" />
		</span>
	</xsl:template>

	<xsl:template match="varname">
		<span class="varname">
			<xsl:apply-templates select="@outputclass" />
			<xsl:call-template name="ltor"/>
			<xsl:apply-templates select="node()" />
		</span>
	</xsl:template>

	<xsl:template match="ph">
		<span>
			<xsl:apply-templates select="@outputclass" />
			<xsl:call-template name="ltor"/>
			<xsl:apply-templates select="node()" />
		</span>
	</xsl:template>

	<xsl:template match="b">
		<b>
			<xsl:call-template name="ltor"/>
			<xsl:apply-templates select="node()" />
		</b>
	</xsl:template>

	<xsl:template match="i">
		<i>
			<xsl:call-template name="ltor"/>
			<xsl:apply-templates select="node()" />
		</i>
	</xsl:template>

	<xsl:template match="u">
		<u>
			<xsl:call-template name="ltor"/>
			<xsl:apply-templates select="node()" />
		</u>
	</xsl:template>

	<xsl:template match="concept | task | reference">
		<xsl:variable name="level" select="count(ancestor::*)" />
		<xsl:choose>
			<xsl:when test="$level = 2">
				<chapter>
					<xsl:call-template name="icon"/>
					<xsl:call-template name="title"/>
					<xsl:call-template name="description"/>
					<xsl:apply-templates select="* except (title, abstract)"/>
				</chapter>
			</xsl:when>
			<xsl:when test="$level = 3">
				<xsl:choose>
					<xsl:when test="title[@outputclass='Subchapter']">
						<subchapter>
							<xsl:call-template name="icon"/>
							<xsl:call-template name="title"/>
							<xsl:call-template name="description"/>
							<xsl:for-each select="*[@url]">
								<page>
									<xsl:attribute name="url" select="concat(@url, '.html')" />
									<xsl:attribute name="style">Heading1</xsl:attribute>
									<xsl:call-template name="title"/>
									<xsl:attribute name="id" select="@url"/>
									<xsl:call-template name="description"/>
									<xsl:if test="ancestor-or-self::*[matches(name(), '^(concept|task|reference)$')][@search='no']">
										<xsl:attribute name="search">no</xsl:attribute>
									</xsl:if>
									<div class="heading1">
										<xsl:apply-templates select="title" />
										<div class="real-con">
											<xsl:apply-templates select="* except title" />
										</div>
									</div>
								</page>
							</xsl:for-each>
						</subchapter>
					</xsl:when>
					<xsl:otherwise>
						<page>
							<xsl:attribute name="url" select="concat(@url, '.html')" />
							<xsl:attribute name="style">Heading1</xsl:attribute>
							<xsl:call-template name="title"/>
							<xsl:attribute name="id" select="@url"/>
							<xsl:call-template name="description"/>
							<xsl:if test="ancestor-or-self::*[matches(name(), '^(concept|task|reference)$')][@search='no']">
								<xsl:attribute name="search">no</xsl:attribute>
							</xsl:if>
							<div class="heading1">
								<xsl:apply-templates select="title" />
								<div class="real-con">
									<xsl:apply-templates select="* except title" />
								</div>
							</div>
						</page>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<section>
					<xsl:attribute name="id" select="@url"/>
					<xsl:attribute name="style">
						<xsl:value-of select="if (ancestor::*[parent::group]/*[@url]/title[@outputclass='Subchapter']) then concat('Heading', $level - 3) else concat('Heading', $level - 2)" />
					</xsl:attribute>
					<xsl:attribute name="title">
						<xsl:value-of select="title" />
					</xsl:attribute>
					<xsl:apply-templates select="*" />
				</section>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="section | conbody | taskbody | refbody | abstract | info | result">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="option">
		<i>
			<xsl:apply-templates />
		</i>
	</xsl:template>

	<xsl:template match="substeps">
		<xsl:choose>
			<xsl:when test="@outputclass='bullet' or ancestor::steps-unordered">
				<ul>
					<xsl:apply-templates select="@* | node()" />
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<ol>
					<xsl:apply-templates select="@* | node()" />
				</ol>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="steps">
		<xsl:variable name="current" select="."/>
		<xsl:choose>
			<xsl:when test="count(step) &gt; 1">
				<xsl:for-each-group select="*" group-adjacent="boolean(self::step[not(@outputclass='number:none')])">
					<xsl:choose>
						<xsl:when test="current-grouping-key()">
							<xsl:choose>
								<xsl:when test="$current/@outputclass='bullet'">
									<ul>
										<xsl:apply-templates select="$current/@*" />
										<xsl:apply-templates select="current-group()" />
									</ul>
								</xsl:when>
								<xsl:otherwise>
									<ol>
										<xsl:apply-templates select="$current/@*" />
										<xsl:apply-templates select="current-group()" />
									</ol>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="current-group()" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each-group>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="step/node()" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="steps-unordered">
		<xsl:variable name="current" select="."/>
		<xsl:for-each-group select="*" group-adjacent="boolean(self::step)">
			<xsl:choose>
				<xsl:when test="current-grouping-key()">
					<ul>
						<xsl:apply-templates select="$current/@*" />
						<xsl:apply-templates select="current-group()" />
					</ul>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="current-group()" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each-group>
	</xsl:template>

	<xsl:template match="stepsection">
		<xsl:choose>
			<xsl:when test="p">
				<xsl:apply-templates />
			</xsl:when>
			<xsl:otherwise>
				<p>
					<xsl:apply-templates select="@* | node()" />
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="step | substep">
		<xsl:choose>
			<xsl:when test="@outputclass='number:none'">
				<ul class="none">
					<li>
						<xsl:apply-templates select="@* | node()" />
					</li>
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<li>
					<xsl:apply-templates select="@* | node()" />
				</li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="cmd">
		<p>
			<xsl:apply-templates select="@* | node()" />
		</p>
	</xsl:template>

	<xsl:template match="p">
		<xsl:choose>
			<xsl:when test="@outputclass = 'menu'">
				<p class="menu">
					<xsl:apply-templates select="@* | node()" />
				</p>
			</xsl:when>
			<xsl:when test="parent::info">
				<p>
					<xsl:apply-templates select="@* | node()" />
				</p>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@* | node()" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="shortdesc">
		<xsl:choose>
			<xsl:when test="parent::*/parent::*/parent::concept[parent::map]">
				<div class="shortdesc">
					<xsl:apply-templates />
				</div>
			</xsl:when>
			<xsl:otherwise>
				<p class="shortdesc">
					<xsl:attribute name="class" select="if ( @outputclass = 'Subchapter-Info' ) then 'subchapter shortdesc' else 'shortdesc' "/>
					<xsl:apply-templates />
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="note">
		<ul>
			<xsl:if test="@type">
				<xsl:attribute name="class" select="if ( @outputclass = 'remote') then 'note-remote' else @type" />
			</xsl:if>
			<li>
				<xsl:apply-templates select="@* | node()" />
			</li>
		</ul>
	</xsl:template>

	<xsl:template match="title">
		<xsl:variable name="level" select="count(ancestor::*)" />
		<xsl:variable name="HName">
			<xsl:value-of select="if (ancestor::*[parent::map]/*[@url]/title[@outputclass='Subchapter']) then concat('h', $level - 4) else concat('h', $level - 3)" />
		</xsl:variable>
		<xsl:variable name="HClass">
			<xsl:value-of select="if (ancestor::*[parent::map]/*[@url]/title[@outputclass='Subchapter']) then concat('Heading', $level - 4) else concat('Heading', $level - 3)" />
		</xsl:variable>

		<xsl:element name="{$HName}">
			<xsl:attribute name="class" select="$HClass"/>
			<xsl:attribute name="id" select="@id"/>
			<xsl:apply-templates select="@outputclass"/>
			<xsl:apply-templates select="node()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="title/b">
		<xsl:apply-templates select="node()"/>
	</xsl:template>

    <xsl:template match="text()" priority="10">
    	<xsl:choose>
    		<xsl:when test="parent::*[matches(name(), '^(shortdesc|title|div|li|p|cmd|note)$')] and not(preceding-sibling::node())">
    			<xsl:value-of select="replace(replace(., '^\s+', ''), '\s+', '&#x20;')"/>
    		</xsl:when>
    		<xsl:when test="parent::*[matches(name(), '^(shortdesc|title|div|li|p|cmd|note)$')] and not(following-sibling::node())">
    			<xsl:value-of select="replace(replace(., '\s+$', ''), '\s+', '&#x20;')"/>
    		</xsl:when>
    		<xsl:otherwise>
    			<xsl:value-of select="replace(., '\s+', '&#x20;')"/>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

	<!-- Here I am -->
    <xsl:template name="icon">
		<xsl:attribute name="icon" select="descendant-or-self::title[1]/@icon" />
    </xsl:template>

    <xsl:template name="title">
		<xsl:attribute name="title">
			<xsl:variable name="title" select="normalize-space(descendant-or-self::title[1])" />
			<xsl:choose>
				<xsl:when test="matches(substring-before($locale, '-'), 'ar|he|fa')">
					<xsl:analyze-string select="$title" regex="Anynet\+ \(HDMI\-CEC\)">
						<xsl:matching-substring>
							<xsl:value-of select="concat('_s_ltor__', ., '_e_ltor__‎')"/>
						</xsl:matching-substring>
						<xsl:non-matching-substring>
							<xsl:value-of select="."/>
						</xsl:non-matching-substring>
					</xsl:analyze-string>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$title"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
    </xsl:template>

    <xsl:template name="description">
		<xsl:attribute name="description" select="normalize-space(descendant-or-self::abstract[1]/shortdesc)" />
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