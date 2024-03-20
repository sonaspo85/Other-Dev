<?xml version='1.0'?>

<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:opentopic="http://www.idiominc.com/opentopic"
	exclude-result-prefixes="opentopic"
	version="2.0">
	
	<xsl:variable name="map" select="//opentopic:map"/>
	<xsl:variable name="map.name" select="//root()/*[contains(@class,' map/map ')][1]/@xtrf"/>
	<xsl:variable name="map.id" select="//root()/*[contains(@class,' map/map ')][1]/@id"/>
	<xsl:variable name="map.base" select="//root()/*[contains(@class,' map/map ')][1]/@base"/>
	<xsl:variable name="map.props" select="//root()/*[contains(@class,' map/map ')][1]/@otherprops"/>
	
	<xsl:template name="createFrontCoverContents">
		<xsl:choose>
			<xsl:when test="matches($map.id, 'refer_TV_E_Manual')">
				<xsl:choose>
					<xsl:when test="substring-before($locale, '_') = 'ko'"><!-- 중소기업 TV 납품용 -->
						<fo:block-container xsl:use-attribute-sets="__frontmatter__title__container">
							<fo:block xsl:use-attribute-sets="__frontmatter__title__block">SMART TV</fo:block>
							<fo:block xsl:use-attribute-sets="__frontmatter__title__block">E-설명서</fo:block>
						</fo:block-container>

						<fo:block-container writing-mode="{$writing-mode}">
							<fo:block-container xsl:use-attribute-sets="__frontmatter__textbox__container">
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">시각이 불편한 사용자들을 위해 매뉴얼 사용 방법을 제공하는 페이지로 바로 가려면 아래 메뉴 익히기 링크를 실행하세요.
									<fo:block>
										<fo:inline>“<fo:basic-link internal-destination="_Connect_42_main_icon_nor_dm" border-bottom="1pt solid black">메뉴 익히기</fo:basic-link>” 링크</fo:inline>
									</fo:block>
								</fo:block>
							</fo:block-container>
						</fo:block-container>
					</xsl:when>

					<xsl:when test="substring-after($locale, '_') = 'KR'">
						<fo:block-container xsl:use-attribute-sets="__frontmatter__title__container">
							<fo:block xsl:use-attribute-sets="__frontmatter__title__block">SMART TV</fo:block>
							<fo:block xsl:use-attribute-sets="__frontmatter__title__block">E-MANUAL</fo:block>
						</fo:block-container>

						<fo:block-container writing-mode="{$writing-mode}">
							<fo:block-container xsl:use-attribute-sets="__frontmatter__textbox__container">
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">Click on the Menu Tutorial link below to go directly to the section with instructions on menu use for individuals who have difficulty seeing.
									<fo:block>
										<fo:inline>“<fo:basic-link internal-destination="_Connect_42_main_icon_nor_dm" border-bottom="1pt solid black">Learning the Menus</fo:basic-link>” Link</fo:inline>
									</fo:block>
								</fo:block>
							</fo:block-container>
						</fo:block-container>
					</xsl:when>

					<xsl:otherwise> <!-- 중소 TV 기준 다른 출향지 -->
						<fo:block-container xsl:use-attribute-sets="__frontmatter__title__container">
							<fo:block xsl:use-attribute-sets="__frontmatter__title__block">
								<xsl:call-template name="getVariable">
									<xsl:with-param name="id" select="'e-manual) frontmatter-title'"/>
								</xsl:call-template>
							</fo:block>
						</fo:block-container>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			
			<xsl:when test="substring-before($locale, '_') = 'ko'"> <!-- 삼성 TV 기준 국판향 출향지 -->
				<fo:block-container xsl:use-attribute-sets="__frontmatter__logo__container">
					<fo:block xsl:use-attribute-sets="__frontmatter__logo__block">
						<fo:external-graphic src="Customization/OpenTopic/common/artwork/2016_Samsung_Logo_BLACK.svg" content-width="41mm" scaling="uniform"/>
					</fo:block>
				</fo:block-container>

				<fo:block-container xsl:use-attribute-sets="__frontmatter__title__container">
					<fo:block xsl:use-attribute-sets="__frontmatter__title__block">
						<xsl:choose>
							<xsl:when test="matches($map.id, '(m_Screen_E_Manual|2022_project)')">
								<xsl:variable name="id" select="'m-screen) frontmatter-title'" />
								
								<xsl:call-template name="getVariable">
									<xsl:with-param name="id" select="$id"/>
								</xsl:call-template>
							</xsl:when>

							<xsl:when test="matches($map.id, 'm_TV_E_Manual')">
								<fo:block>SMART TV</fo:block>
								<fo:block>E-설명서</fo:block>
							</xsl:when>

							
							<xsl:otherwise>
								<xsl:variable name="id" select="'frontmatter-title'" />
								
								<xsl:call-template name="getVariable">
									<xsl:with-param name="id" select="$id"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</fo:block>
				</fo:block-container>
				
				<fo:block-container writing-mode="{$writing-mode}">
					<fo:block-container xsl:use-attribute-sets="__frontmatter__textbox__container">
						<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">시각이 불편한 사용자들을 위해 매뉴얼 사용 방법을 제공하는 페이지로 바로 가려면 아래 메뉴 익히기 링크를 실행하세요.
							<fo:block>
								<fo:inline>“<fo:basic-link internal-destination="_Connect_42_main_icon_nor_dm" border-bottom="1pt solid black">메뉴 익히기</fo:basic-link>” 링크</fo:inline>
							</fo:block>
						</fo:block>
					</fo:block-container>
				</fo:block-container>
			</xsl:when>
			
			<xsl:when test="substring-after($locale, '_') = 'KR'">
				<fo:block-container xsl:use-attribute-sets="__frontmatter__logo__container">
					<fo:block xsl:use-attribute-sets="__frontmatter__logo__block">
						<fo:external-graphic src="Customization/OpenTopic/common/artwork/2016_Samsung_Logo_BLACK.svg" content-width="41mm" scaling="uniform"/>
					</fo:block>
				</fo:block-container>

				<fo:block-container xsl:use-attribute-sets="__frontmatter__title__container">
					<fo:block xsl:use-attribute-sets="__frontmatter__title__block">
						<xsl:choose>
							<xsl:when test="matches($map.id, '(m_Screen_E_Manual|2022_project)')">
								<xsl:variable name="id" select="'m-screen) frontmatter-title'" />
								
								<xsl:call-template name="getVariable">
									<xsl:with-param name="id" select="$id"/>
								</xsl:call-template>
							</xsl:when>

							<xsl:when test="matches($map.id, 'm_TV_E_Manual')">
								<fo:block>SMART TV</fo:block>
								<fo:block>E-MANUAL</fo:block>
							</xsl:when>

							
							<xsl:otherwise>
								<xsl:variable name="id" select="'frontmatter-title'" />
								
								<xsl:call-template name="getVariable">
									<xsl:with-param name="id" select="$id"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</fo:block>
				</fo:block-container>

				<fo:block-container writing-mode="{$writing-mode}">
					<fo:block-container xsl:use-attribute-sets="__frontmatter__textbox__container">
						<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">Click on the Menu Tutorial link below to go directly to the section with instructions on menu use for individuals who have difficulty seeing.
							<fo:block>
								<fo:inline>“<fo:basic-link internal-destination="_Connect_42_main_icon_nor_dm" border-bottom="1pt solid black">Learning the Menus</fo:basic-link>” Link</fo:inline>
							</fo:block>
						</fo:block>
					</fo:block-container>
				</fo:block-container>
			</xsl:when>
			
			<xsl:otherwise> <!-- 삼성 TV 기준 다른 출향지 -->
				<fo:block-container xsl:use-attribute-sets="__frontmatter__logo__container">
					<fo:block xsl:use-attribute-sets="__frontmatter__logo__block"><fo:external-graphic src="Customization/OpenTopic/common/artwork/2016_Samsung_Logo_BLACK.svg" content-width="41mm" scaling="uniform"/></fo:block>
				</fo:block-container>

				<fo:block-container xsl:use-attribute-sets="__frontmatter__title__container">
					<fo:block xsl:use-attribute-sets="__frontmatter__title__block">
						<xsl:choose>
							<xsl:when test="matches($map.id, 'm_TV_E_Manual')">
								<xsl:variable name="id" select="'e-manual) frontmatter-title'" />
								
								<xsl:call-template name="getVariable">
									<xsl:with-param name="id" select="$id"/>
								</xsl:call-template>
							</xsl:when>
							
							<xsl:otherwise>
								<xsl:call-template name="getVariable">
									<xsl:with-param name="id" select="'frontmatter-title'"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</fo:block>
				</fo:block-container>
				
				<fo:block-container writing-mode="{$writing-mode}">
					<fo:block-container xsl:use-attribute-sets="__frontmatter__textbox__container">
						<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">
							<xsl:choose>
								<xsl:when test="matches($map.base, 'Zawgyi-One') and substring-before($locale, '_') = 'my'">ဤ Samsung ထုတ္ကုန္ကို ဝယ္ယူျခင္းအတြက္ ေက်းဇူးတင္ပါသည္။</xsl:when>
								<xsl:when test="matches($map.props, 'BUL') and substring-before($locale, '_') = 'ru'">Благодарим ви, че закупихте този продукт на Samsung.</xsl:when>

								<xsl:otherwise>
									<xsl:call-template name="getVariable">
										<xsl:with-param name="id" select="'frontmatter-thankyou'"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</fo:block>

						<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">
							<xsl:choose>
								<xsl:when test="matches($map.base, 'Zawgyi-One') and substring-before($locale, '_') = 'my'">ပိုမိုျပည့္စံုသည့္ဝန္ေဆာင္မႈမ်ားကို လက္ခံရရိွရန္ ေက်းဇူးျပဳ၍ သင့္ထုတ္ကုန္ကို</xsl:when>
								<xsl:when test="matches($map.props, 'BUL') and substring-before($locale, '_') = 'ru'">За да получите пълно обслужване, регистрирайте продукта на</xsl:when>

								<xsl:otherwise>
									<xsl:call-template name="getVariable">
										<xsl:with-param name="id" select="'frontmatter-inform-register'"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
							<fo:block xsl:use-attribute-sets="__frontmatter__external__link__block">
								<fo:inline>
									<fo:basic-link>
										<xsl:attribute name="external-destination">
											<xsl:choose>
												<xsl:when test="matches($map.base, 'Zawgyi-One') and substring-before($locale, '_') = 'my'">www.samsung.com ၌ မွတ္ပံုတင္ပါ။</xsl:when>
												
												<xsl:otherwise>
													<xsl:call-template name="getVariable">
														<xsl:with-param name="id" select="'frontmatter-url'"/>
													</xsl:call-template>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										
										<xsl:choose>
											<xsl:when test="matches($map.base, 'Zawgyi-One') and substring-before($locale, '_') = 'my'">www.samsung.com ၌ မွတ္ပံုတင္ပါ။</xsl:when>
											
											<xsl:otherwise>
												<xsl:call-template name="getVariable">
													<xsl:with-param name="id" select="'frontmatter-url'"/>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</fo:basic-link>
								</fo:inline>
							</fo:block>
						</fo:block>
						<fo:block xsl:use-attribute-sets="__frontmatter__blankline__block">
							<xsl:choose>
								<xsl:when test="matches($map.base, 'Zawgyi-One') and substring-before($locale, '_') = 'my'">ေမာ္ဒယ</xsl:when>
								<xsl:when test="matches($map.props, 'BUL') and substring-before($locale, '_') = 'ru'">Модел</xsl:when>
								
								<xsl:otherwise>
									<xsl:call-template name="getVariable">
										<xsl:with-param name="id" select="'frontmatter-model'"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:text>&#x20;</xsl:text>
							<fo:leader xsl:use-attribute-sets="__frontmatter__blankline__leader"/>
							<xsl:text>&#x20;</xsl:text>
							
							<xsl:choose>
								<xsl:when test="matches($map.base, 'Zawgyi-One') and substring-before($locale, '_') = 'my'">စီရီယယ္နံပါတ္</xsl:when>
								<xsl:when test="matches($map.props, 'BUL') and substring-before($locale, '_') = 'ru'">Сериен №.</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="getVariable">
										<xsl:with-param name="id" select="'frontmatter-serialno'"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:text>&#x20;</xsl:text>
							<fo:leader xsl:use-attribute-sets="__frontmatter__blankline__leader"/>
						</fo:block>
						
						<xsl:choose>
							<xsl:when test="substring-before($locale, '_') = 'us'">
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">
									<xsl:call-template name="getVariable">
										<xsl:with-param name="id" select="'frontmatter-inform-menuscreen'"/>
									</xsl:call-template>
								</fo:block>
								
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">
									<fo:block>
										<fo:inline><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-open-quot'"/></xsl:call-template><fo:basic-link internal-destination="_Connect_42_main_icon_nor_dm" border-bottom="1pt solid black"><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-learnmenuscreen'"/></xsl:call-template></fo:basic-link><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-close-quot'"/></xsl:call-template><xsl:text>&#x20;</xsl:text><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-link'"/></xsl:call-template></fo:inline>
									</fo:block>
								</fo:block>
							</xsl:when>
							
							<xsl:when test="matches($map.props, 'BUL') and substring-before($locale, '_') = 'ru'">
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">За да отидете направо на страницата с инструкции за това как да използвате ръководството за хора с увреждания на зрението, изберете връзката Разучаване на екрана с менюто по-долу.</fo:block>
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">
									<fo:block>
										<fo:inline>Връзка “<fo:basic-link internal-destination="_Connect_42_main_icon_nor_dm" border-bottom="1pt solid black">Разучаване на екрана с менюто</fo:basic-link>”<xsl:text>&#x20;</xsl:text></fo:inline>
									</fo:block>
								</fo:block>
							</xsl:when>
							
							<xsl:when test="matches(substring-before($locale, '_'), 'ar|sq|hr|cs|da|de|nl|et|el|fr|it|lt|mk|nn|pl|pt|ro|ru|sr|sk|sl|es|sv|uk|id|fa|th|vi')">
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">
									<xsl:call-template name="getVariable">
										<xsl:with-param name="id" select="'frontmatter-inform-menuscreen'"/>
									</xsl:call-template>
								</fo:block>
								
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">
									<fo:block>
										<fo:inline><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-link'"/></xsl:call-template><xsl:text>&#x20;</xsl:text><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-open-quot'"/></xsl:call-template><xsl:text>&#x20;</xsl:text><fo:basic-link internal-destination="_Connect_42_main_icon_nor_dm" border-bottom="1pt solid black"><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-learnmenuscreen'"/></xsl:call-template></fo:basic-link><xsl:text>&#x20;</xsl:text><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-close-quot'"/></xsl:call-template></fo:inline>
									</fo:block>
								</fo:block>
							</xsl:when>
							
							<xsl:when test="matches($map.base, 'Zawgyi-One') and substring-before($locale, '_') = 'my'">
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">အမြင်အာရုံမသန်စွမ်းသော သုံးစွဲသူများအတွက် လက်စွဲစာအုပ်အသုံးပြုပုံ လမ်းညွန်ကို ပေးသည့် စာမျက်နာသို့ သွားရန် အောက်ပါ မီနူးဖန်သားပြင်အား လေ့လာပါ လင့်ခ်ကို ရွေးပါ။</fo:block>
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">
									<fo:block>
										<fo:inline><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-open-quot'"/></xsl:call-template><fo:basic-link internal-destination="_Connect_42_main_icon_nor_dm" border-bottom="1pt solid black">မီနူးဖန်သားပြင်အား လေ့လာပါ</fo:basic-link><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-close-quot'"/></xsl:call-template><xsl:text>&#x20;</xsl:text>လင့်ခ်</fo:inline>
									</fo:block>
								</fo:block>
							</xsl:when>
							
							<xsl:otherwise>
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">
									<xsl:call-template name="getVariable">
										<xsl:with-param name="id" select="'frontmatter-inform-menuscreen'"/>
									</xsl:call-template>
								</fo:block>
								
								<fo:block xsl:use-attribute-sets="__frontmatter__textbox__block">
									<fo:block>
										<fo:inline><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-open-quot'"/></xsl:call-template><fo:basic-link internal-destination="_Connect_42_main_icon_nor_dm" border-bottom="1pt solid black"><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-learnmenuscreen'"/></xsl:call-template></fo:basic-link><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-close-quot'"/></xsl:call-template><xsl:text>&#x20;</xsl:text><xsl:call-template name="getVariable"><xsl:with-param name="id" select="'frontmatter-link'"/></xsl:call-template></fo:inline>
									</fo:block>
								</fo:block>
							</xsl:otherwise>
						</xsl:choose>
					</fo:block-container>
				</fo:block-container>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>