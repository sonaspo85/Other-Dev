<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/"
	xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
	xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
	exclude-result-prefixes="xs ast aid aid5">

	<xsl:param name="framewidth" select="number(translate('180mm', 'm', '')) * 2.83465" />
    <xsl:key name="uniques" match="*[starts-with(@id, 'unique_')]" use="@id" />
	<xsl:output method="xml" version="1.0" indent="no" encoding="UTF-8" />
	<xsl:strip-space elements="*" />
    <xsl:preserve-space elements="title li p cmd note xref"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="@src">
		<xsl:attribute name="src">
			<xsl:choose>
				<xsl:when test="starts-with(., 'smart-ui-')">
					<xsl:value-of select="replace(., '\.svg', '.ai')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="image" mode="break">
		<xsl:text>&#xA;&#x9;</xsl:text>
		<xsl:copy>
			<xsl:apply-templates select="@* except (@otherprops, @placement)" />
			<xsl:attribute name="placement">break</xsl:attribute>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="image[@placement='inline']">
		<xsl:if test="preceding-sibling::node()[1][self::text()][.!='&#x20;'][not(ends-with(., '&#x20;'))]">
			<xsl:text>&#x20;</xsl:text>
		</xsl:if>
		<xsl:copy>
			<xsl:apply-templates select="@* except (@otherprops, @placement)" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="note">
		<xsl:choose>
			<xsl:when test="p">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(ancestor::entry)">
					<xsl:text>&#xA;&#x9;</xsl:text>
				</xsl:if>
				<p>
					<xsl:attribute name="pstyle">
						<xsl:choose>
							<xsl:when test="parent::info and ancestor::*[3][name()='substeps'] and ancestor::*[5][name()='steps-unordered']">UnorderList_2-Hyp-Note</xsl:when>
							<xsl:when test="parent::li and ancestor::*[2][name()='ul'] and ancestor::*[4][name()='ul']">UnorderList_2-Hyp-Note</xsl:when>
							<xsl:when test="parent::info and ancestor::substeps[@outputclass='bullet']">UnorderList_1-Child-Note</xsl:when>
							<xsl:when test="ancestor::*[2][name()='ol'] and ancestor::*[5][name()='steps-unordered']">UnorderList_2-Child-Note</xsl:when>
							<xsl:when test="ancestor::*[2][name()='ol']">OrderList1_1-Note</xsl:when>
							<xsl:when test="parent::li and ancestor::ul[@outputclass='bullet:hyphen'] and ancestor::*[5][name()='steps-unordered']">UnorderList_2-Child-Note</xsl:when>
							<xsl:when test="parent::li and ancestor::ul[@outputclass='steps-subbullet']">UnorderList_2-Child-Note</xsl:when>
							<xsl:when test="parent::stepsection or ancestor::steps-unordered[@outputclass='div-step']">UnorderList_1-Note</xsl:when>
							<xsl:when test="parent::li or ancestor::steps-unordered">UnorderList_1-Child-Note</xsl:when>
							<xsl:when test="parent::info and ancestor::steps[@outputclass='number:circle']">UnorderList_1-Note</xsl:when>
							<xsl:when test="parent::info and (count(ancestor::*[3][name()='steps']/step) eq 1)">
								<xsl:value-of select="if ( not(ancestor::*[2][name()='step']/preceding-sibling::step) ) then 'UnorderList_1-Note' else 'UnorderList_1-Note-Desc'"/>
							</xsl:when>
							<!-- 아래 8페이지로 인해 수정 Using Screen Sharing (Tap View) 참조 -->
							<xsl:when test="parent::info and ancestor::*[2][name()='step']">
								<xsl:value-of select="if ( not(ancestor::*[2][name()='step']/preceding-sibling::step) ) then 'OrderList1_1-Note' else 'OrderList2_1-Note'"/>
							</xsl:when>
							<xsl:when test="@type = 'warning'">Warning</xsl:when>
							<xsl:when test="ancestor::tbody">Description-Cell-Note</xsl:when>
							<xsl:otherwise>UnorderList_1-Note</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:apply-templates select="@* except (@type)" />
					<xsl:apply-templates select="node()" />
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="title">
		<xsl:variable name="level" select="count(ancestor::*)" />
		<xsl:text>&#xA;&#x9;</xsl:text>
		<p>
			<xsl:attribute name="pstyle">
				<xsl:choose>
					<xsl:when test="$level = 2">Chapter</xsl:when>
					<xsl:when test="@outputclass='Subchapter'">Subchapter</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="if ( ancestor::*/title/@outputclass='Subchapter' ) then concat('Heading', $level - 3) else concat('Heading', $level - 2)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates select="@* | node()" />
		</p>
	</xsl:template>

	<xsl:template match="shortdesc">
		<xsl:text>&#xA;&#x9;</xsl:text>
		<p>
			<xsl:attribute name="pstyle">
				<xsl:choose>
					<xsl:when test="count(parent::abstract/ancestor::*) = 2">Chapter-Info</xsl:when>
					<xsl:when test="count(parent::abstract/ancestor::*) = 3">Heading1-Info</xsl:when>
					<xsl:when test="count(parent::abstract/ancestor::*) = 4">Heading1-Info</xsl:when>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates select="@* | node()" />
		</p>
	</xsl:template>
	<!-- iM 수정 -->
	<xsl:template match="stepsection[parent::steps]">
		<xsl:text>&#xA;&#x9;</xsl:text>
		<xsl:apply-templates select="@* | node()" />
	</xsl:template>
	<xsl:template match="stepsection[parent::steps-unordered]">
		<xsl:text>&#xA;&#x9;</xsl:text>
		<xsl:apply-templates select="node()" />
		<!-- <p>
			<xsl:attribute name="pstyle">Description</xsl:attribute>
			<xsl:apply-templates select="node()" />
		</p> -->
	</xsl:template>

	<xsl:template match="p[count(node()) = 1 and image]" priority="1">
		<xsl:apply-templates select="image" mode="break"/>
	</xsl:template>

	<xsl:template match="p">
		<xsl:if test="not(ancestor::entry)">
			<xsl:text>&#xA;&#x9;</xsl:text>
		</xsl:if>
		<p>
			<xsl:choose>
				<xsl:when test="parent::entry[@align='center']">
					<xsl:attribute name="pstyle">Description-Center-Cell</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::info and ancestor::*[3][name()='substeps'] and ancestor::*[5][name()='steps-unordered']">
					<xsl:attribute name="pstyle">UnorderList_2-Child</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::li and ancestor::*[2][name()='ul'] and ancestor::*[4][name()='substep']">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(preceding-sibling::p) ) then 'UnorderList_2-Hyp' else 'UnorderList_2-Hyp-Child'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::li and ancestor::*[2][name()='ul'][@outputclass='bullet:hyphen'] and ancestor::*[5][name()='steps-unordered']">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(preceding-sibling::p) ) then 'UnorderList_2-Hyp' else 'UnorderList_2-Hyp-Child'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::*[2][name()='ul'] and ancestor::*[4][name()='ul'][@outputclass='bullet:hyphen'] and ancestor::*[7][name()='steps-unordered']">
					<xsl:attribute name="pstyle">UnorderList_3</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::*[2][name()='ul'][@outputclass='bullet:hyphen'] and ancestor::*[4][name()='ul']">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(preceding-sibling::p) and  ends-with(., ':') ) then 'UnorderList_2-Hyp' else 'UnorderList_2-Hyp-Child'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::*[2][name()='ul'][@outputclass='steps-subbullet']">
					<xsl:attribute name="pstyle">UnorderList_2</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::li and ancestor::*[2][name()='ul'] and ancestor::*[4][name()='ul']">
					<xsl:attribute name="pstyle">UnorderList_2-Hyp</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::*[2][name()='ol'][@outputclass='suborderlist']">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(parent::li/preceding-sibling::li) ) then 'OrderList_1_1_Paren' else 'OrderList_2_1_Paren'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::li/preceding-sibling::li and ancestor::*[2][name()='ol'] and ancestor::*[5][name()='steps-unordered']">
				<xsl:attribute name="pstyle">OrderList2_2</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::*[2][name()='ol']">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(parent::li/preceding-sibling::li) ) then 'OrderList1_1' else 'OrderList2_1'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::info and ancestor::substeps[@outputclass='bullet']">
					<xsl:attribute name="pstyle">UnorderList_1-Child</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::info and ancestor::steps-unordered[@outputclass='div-step']">
					<xsl:attribute name="pstyle">Description</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::info and ancestor::steps-unordered">
					<xsl:attribute name="pstyle">UnorderList_1-Child</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::*[3][name()='section']">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(preceding-sibling::p) ) then 'UnorderList_1' else 'UnorderList_1-Child'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="@outputclass='menu'">
					<xsl:attribute name="pstyle">Description-navi</xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='p' and parent::note[@type='warning']">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(preceding-sibling::p) ) then 'Warning' else 'Warning_Child'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::note and (preceding-sibling::p) and ancestor::*[3][name()='step'] and ancestor::*[4][name()='steps']">
					<xsl:attribute name="pstyle">UnorderList_2-Note_Child</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::note and ancestor::*[3][name()='step'] and ancestor::*[4][name()='steps']">
					<xsl:attribute name="pstyle">	
						<xsl:value-of select="if ( not(ancestor::*[3][name()='step']/preceding-sibling::step) ) then 'OrderList1_1-Note' else 'OrderList2_1-Note'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='p' and parent::note">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(preceding-sibling::p) ) then 'UnorderList_1-Note' else 'UnorderList_1-Note-Desc'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::thead">
					<xsl:attribute name="pstyle">Description-Center</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::entry and @outputclass='align-left'">
					<xsl:attribute name="pstyle">Description-Cell</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::table/@outputclass = 'cell:center'">
					<xsl:attribute name="pstyle">Description-Center-Cell</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::tbody">
					<xsl:attribute name="pstyle">Description-Cell</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::li and (count(ancestor::*[4][name()='step']) eq 1)">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(preceding-sibling::p) ) then 'UnorderList_1' else 'UnorderList_1-Child'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::li and ancestor::*[2][name()='ul']">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(preceding-sibling::p) ) then 'UnorderList_1' else 'UnorderList_1-Child'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="pstyle">Description</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="@* except (@type, @outputclass)" />
			<xsl:apply-templates select="node()" />
		</p>
	</xsl:template>

	<xsl:template match="xref">
		<xsl:variable name="href" select="key('uniques', substring-after(@href, '#'))/title/@id" />
		<xsl:copy>
			<xsl:attribute name="self" select="concat('self', generate-id())" />
			<xsl:attribute name="dest" select="$href" />
			<xsl:apply-templates select="@* except (@type, @href)" />
			<xsl:apply-templates select="node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="desc">
	</xsl:template>

	<xsl:template match="ph | b | cmdname | varname | apiname">
		<xsl:if test="preceding-sibling::node()[1][name()='image']">
			<xsl:text>&#x20;</xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="name()='ph'">
				<xsl:choose>
					<xsl:when test="@dir = 'ltr' and .='Anynet+ (HDMI-CEC)'">
						<ph>
							<xsl:attribute name="cstyle">C_Font-Left2Right</xsl:attribute>
							<xsl:apply-templates />
						</ph>
					</xsl:when>
					<xsl:when test="@outputclass='no-trans'">
						<ph>
							<xsl:if test="@dir = 'ltr'">
								<xsl:attribute name="dir">ltr</xsl:attribute>
							</xsl:if>
							<xsl:attribute name="cstyle">C_Font-no-trans</xsl:attribute>
							<xsl:apply-templates />
						</ph>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<ph>
					<xsl:choose>
						<xsl:when test="name()='b'">
							<xsl:attribute name="cstyle">C_Important</xsl:attribute>
						</xsl:when>
						<xsl:when test="name()='cmdname'">
							<xsl:attribute name="cstyle">
								<xsl:value-of select="if ( @dir = 'ltr' and .='Anynet+ (HDMI-CEC)' ) then 'Iword-Left2Right' else 'Iword'"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:when test="name()='varname'">
							<xsl:attribute name="cstyle">C_Engraved</xsl:attribute>
						</xsl:when>
						<xsl:when test="name()='apiname'">
							<xsl:attribute name="cstyle">
								<xsl:value-of select="if ( @outputclass = 'invisible' ) then 'C_TryNow-Invisible' else 'C_TryNow'"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates />
				</ph>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="cmd">
		<xsl:if test="not(ancestor::entry)">
			<xsl:text>&#xA;&#x9;</xsl:text>
		</xsl:if>
		<p>
			<xsl:choose>
				<xsl:when test="ancestor::*[2][name()='substeps'][@outputclass='bullet']">
					<xsl:attribute name="pstyle">UnorderList_1</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::substep and ancestor::*[3][name()='step'] and ancestor::steps[@outputclass='number:circle']">
					<xsl:attribute name="pstyle">
						<xsl:value-of select="if ( not(parent::substep/preceding-sibling::substep) ) then 'OrderList1_1' else 'OrderList2_1'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="parent::substep and ancestor::*[4][name()='steps-unordered']">
					<xsl:attribute name="pstyle">UnorderList_2-Hyp</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::steps[@outputclass='number:circle']">
					<xsl:variable name="i" select="count(parent::step/preceding-sibling::step) - count(parent::step/preceding-sibling::step[@outputclass='number:none']) + 1"/>
					<xsl:attribute name="pstyle">
						<xsl:choose>
							<xsl:when test="parent::step[@outputclass='number:none']">UnorderList_c_none</xsl:when>
							<xsl:when test="$i = 1">UnorderList_c1</xsl:when>
							<xsl:when test="$i = 2">UnorderList_c2</xsl:when>
							<xsl:when test="$i = 3">UnorderList_c3</xsl:when>
							<xsl:when test="$i = 4">UnorderList_c4</xsl:when>
							<xsl:when test="$i = 5">UnorderList_c5</xsl:when>
							<xsl:when test="$i = 6">UnorderList_c6</xsl:when>
							<xsl:when test="$i = 7">UnorderList_c7</xsl:when>
							<xsl:when test="$i = 8">UnorderList_c8</xsl:when>
							<xsl:when test="$i = 9">UnorderList_c9</xsl:when>
						</xsl:choose>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::*[2][name()='steps']">
					<xsl:choose>
						<xsl:when test="count(ancestor::steps/step) = 1">
							<xsl:attribute name="pstyle">Description</xsl:attribute>
						</xsl:when>
						<xsl:when test="not(parent::step/preceding-sibling::step)">
							<xsl:attribute name="pstyle">OrderList1_1</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="pstyle">OrderList2_1</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="ancestor::*[2][name()='steps-unordered'][@outputclass='div-step']">
					<xsl:attribute name="pstyle">Empty-Center</xsl:attribute>
				</xsl:when>
				<xsl:when test="ancestor::*[2][name()='steps-unordered']">
					<xsl:attribute name="pstyle">UnorderList_1</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="pstyle">Description</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="@*" />
			<xsl:choose>
				<xsl:when test="parent::step[@outputclass='number:none']"></xsl:when>
				<xsl:when test="parent::step/parent::steps[@outputclass='number:circle']"></xsl:when>
			</xsl:choose>
			<xsl:apply-templates select="node()" />
		</p>
	</xsl:template>
	
    <xsl:template match="processing-instruction('pagebreak')">
    	<xsl:text>&#xA;&#x9;</xsl:text>
    	<xsl:copy/>
    </xsl:template>

    <xsl:template match="processing-instruction('linebreak')">
		<xsl:text>&#xA;&#x9;</xsl:text>
    	<xsl:copy/>
    </xsl:template>

	<xsl:template match="map">
		<xsl:text>&#xA;</xsl:text>
		<Document DOMVersion="7.5" Self="d" lang="{@lang}">
			<xsl:apply-templates />
			<xsl:text>&#xA;</xsl:text>
		</Document>
	</xsl:template>

	<xsl:template match="step[@outputclass='pagebreak']">
		<xsl:text>&#xA;&#x9;</xsl:text>
		<xsl:processing-instruction name="pagebreak"/>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="li">
		<xsl:choose>
			<xsl:when test="@outputclass='pagebreak'">
				<xsl:processing-instruction name="pagebreak"/>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="p">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(ancestor::entry)">
					<xsl:text>&#xA;&#x9;</xsl:text>
				</xsl:if>
				<p>
					<xsl:choose>
						<xsl:when test="parent::ul[@outputclass='bullet:hyphen'] and ancestor::note">
							<xsl:attribute name="pstyle">UnorderList_2-Hyp_gray</xsl:attribute>
						</xsl:when>
						<xsl:when test="parent::ul[@outputclass='bullet:hyphen'] and ancestor::*[2][matches(name(), 'section|result|abstract')]">
							<xsl:attribute name="pstyle">UnorderList_1-Hyp</xsl:attribute>
						</xsl:when>
						<xsl:when test="parent::ul[@outputclass='bullet:hyphen'] and ancestor::substep">
							<xsl:attribute name="pstyle">UnorderList_2-Hyp</xsl:attribute>
						</xsl:when>
						<xsl:when test="parent::ul[@outputclass='bullet:hyphen'] and ancestor::steps">
							<xsl:attribute name="pstyle">UnorderList_2-Hyp</xsl:attribute>
						</xsl:when>
						<xsl:when test="parent::ol[@outputclass='suborderlist']">
							<xsl:attribute name="pstyle">
								<xsl:value-of select="if ( not(preceding-sibling::li) ) then 'OrderList_1_1_Paren' else 'OrderList_2_1_Paren'"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:when test="parent::ol and ancestor::*[4][name()='steps-unordered']">
							<xsl:attribute name="pstyle">
								<xsl:value-of select="if ( not(preceding-sibling::li) ) then 'OrderList1_2' else 'OrderList2_2'"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:when test="parent::ol">
							<xsl:attribute name="pstyle">
								<xsl:value-of select="if ( not(preceding-sibling::li) ) then 'OrderList1_1' else 'OrderList2_1'"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:when test="ancestor::*[2][name()='li']">
							<xsl:attribute name="pstyle">UnorderList_2-Hyp</xsl:attribute>
						</xsl:when>
						<xsl:when test="ancestor::tbody">
							<xsl:attribute name="pstyle">Description-Cell-UnorderList</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="pstyle">UnorderList_1</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates />
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="concept | task | reference | section | abstract | info | steps | step | substeps | substep | result | taskbody | conbody | refbody | ul | ol | steps-unordered">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="table">
		<xsl:variable name="rows" select="count(current()//row)" as="xs:integer"/>
		<xsl:variable name="cols" select="tgroup/@cols" as="xs:integer"/>
		<xsl:variable name="seq" as="xs:float*">
			<xsl:for-each select="tgroup/colspec/@colwidth">
				<xsl:sequence select="xs:float(substring-before(., '*'))"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="width" select="sum($seq)" as="xs:float"/>

		<xsl:variable name="table">
			<Table>
				<xsl:attribute name="HeaderRowCount">1</xsl:attribute>
				<xsl:attribute name="FooterRowCount">0</xsl:attribute>
				<xsl:attribute name="BodyRowCount" select="$rows - 1"/>
				<xsl:attribute name="ColumnCount" select="$cols"/>
				<xsl:attribute name="AppliedTableStyle">TableStyle/Table_Description-C</xsl:attribute>
				<xsl:attribute name="TableDirection">
					<xsl:choose>
						<xsl:when test="matches(substring-before(/map/@lang, '-'), 'ar|he|fa')">RightToLeftDirection</xsl:when>
						<xsl:otherwise>LeftToRightDirection</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>

				<xsl:for-each select="current()//row">
					<xsl:variable name="rowNum" select="position() - 1"/>
					<Row Name="{$rowNum}"/>
				</xsl:for-each>

				<xsl:for-each select="tgroup/colspec">
					<xsl:variable name="colNum" select="position() - 1"/>
					<xsl:variable name="colWidth" select="xs:float(substring-before(@colwidth, '*'))" as="xs:float"/>
					<Column Name="{$colNum}" SingleColumnWidth="{$colWidth div $width * $framewidth}"/>
				</xsl:for-each>

				<xsl:apply-templates select="current()//entry" />

			</Table>
		</xsl:variable>
		<xsl:text>&#xA;&#x9;</xsl:text>
		<xsl:copy-of select="$table"/>
	</xsl:template>

	<xsl:template match="entry">
        <Cell>
			<xsl:attribute name="HeaderRowCount">1</xsl:attribute>
			<xsl:attribute name="Name" select="concat(@x - 1, ':', @y - 1)"/>
			<xsl:attribute name="RowSpan" select="if (@morerows) then @morerows + 1 else 1"/>
			<xsl:attribute name="ColumnSpan">1</xsl:attribute>
			<xsl:attribute name="AppliedCellStyle">
				<xsl:choose>
					<xsl:when test="ancestor::thead">CellStyle/Cell_TableHead-Fill</xsl:when>
					<xsl:when test="ancestor::tbody">CellStyle/Cell_Description-S</xsl:when>
					<xsl:otherwise>CellStyle/$ID/[None]</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="AppliedCellStylePriority">
				<xsl:choose>
					<xsl:when test="ancestor::thead">9</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:if test="@outputclass='no-margin'">
				<xsl:attribute name="TopInset">0</xsl:attribute>
				<xsl:attribute name="LeftInset">0</xsl:attribute>
				<xsl:attribute name="BottomInset">0</xsl:attribute>
				<xsl:attribute name="RightInset">0</xsl:attribute>
			</xsl:if>
			<xsl:if test="@valign='top'">
				<xsl:attribute name="VerticalJustification">TopAlign</xsl:attribute>
			</xsl:if>
	        <xsl:apply-templates select="node()" />
	    </Cell>
	</xsl:template>

</xsl:stylesheet>