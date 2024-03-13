<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/"
	xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
	xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
	exclude-result-prefixes="xs ast aid aid5">

	<xsl:variable name="skeleton" select="document('skeleton.icml')" as="document-node()?"/>
	<xsl:variable name="root" select="/"/>
	<xsl:variable name="locale" select="$root/Document/@lang"/>
	<!-- <xsl:variable name="ai.dir" select="concat(substring-before(ast:getPath(base-uri(.), '/'), '/out/'), '/out/images/')"/> -->
	<xsl:variable name="ai.dir" select="'file:///images/'"/>
	<xsl:key name="xrefs" match="xref" use="@dest"/>
	<xsl:variable name="hyperlinks">
		<xsl:for-each select="//xref">
			<xsl:copy-of select="."/>
		</xsl:for-each>
	</xsl:variable>

	<xsl:output method="xml" version="1.0" indent="no" encoding="UTF-8" />
	<xsl:strip-space elements="*" />
    <xsl:preserve-space elements="p"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@* | node()" mode="skeleton">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" mode="skeleton"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="/">
		<xsl:apply-templates select="$skeleton/Document" mode="skeleton" />
	</xsl:template>

	<xsl:template match="Document" mode="skeleton">
		<xsl:processing-instruction name="aid">style="50" type="snippet" readerVersion="6.0" featureSet="257" product="7.5(142)"</xsl:processing-instruction>
		<xsl:processing-instruction name="aid">SnippetType="InCopyInterchange"</xsl:processing-instruction>
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" mode="skeleton"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="image[@placement='break']" mode="#all"><!-- 수정 -->
		<xsl:call-template name="image-block-transform">
			<xsl:with-param name="this" select="."/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="Story" mode="skeleton">
		<TextVariable Self="dLanguageCode" Name="langcode" VariableType="CustomTextType">
			<CustomTextVariablePreference>
				<Properties>
					<Contents type="string">
						<xsl:value-of select="$locale"/>
					</Contents>
				</Properties>
			</CustomTextVariablePreference>
		</TextVariable>
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:for-each select="$root/Document/node()">
				<xsl:choose>
					<xsl:when test="self::processing-instruction('pagebreak')">
					</xsl:when>
					<xsl:when test="self::p">
						<xsl:call-template name="p-transform">
							<xsl:with-param name="this" select="."/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="self::image">
						<xsl:call-template name="image-block-transform">
							<xsl:with-param name="this" select="."/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="self::Table">
						<xsl:call-template name="table-transform">
							<xsl:with-param name="this" select="."/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</xsl:copy>

		<xsl:call-template name="xref-transform">
			<xsl:with-param name="hyperlinks" select="$hyperlinks"/>
		</xsl:call-template>

	</xsl:template>

	<xsl:template name="xref-transform">
		<xsl:param name="hyperlinks"/>
		<xsl:for-each select="$hyperlinks/xref">
		    <Hyperlink Source="{@self}" DestinationUniqueKey="{substring(@dest, 4)}"/>
		</xsl:for-each>
		<xsl:for-each select="$hyperlinks/xref">
			<xsl:variable name="dest" select="@dest"/>
			<xsl:if test="not(preceding-sibling::xref[@dest=$dest])">
		    	<HyperlinkURLDestination DestinationUniqueKey="{substring(@dest, 4)}"/>
		    </xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="p-transform">
		<xsl:param name="this"/>
		<ParagraphStyleRange>
			<xsl:attribute name="AppliedParagraphStyle">
				<xsl:value-of select="concat('ParagraphStyle/', $this/@pstyle)"/>
			</xsl:attribute>
            <xsl:if test="not(ancestor::Cell)">
	            <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
	                <Content>﻿</Content>
	            </CharacterStyleRange>
	        </xsl:if>
            <xsl:if test="key('xrefs', @id)">
            	<xsl:variable name="id" select="@id"/>
	            <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
	                <HyperlinkTextDestination DestinationUniqueKey="{substring(key('xrefs', @id)[1][@dest=$id]/@dest, 4)}"/>
	            </CharacterStyleRange>
	        </xsl:if>

            <xsl:for-each select="node()">
				<xsl:choose>
					<xsl:when test="self::processing-instruction('linebreak')">
					</xsl:when>
					<xsl:when test="self::text()">
						<xsl:call-template name="text-node-transform">
							<xsl:with-param name="this" select="."/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="self::ph">
						<xsl:call-template name="ph-transform">
							<xsl:with-param name="this" select="."/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="self::image">
						<xsl:call-template name="image-inline-transform">
							<xsl:with-param name="this" select="."/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="."/>
					</xsl:otherwise>
				</xsl:choose>
            </xsl:for-each>
            <xsl:if test="not(ancestor::Cell)">
	            <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
	            	<xsl:if test="$this/following-sibling::node()[1][self::processing-instruction('pagebreak')] or 
	            				  $this/following-sibling::node()[1][self::p][@pstyle='Chapter'][preceding-sibling::p[@pstyle='Chapter']]">
	            		<xsl:attribute name="ParagraphBreakType">NextColumn</xsl:attribute>
	            	</xsl:if>
	                <Br/>
	            </CharacterStyleRange>
	        </xsl:if>
		</ParagraphStyleRange>
	</xsl:template>

	<xsl:template name="image-block-transform">
		<xsl:param name="this"/>
		<ParagraphStyleRange>
			<xsl:attribute name="AppliedParagraphStyle">
				<xsl:choose>
					<xsl:when test="starts-with($this/@src, 'smart-ui')">ParagraphStyle/Empty-Center</xsl:when>
					<xsl:when test="$this/@align = 'left'">
						<xsl:value-of select="if ( matches(substring-before($locale, '-'), 'ar|he|fa') ) then 'ParagraphStyle/Empty' else 'ParagraphStyle/Empty-Left'"/>
					</xsl:when>
					<xsl:otherwise>ParagraphStyle/Empty-Center</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
            <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
                <Content>﻿</Content>
            </CharacterStyleRange>
			<CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
				<xsl:choose>
					<xsl:when test="ends-with($this/@src, '.ai')">
						<Rectangle>
							<xsl:if test="$this/@alt">
								<ObjectExportOption AltTextSourceType="SourceCustom" CustomAltText="{$this/@alt}"/>
							</xsl:if>
							<PDF><Link LinkResourceURI="{concat($ai.dir, $this/@src)}"/></PDF>
						</Rectangle>
					</xsl:when>
					<xsl:otherwise>
						<Rectangle>
							<xsl:if test="matches($this/@src, '(16_9.png|21_9.png|32_9.png)')">
								<xsl:attribute name="ItemTransform">1 0 0 1 0 0</xsl:attribute>
								<Properties>
									<PathGeometry>
										<GeometryPathType PathOpen="false">
											<PathPointArray>
												<PathPointType Anchor="-1.1510792319313624e-14 -5.755396159656812e-15" LeftDirection="-1.1510792319313624e-14 -5.755396159656812e-15" RightDirection="-1.1510792319313624e-14 -5.755396159656812e-15" />
												<PathPointType Anchor="-1.1510792319313624e-14 83.79648697758932" LeftDirection="-1.1510792319313624e-14 83.79648697758932" RightDirection="-1.1510792319313624e-14 83.79648697758932" />
												<PathPointType Anchor="153.07086614173227 83.79648697758932" LeftDirection="153.07086614173227 83.79648697758932" RightDirection="153.07086614173227 83.79648697758932" />
												<PathPointType Anchor="153.07086614173227 -5.755396159656812e-15" LeftDirection="153.07086614173227 -5.755396159656812e-15" RightDirection="153.07086614173227 -5.755396159656812e-15" />
											</PathPointArray>
										</GeometryPathType>
									</PathGeometry>
								</Properties>
								<FrameFittingOption AutoFit="false" LeftCrop="0" TopCrop="0" RightCrop="0" BottomCrop="0" FittingOnEmptyFrame="ContentToFrame" FittingAlignment="TopLeftAnchor" />
							</xsl:if>
							<xsl:if test="ends-with($this/@src, '_cable.png')">
								<xsl:attribute name="ItemTransform">1 0 0 1 0 0</xsl:attribute>
								<Properties>
									<PathGeometry>
										<GeometryPathType PathOpen="false">
											<PathPointArray>
												<PathPointType Anchor="0 0" LeftDirection="0 0" RightDirection="0 0" />
												<PathPointType Anchor="0 101.37517438239551" LeftDirection="0 101.37517438239551" RightDirection="0 101.37517438239551" />
												<PathPointType Anchor="132.69001882512498 101.37517438239551" LeftDirection="132.69001882512498 101.37517438239551" RightDirection="132.69001882512498 101.37517438239551" />
												<PathPointType Anchor="132.69001882512498 0" LeftDirection="132.69001882512498 0" RightDirection="132.69001882512498 0" />
											</PathPointArray>
										</GeometryPathType>
									</PathGeometry>
								</Properties>
								<FrameFittingOption AutoFit="false" LeftCrop="0" TopCrop="0" RightCrop="0" BottomCrop="0" FittingOnEmptyFrame="ContentToFrame" FittingAlignment="TopLeftAnchor" />
							</xsl:if>
							<xsl:if test="$this/@alt">
								<ObjectExportOption AltTextSourceType="SourceCustom" CustomAltText="{$this/@alt}"/>
							</xsl:if>
							<!-- _cable.png로 끝나는 경우 -->
							<Image>
								<xsl:if test="matches($this/@src, '(16_9.png|21_9.png|32_9.png)')">
									<xsl:attribute name="ActualPpi">150 150</xsl:attribute>
									<xsl:attribute name="EffectivePpi">367 367</xsl:attribute>
									<xsl:attribute name="ItemTransform">0.4088769377830315 0 0 0.4088769377830315 0 0</xsl:attribute>
								</xsl:if>
								<xsl:if test="ends-with($this/@src, '_cable.png')">
									<xsl:attribute name="ActualPpi">72 72</xsl:attribute>
									<xsl:attribute name="EffectivePpi">136 136</xsl:attribute>
									<xsl:attribute name="ItemTransform">0.5307600753005 0 0 0.5307600753005 0 0</xsl:attribute>
								</xsl:if>
								<Link LinkResourceURI="{concat($ai.dir, $this/@src)}"/>
							</Image>
						</Rectangle>
					</xsl:otherwise>
				</xsl:choose>
			</CharacterStyleRange>
			<xsl:if test="not(ancestor::Cell)">
				<CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
					<xsl:if test="$this/following-sibling::node()[1][self::processing-instruction('pagebreak')] or 
								$this/following-sibling::node()[1][self::p][@pstyle='Chapter'][preceding-sibling::p[@pstyle='Chapter']]">
						<xsl:attribute name="ParagraphBreakType">NextColumn</xsl:attribute>
					</xsl:if>
						<Br/>
				</CharacterStyleRange>
			</xsl:if>
		</ParagraphStyleRange>
	</xsl:template>

	<xsl:template name="image-inline-transform">
		<xsl:param name="this"/>
        <CharacterStyleRange>
        	<xsl:attribute name="AppliedCharacterStyle">
        		<xsl:value-of select="if ( starts-with($this/@src, 'btn_') ) then 'CharacterStyle/C_btn' else 'CharacterStyle/C_Image'"/>
        	</xsl:attribute>
			<xsl:choose>
				<xsl:when test="matches($this/@src, '(btn_VOL.svg|btn_CH.svg)')">
					<Rectangle>
						<Properties>
							<PathGeometry>
								<GeometryPathType PathOpen="false">
									<PathPointArray>
										<PathPointType Anchor="-5 -5" LeftDirection="-5 -5" RightDirection="-5 -5" />
										<PathPointType Anchor="-5 4.6999969482421875" LeftDirection="-5 4.6999969482421875" RightDirection="-5 4.6999969482421875" />
										<PathPointType Anchor="21.999999999999996 4.6999969482421875" LeftDirection="21.999999999999996 4.6999969482421875" RightDirection="21.999999999999996 4.6999969482421875" />
										<PathPointType Anchor="21.999999999999996 -5" LeftDirection="21.999999999999996 -5" RightDirection="21.999999999999996 -5" />
									</PathPointArray>
								</GeometryPathType>
							</PathGeometry>
						</Properties>
						<FrameFittingOption AutoFit="false" LeftCrop="0" TopCrop="0" RightCrop="0" BottomCrop="0" FittingOnEmptyFrame="ContentToFrame" FittingAlignment="TopLeftAnchor" />
						<xsl:if test="$this/@alt">
							<ObjectExportOption AltTextSourceType="SourceCustom" CustomAltText="{$this/@alt}"/>
						</xsl:if>
						<SVG>
							<xsl:attribute name="ItemTransform">1 0 0 1 0 0</xsl:attribute>
							<Link LinkResourceURI="{concat($ai.dir, $this/@src)}"/>
						</SVG>
					</Rectangle>
				</xsl:when>
				<xsl:when test="starts-with($this/@src, 'btn_')">
					<Rectangle>
						<Properties>
							<PathGeometry>
								<GeometryPathType PathOpen="false">
									<PathPointArray>
										<PathPointType Anchor="0 0" LeftDirection="0 0" RightDirection="0 0" />
										<PathPointType Anchor="0 13.606396484375" LeftDirection="0 13.606396484375" RightDirection="0 13.606396484375" />
										<PathPointType Anchor="13.606396484375 13.606396484375" LeftDirection="13.606396484375 13.606396484375" RightDirection="13.606396484375 13.606396484375" />
										<PathPointType Anchor="13.606396484375 0" LeftDirection="13.606396484375 0" RightDirection="13.606396484375 0" />
									</PathPointArray>
								</GeometryPathType>
							</PathGeometry>
						</Properties>
						<FrameFittingOption AutoFit="false" LeftCrop="0" TopCrop="0" RightCrop="0" BottomCrop="0" FittingOnEmptyFrame="ContentToFrame" FittingAlignment="TopLeftAnchor" />
						<xsl:if test="$this/@alt">
							<ObjectExportOption AltTextSourceType="SourceCustom" CustomAltText="{$this/@alt}"/>
						</xsl:if>
						<SVG>
							<xsl:attribute name="ItemTransform">0.8 0 0 0.8 0 0</xsl:attribute>
							<Link LinkResourceURI="{concat($ai.dir, $this/@src)}"/>
						</SVG>
					</Rectangle>
				</xsl:when>
				<xsl:when test="ends-with($this/@src, '.ai')">
					<Rectangle>
						<xsl:if test="$this/@alt">
							<ObjectExportOption AltTextSourceType="SourceCustom" CustomAltText="{$this/@alt}"/>
						</xsl:if>
						<PDF><Link LinkResourceURI="{concat($ai.dir, $this/@src)}"/></PDF>
					</Rectangle>
				</xsl:when>
				<xsl:otherwise>
					<Rectangle>
						<xsl:if test="$this/@alt">
							<ObjectExportOption AltTextSourceType="SourceCustom" CustomAltText="{$this/@alt}"/>
						</xsl:if>>
						<Image><Link LinkResourceURI="{concat($ai.dir, $this/@src)}"/></Image>
					</Rectangle>
				</xsl:otherwise>
			</xsl:choose>
        </CharacterStyleRange>
	</xsl:template>

	<xsl:template name="table-transform">
		<xsl:param name="this"/>
		<ParagraphStyleRange AppliedParagraphStyle="ParagraphStyle/Empty">
			<CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
				<xsl:copy>
					<xsl:apply-templates select="@* | node()"/>
				</xsl:copy>
			</CharacterStyleRange>
            <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
            	<xsl:if test="$this/following-sibling::node()[1][self::processing-instruction('pagebreak')] or 
            				  $this/following-sibling::node()[1][self::p][@pstyle='Chapter'][preceding-sibling::p[@pstyle='Chapter']]">
            		<xsl:attribute name="ParagraphBreakType">NextColumn</xsl:attribute>
            	</xsl:if>
                <Br/>
            </CharacterStyleRange>
		</ParagraphStyleRange>
	</xsl:template>

	<xsl:template match="p">
		<xsl:if test="string()">
			<ParagraphStyleRange>
				<xsl:attribute name="AppliedParagraphStyle">
					<xsl:value-of select="concat('ParagraphStyle/', @pstyle)"/>
				</xsl:attribute>
	            <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
	                <Content>﻿<Br/></Content>
	            </CharacterStyleRange>
	            <xsl:if test="key('xrefs', @id)">
	            	<xsl:variable name="id" select="@id"/>
		            <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
		                <HyperlinkTextDestination DestinationUniqueKey="{substring(key('xrefs', @id)[1][@dest=$id]/@dest, 4)}"/>
		            </CharacterStyleRange>
		        </xsl:if>
	            <xsl:for-each select="node()">
					<xsl:choose>
						<xsl:when test="self::processing-instruction('linebreak')">
						</xsl:when>
						<xsl:when test="self::text()">
							<xsl:call-template name="text-node-transform">
								<xsl:with-param name="this" select="."/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="self::ph">
							<xsl:call-template name="ph-transform">
								<xsl:with-param name="this" select="."/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="self::image">
							<xsl:call-template name="image-inline-transform">
								<xsl:with-param name="this" select="."/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="."/>
						</xsl:otherwise>
					</xsl:choose>
	            </xsl:for-each>
	            <xsl:if test="following-sibling::p[string()]">
		            <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
		                <Br/>
		            </CharacterStyleRange>
		        </xsl:if>
			</ParagraphStyleRange>
		</xsl:if>
	</xsl:template>

	<xsl:template name="text-node-transform">
		<xsl:param name="this"/>
        <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/$ID/[No character style]">
            <Content>
            	<xsl:value-of select="$this"/>
            </Content>
        </CharacterStyleRange>
	</xsl:template>

	<xsl:template name="ph-transform">
		<xsl:param name="this"/>
        <CharacterStyleRange>
			<xsl:attribute name="AppliedCharacterStyle">
				<xsl:value-of select="concat('CharacterStyle/', $this/@cstyle)"/>
			</xsl:attribute>
			<xsl:if test="@dir = 'ltr'">
				<xsl:attribute name="CharacterDirection">LeftToRightDirection</xsl:attribute>
			</xsl:if>
            <Content>
            	<xsl:value-of select="$this"/>
            </Content>
        </CharacterStyleRange>
	</xsl:template>

	<xsl:template match="xref">
        <HyperlinkTextSource Self="{@self}">
        	<xsl:choose>
        		<xsl:when test="matches(substring-before($locale, '-'), 'ar|he|fa') and matches(., '\(\p{IsBasicLatin}+\)')">
					<xsl:analyze-string select="." regex="\(\p{{IsBasicLatin}}+\)">
						<xsl:matching-substring>
				    		<CharacterStyleRange AppliedCharacterStyle="CharacterStyle/C_Font-Underline" CharacterDirection="LeftToRightDirection">
					            <Content>
					            	<xsl:value-of select="."/>
					            </Content>
				    		</CharacterStyleRange>
						</xsl:matching-substring>
						<xsl:non-matching-substring>
				    		<CharacterStyleRange AppliedCharacterStyle="CharacterStyle/C_Font-Underline">
					            <Content>
					            	<xsl:value-of select="."/>
					            </Content>
				    		</CharacterStyleRange>
						</xsl:non-matching-substring>
					</xsl:analyze-string>
        		</xsl:when>
        		<xsl:otherwise>
		    		<CharacterStyleRange AppliedCharacterStyle="CharacterStyle/C_Font-Underline">
			            <Content>
			            	<xsl:value-of select="."/>
			            </Content>
		    		</CharacterStyleRange>
        		</xsl:otherwise>
        	</xsl:choose>
        </HyperlinkTextSource>
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