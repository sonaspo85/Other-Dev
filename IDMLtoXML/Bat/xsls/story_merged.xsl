<?xml version="1.0" encoding="UTF-8"?>
<!-- Created with Liquid Studio 2018 (https://www.liquid-technologies.com) -->
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:son="http://www.astkorea.net/"
	xmlns:functx="http://www.functx.com"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:idPkg="http://ns.adobe.com/AdobeInDesign/idml/1.0/packaging"
	xmlns:x="adobe:ns:meta/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:xmp="http://ns.adobe.com/xap/1.0/"
	xmlns:xmpGImg="http://ns.adobe.com/xap/1.0/g/img/"
	xmlns:xmpMM="http://ns.adobe.com/xap/1.0/mm/"
	xmlns:stRef="http://ns.adobe.com/xap/1.0/sType/ResourceRef#"
	xmlns:stEvt="http://ns.adobe.com/xap/1.0/sType/ResourceEvent#"
	xmlns:illustrator="http://ns.adobe.com/illustrator/1.0/"
	xmlns:xmpTPg="http://ns.adobe.com/xap/1.0/t/pg/"
	xmlns:stDim="http://ns.adobe.com/xap/1.0/sType/Dimensions#"
	xmlns:xmpG="http://ns.adobe.com/xap/1.0/g/"
	xmlns:pdf="http://ns.adobe.com/pdf/1.3/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	exclude-result-prefixes="xs son xsi idPkg functx x dc xmp xmpGImg xmpMM stRef stEvt illustrator xmpTPg stDim xmpG pdf rdf"
	version="2.0">


	<xsl:output method="xml" encoding="UTF-8" indent="no" cdata-section-elements="Contents" />
	<xsl:strip-space elements="*"/>

	<xsl:variable name="directory" select="collection(concat(son:getpath(base-uri(.), '/'), '/resource', '/?select=designmap1.xml;recurse=yes'))" />
	<xsl:variable name="ori_filename" select="$directory/Document/@Name" />
	
	<xsl:variable name="foreach_direc">
		<xsl:for-each select="$directory/Document/@Name">
			<pos>
				<xsl:value-of select="replace(., '\.indd', '')" />
			</pos>
		</xsl:for-each>
	</xsl:variable>

	<xsl:variable name="designmap_S_List">
		<xsl:for-each select="$directory/Document/@Name">
			<xsl:variable name="s_list" select="doc(concat(son:getpath(base-uri(.), '/'), '/designmap1.xml'))/Document/@StoryList" />
			<xsl:variable name="SL_token" select="tokenize($s_list, ' ')" />

			<xsl:variable name="token_copy">
				<xsl:for-each select="$SL_token">
					<token>
					<xsl:value-of select="." />
					</token>
				</xsl:for-each>
			</xsl:variable>
			
			<DM>
				<xsl:value-of select="$s_list" />
			</DM>

			<DM_split>
				<xsl:copy-of select="$token_copy" />
			</DM_split>
		</xsl:for-each>
	</xsl:variable>

	<!-- ***************************************************************************************************************** -->

	<xsl:variable name="story_foreach">
		<xsl:for-each select="$ori_filename">
			<xsl:variable name="story_uri" select="collection(concat(son:getpath(base-uri(.), '/'), '/Stories?select=*.xml;recurse=yes'))" />
			<xsl:variable name="folder_name" select="replace(son:last(resolve-uri(.), '/'), '\.indd', '')" />
			
			<folder class="{$folder_name}">
				<xsl:copy-of select="$story_uri" />
			</folder>
		</xsl:for-each>
	</xsl:variable>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="/">
		<xsl:variable name="cur_dir" select="son:getpath(base-uri(.), '/')" />
		
		<xsl:for-each select="1 to count($designmap_S_List/DM)">
			<xsl:variable name="i" select="." as="xs:integer" />

			<!--<xsl:result-document href="{concat($foreach_direc/pos[$i], '/', $foreach_direc/pos[$i], '.xml')}" method="xml">-->
			<xsl:result-document href="{concat('resource/', $foreach_direc/pos[$i], '.xml')}" method="xml">
				<xsl:text>&#xA;</xsl:text>
				<body path="{concat($cur_dir, '/', $foreach_direc/pos[$i], '/', $foreach_direc/pos[$i], '.xml')}">
					<xsl:if test="$story_foreach/folder/@class = $foreach_direc/pos[$i]">
						<xsl:variable name="DM_href">
							<!-- 링크 관련 변수 작동안됨, 데이터만 추출함 -->
							<DM_href>
								<xsl:for-each select="doc(concat($cur_dir, '/resource/', $foreach_direc/pos[$i], '/designmap1.xml'))/Document//*[@DestinationUniqueKey]">
									<xsl:copy copy-namespaces="no">
										<xsl:apply-templates select="@DestinationUniqueKey, @Source, @DestinationPage" />
									</xsl:copy>
	                            </xsl:for-each>
							</DM_href>
                        </xsl:variable>
						<xsl:copy-of select="$DM_href" />
						
						<xsl:for-each select="$designmap_S_List/DM_split[$i]/token">
							<xsl:variable name="token_slist" select="." />
							<xsl:if test=". = $story_foreach/folder/idPkg:Story/Story/@Self">
								<xsl:copy-of select="$story_foreach/folder/idPkg:Story/Story[@Self = $token_slist]" />
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<xsl:text>&#xa;</xsl:text>
				</body>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>

	<xsl:function name="functx:open-ref-document" as="document-node()" xmlns:functx="http://www.functx.com">
		<xsl:param name="refNode" as="node()"/>

		<xsl:sequence select="if (base-uri($refNode)) 
							  then document(resolve-uri($refNode, base-uri($refNode))) 
							  else doc(resolve-uri($refNode))"/>
	</xsl:function>

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