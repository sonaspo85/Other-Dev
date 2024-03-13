<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	<xsl:character-map name="tag">
		<xsl:output-character character='&lt;' string="&#8269;"/>
		<xsl:output-character character='&gt;' string="&#8268;"/>
	</xsl:character-map>
	
	<xsl:output method="xml" encoding="UTF-8" indent="no" use-character-maps="tag" />
	<xsl:strip-space elements="*"/>

	<xsl:variable name="lang" select="body/@language" />


    <!--<xsl:template match="/">
		<xsl:variable name="first">
			<xsl:apply-templates mode="abc"/>
        </xsl:variable>

		<xsl:apply-templates select="$first/node()" />
	</xsl:template>

	<xsl:template match="Root" mode="abc">
		<chapter>
			<xsl:apply-templates select="@*, node()" mode="abc" />
        </chapter>
    </xsl:template>

	<xsl:template match="@* | node()" mode="abc">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" mode="abc" />
		</xsl:copy>
	</xsl:template>-->
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="chapter[descendant::*[matches(@style, '(Cover_Heading|Heading\d_Forword)')]]">
    </xsl:template>

	<xsl:template match="chapter">
		<xsl:variable name="title-define">
			<CHAPTER_TITLE>
				<!--<xsl:value-of select="substring-after(descendant::*[matches(@style, '^Chapter$')][1]/node(), '&#x9;')" />-->
				<xsl:value-of select="descendant::*[matches(@style, '^Chapter_Con$')][1]/node()" />
			</CHAPTER_TITLE>
        </xsl:variable>
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:attribute name="filename" select="replace($title-define, ' ', '_')" />
			<xsl:copy-of select="$title-define" />
			<xsl:apply-templates select="node()" />
        </xsl:copy>
    </xsl:template>
	
	<xsl:template match="Story">
		<xsl:choose>
			<xsl:when test="*[matches(@style, '^TOC\d$|^Chapter$|Chapter_Con|Chapter_Number|Chapter_info')]">
        	</xsl:when>

			<xsl:otherwise>
				<xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
	
	<xsl:template match="para">
		<xsl:choose>
			<xsl:when test="matches(@style, '[_-]Child')">
				<xsl:element name="p">
					<xsl:apply-templates select="@*, node()" />
				</xsl:element>
        	</xsl:when>

			<xsl:when test="matches(@style, 'Empty\d') and 
					  		not(child::*) and 
					  		text()">
				<xsl:element name="p">
					<xsl:attribute name="class" select="'Description'" />
					<xsl:apply-templates select="@* except @class" />
					<xsl:apply-templates select="node()" />
				</xsl:element>
				<xsl:apply-templates />
			</xsl:when>
			
			<xsl:when test="matches(@style, 'Empty\d')">
				<xsl:apply-templates />
            </xsl:when>

			<xsl:when test="count(node()) = 1 and Image">
				<xsl:apply-templates />
            </xsl:when>
			
			<xsl:when test="count(node()) = 1 and 
					  		count(span/node()) = 1 and 
					  		span/Image">
				<xsl:apply-templates select="span/Image" />
			</xsl:when>

			<xsl:otherwise>
				<xsl:element name="p">
					<xsl:apply-templates select="@*, node()" />
				</xsl:element>
            </xsl:otherwise>
    	</xsl:choose>
    </xsl:template>
	
	<xsl:template match="@style">
		<xsl:choose>
			<xsl:when test="matches(., '^OrderList\d_\d_Hyp$')">
				<xsl:attribute name="class" select="'UnorderList1_Hyp'" />
				<xsl:attribute name="ori_class" select="." />
        	</xsl:when>

			<xsl:when test="matches(., '^Heading2$') and $lang = 'Korean'">
				<xsl:attribute name="class" select="'Heading2-square'" />
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:attribute name="class" select="." />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<xsl:template match="xref">
		<xsl:element name="a">
			<xsl:attribute name="href">
				<xsl:value-of select="son:last(@href, '_')" />
            </xsl:attribute>
			<xsl:apply-templates select="node()" />
        </xsl:element>
    </xsl:template>

	<xsl:template match="anchor">
		<xsl:element name="a">
			<xsl:attribute name="id">
				<xsl:value-of select="son:last(@x, '_')" />
			</xsl:attribute>
		</xsl:element>
    </xsl:template>

	<xsl:template match="Table">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:attribute name="out_class" select="parent::*/@style" />
			<xsl:apply-templates select="node()" />
    	</xsl:copy>
	</xsl:template>

	<xsl:template match="Cell">
		<xsl:copy>
			<xsl:apply-templates select="@* except @style" />
			<xsl:variable name="class">
				<xsl:choose>
					<xsl:when test="matches(@style, '(_Heading|_Heding)') and 
							  		descendant::*[matches(@style, 'C_table_')]">
						<xsl:value-of select="'Description_Cell'" />
		            </xsl:when>

					<xsl:when test="matches(@style, '(_Heading|_Heding)') and 
							  		preceding-sibling::node()[1][descendant::*[matches(@style, 'C_table_')]]">
						<xsl:value-of select="'Description_Cell'" />
					</xsl:when>

					<xsl:otherwise>
						<xsl:value-of select="@style" />
                    </xsl:otherwise>
		        </xsl:choose>
			</xsl:variable>
			
			<xsl:attribute name="class" select="$class" />
			<xsl:apply-templates select="node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="Image/@href">
		<xsl:variable name="src" select="son:last(., '/')" />
		<xsl:variable name="src-format">
			<xsl:value-of select="replace(replace(replace(replace(replace(replace($src, '\.jpg', ''), '\.tif', ''), '\.ai', ''), '\.TIF', ''), '\.EPS', ''), '\.eps', '')" />
        </xsl:variable>
		
		<xsl:attribute name="src" select="concat('image/', $src-format, '.jpg')" />
    </xsl:template>

	<xsl:template match="Image">
		<xsl:choose>
			<xsl:when test="count(parent::para/node()) = 1">
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					<xsl:attribute name="class" select="parent::*/@style" />
					<xsl:apply-templates select="node()" />
                </xsl:copy>
            </xsl:when>

			<xsl:when test="count(ancestor::para[1]/node()) = 1 and 
					  		count(ancestor::para[1]/span/Image) = 1">
				<xsl:copy>
					<xsl:apply-templates select="@*" />
					<xsl:attribute name="class" select="ancestor::para[1]/@style" />
					<xsl:apply-templates select="node()" />
				</xsl:copy>
			</xsl:when>

			<xsl:otherwise>
				<xsl:copy>
					<xsl:attribute name="class" select="if (parent::*[matches(name(), '(para|span)')]) then 'C_image' else ancestor::para[1]/@style" />
					<xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<xsl:template match="text()" priority="10">
		<xsl:choose>
			<xsl:when test="parent::*[not(matches(@style, 'C_Subscript'))]">
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

	<xsl:function name="son:last">
		<xsl:param name="arg1" />
		<xsl:param name="arg2" />
		<xsl:copy-of select="replace(tokenize($arg1, $arg2)[last()], '(\s\d$)', '')" />
	</xsl:function>

</xsl:stylesheet>