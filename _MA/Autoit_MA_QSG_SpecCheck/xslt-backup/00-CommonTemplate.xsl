<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="xs ast functx">
    <xsl:strip-space elements="*"/>
    
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    <xsl:variable name="languagesData" select="document(concat(ast:getPath(base-uri(.), '/'), '/../xsls/', 'languages.xml'))" />
    <xsl:variable name="excelData" select="document(concat(ast:getPath(base-uri(.), '/'), '/../xsls/', 'Validation_1.xml'))" />
    <xsl:variable name="LangFeatures" select="document(concat(ast:getPath(base-uri(.), '/'), '/../xsls/', 'codes.xml'))" />
    
    <xsl:variable name="langSort">
        <xsl:for-each select="root/doc/@lang">
            <L>
                <xsl:value-of select="."/>
            </L>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="region" select="root/@region"/>
    
    <xsl:variable name="codesAttr">
        <xsl:variable name="langGroup">
            <xsl:copy-of select="$LangFeatures/codes/div[@region=$region]/code[@lang=$langSort/L]" />
        </xsl:variable>
        
        <xsl:for-each select="$langGroup/code">
            <group lang="{@lang}">
                <xsl:for-each select="@*[not(matches(name(), 'lang'))]">
                    <specList>
                        <xsl:value-of select="replace(name(), 'registration', 'regNum')"/>
                    </specList>
                </xsl:for-each>
            </group>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="bandDiv">
        <xsl:for-each select="$languagesData/root/bandmode/items[@apply='true'][@lang=$langSort/L]">
            <xsl:copy>
                <xsl:apply-templates select="@*" />
                <xsl:for-each select="item[not(matches(@unit, 'N/A'))]">
                    <xsl:choose>
                        <xsl:when test="matches(@id, '(wcdma|^lte$|^5g$)')">
                            <xsl:call-template name="splitCall">
                                <xsl:with-param name="cur" select="." />
                                <xsl:with-param name="id" select="@id" />
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy>
                                <xsl:apply-templates select="@*, node()" />
                            </xsl:copy>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="sarDiv">
        <xsl:for-each select="$languagesData/root/sars/items[@apply='true'][@lang=$langSort/L]">
            <xsl:copy>
                <xsl:apply-templates select="@*" />
                <xsl:for-each select="item[not(matches(., 'N/A'))]">
                    <xsl:sequence select="." />
                </xsl:for-each>
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="distansDiv">
        <xsl:for-each select="$languagesData/root/distance/items[@apply='true'][@lang=$langSort/L]">
            <xsl:copy>
                <xsl:apply-templates select="@*" />
                <xsl:for-each select="item[not(matches(., 'N/A'))]">
                    <xsl:sequence select="." />
                </xsl:for-each>
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="registDiv">
        <xsl:for-each select="$languagesData/root/registration/items[@apply='true'][@lang=$langSort/L]">
            <xsl:copy>
                <xsl:apply-templates select="@*" />
                <xsl:for-each select="item[not(matches(., 'N/A'))]">
                    <xsl:sequence select="." />
                </xsl:for-each>
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="productDiv">
        <xsl:for-each select="$languagesData/root/productSpec/items[@apply='true'][@lang=$langSort/L]">
            <xsl:copy>
                <xsl:apply-templates select="@*" />
                <xsl:for-each select="item[not(matches(., 'N/A'))]">
                    <xsl:sequence select="." />
                </xsl:for-each>
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="elecDiv">
        <xsl:for-each select="$languagesData/root/electronic/items[@apply='true'][@lang=$langSort/L]">
            <xsl:copy>
                <xsl:apply-templates select="@*" />
                <xsl:for-each select="item[not(matches(., 'N/A'))]">
                    <xsl:sequence select="." />
                </xsl:for-each>
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="packageDiv">
        <xsl:for-each select="$languagesData/root/packages/items[@apply='true'][@lang=$langSort/L]">
            <xsl:copy>
                <xsl:apply-templates select="@*" />
                <xsl:for-each select="item[not(matches(., 'N/A'))]">
                    <xsl:sequence select="." />
                </xsl:for-each>
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:template name="splitCall">
        <xsl:param name="cur" />
        <xsl:param name="id" />
        
        <xsl:choose>
            <xsl:when test="matches(@id, 'wcdma')">
                <xsl:variable name="first">
                    <xsl:value-of select="tokenize($cur, ' ')[1]"/>
                </xsl:variable>
                
                <xsl:variable name="second">
                    <xsl:variable name="two" select="replace($cur, concat($first, ' '), '')"/>
                    <xsl:for-each select="tokenize($two, '/')">
                        <xsl:variable name="curPos" select="position()"/>
                        
                        <xsl:element name="{local-name($cur)}">
                            <xsl:apply-templates select="$cur/@*" />
                            <xsl:attribute name="id" select="tokenize($cur/@id, '/')[$curPos]" />
                            <xsl:value-of select="concat($first, ' ', .)"/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:copy-of select="$second" />
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:variable name="first">
                    <xsl:value-of select="tokenize($cur, ' ')[not(matches(., '/'))]"/>
                </xsl:variable>

                <xsl:variable name="two" select="normalize-space(replace($cur, concat('(\()?', $first, '(\))?'), ''))"/>
                <xsl:for-each select="tokenize($two, '/')">
                    <xsl:variable name="curPos" select="position()"/>
                    <xsl:element name="{local-name($cur)}">
                        <xsl:apply-templates select="$cur/@*" />
                        <!--<xsl:attribute name="id" select="tokenize($cur/@id, '/')[$curPos]" />-->
                        <xsl:value-of select="if (matches($first, '\(')) then concat(., ' ', $first) else concat($first, ' ', .)"/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="bandmodeSplit">
        <xsl:param name="valuesId" />
        <xsl:param name="cur" />
        
        <xsl:variable name="token">
            <xsl:choose>
                <xsl:when test="matches($valuesId, 'lte')">
                    <xsl:variable name="curToken" select="tokenize($cur, ' ')[matches(., '/')]"/>
                    <xsl:variable name="first">
                        <xsl:value-of select="$valuesId"/>
                    </xsl:variable>
                    
                    <xsl:variable name="second">
                        <xsl:for-each select="tokenize($curToken, '/')">
                            <split>
                                <xsl:value-of select="concat($first, '_', .)"/>
                            </split>
                        </xsl:for-each>
                    </xsl:variable>
                    
                    <xsl:copy-of select="$second" />
                </xsl:when>
                
                <xsl:when test="matches($valuesId, 'wcdma')">
                    <xsl:variable name="second">
                        <xsl:for-each select="tokenize($valuesId, '/')">
                            <split>
                                <xsl:value-of select="."/>
                            </split>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:copy-of select="$second" />
                </xsl:when>
                
                <xsl:when test="matches($cur, '\(FR1\)')">
                    <xsl:variable name="first" select="tokenize($cur, ' ')[2]"/>
                    <xsl:variable name="two" select="normalize-space(replace($cur, concat('(\()?', $first, '(\))?'), ''))"/>
                    <xsl:variable name="second">
                        <xsl:for-each select="tokenize($two, '/')">
                            <split>
                                <xsl:value-of select="concat(., '_', $first)"/>
                            </split>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:copy-of select="$second" />
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:copy-of select="$token" />
    </xsl:template>
    
    <xsl:template name="booleanCheck">
        <xsl:param name="specCheck" />
        <xsl:param name="specDiv" />
        <xsl:param name="cur" />
        <xsl:param name="lang" />
        
        <xsl:choose>
            <xsl:when test="$specCheck = 'electronic'">
                <xsl:for-each select="$specDiv">
                    <xsl:variable name="cur" select="." />
                    <xsl:variable name="curPos" select="position()" />
                    <xsl:choose>
                        <xsl:when test="$curPos = count($cur/preceding-sibling::*)+1">
                            <xsl:value-of select="'true '"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false '"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:when>
            
            <xsl:when test="$cur = $specDiv">
                <xsl:value-of select="'true '"/>
            </xsl:when>
            
            <!--<xsl:when test="$specCheck != 'bandandmode' and 
                matches($cur, $specDiv)">
                <xsl:value-of select="'true '"/>
            </xsl:when>-->
            
            <xsl:otherwise>
                <xsl:for-each select="$specDiv">
                    <xsl:variable name="curSpec" select="."/>
                    
                    <xsl:choose>
                        <xsl:when test="matches($cur, $curSpec)">
                            <xsl:value-of select="'true '"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false '"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="decimalChange">
        <xsl:param name="cur" />
        
        <xsl:analyze-string select="$cur" regex="(\d+[.,]?\d+?)(\s?dB[µμ]A[/]m)(.*?)(\d+)(\s?)(.*)?">
            <xsl:matching-substring>
                <xsl:value-of select="concat('dB: ', replace(regex-group(1), '(\d+)([.,])(\d+?)', '$1.$3'))"/>
                <xsl:value-of select="' ### '"/>
                <xsl:value-of select="concat('m: ', regex-group(4))"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="(\d+)(\s?)(.*?)(\d+[.,]?\d+?)(\s?dB[µμ]A[/]m)(.*)?">
                    <xsl:matching-substring>
                        <xsl:value-of select="concat('m: ', regex-group(1))"/>
                        <xsl:value-of select="' ### '"/>
                        <xsl:value-of select="concat('dB: ' , replace(regex-group(4), ',', '.'))"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:analyze-string select="." regex="(\d+?)(A[/]m)(.*?)(\d+)(m)">
                            <xsl:matching-substring>
                                <xsl:value-of select="concat('Am: ', regex-group(1))"/>
                                <xsl:value-of select="' ### '"/>
                                <xsl:value-of select="concat('m: ', regex-group(4))"/>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <xsl:analyze-string select="." regex="(\d+)([,])(\d+)">
                                    <xsl:matching-substring>
                                        <xsl:value-of select="regex-group(1)"/>
                                        <xsl:value-of select="'.'"/>
                                        <xsl:value-of select="regex-group(3)"/>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <xsl:value-of select="replace(replace(., '&#x200E;', ''), '&#x200F;', '')"/>
                                    </xsl:non-matching-substring>
                                </xsl:analyze-string>
                            </xsl:non-matching-substring>
                        </xsl:analyze-string>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    <xsl:variable name="excelBandMode">
        <xsl:for-each select="$excelData/root/bandmode/spec">
            <xsl:copy>
                <xsl:apply-templates select="@*" />
                    <xsl:attribute name="values">
                        <xsl:analyze-string select="@outputpower" regex="(\d+[.,]?\d+?)(\s?dB[µμ]A[/]m)(.*?)(\d+)(\s?)(.*)?">
                            <xsl:matching-substring>
                                <xsl:value-of select="concat('dB: ' , replace(regex-group(1), ',', '.'))"/>
                                <!--<xsl:value-of select="concat('dB: ' , regex-group(1))"/>-->
                                <xsl:value-of select="' ### '"/>
                                <xsl:value-of select="concat('m: ', regex-group(4))"/>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <xsl:analyze-string select="." regex="(\d+?)(A[/]m)(.*)(\d+?)(m)">
                                    <xsl:matching-substring>
                                        <xsl:value-of select="concat('Am: ', regex-group(1))"/>
                                        <xsl:value-of select="' ### '"/>
                                        <xsl:value-of select="concat('m: ', regex-group(4))"/>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <xsl:value-of select="."/>
                                    </xsl:non-matching-substring>
                                </xsl:analyze-string>
                            </xsl:non-matching-substring>
                        </xsl:analyze-string>
                    </xsl:attribute>
                
                <xsl:apply-templates select="node()" />
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="excelSarMode">
        <xsl:for-each select="$excelData/root/sars/spec">
            <xsl:sequence select="." />
        </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="langSarCodes">
        <xsl:for-each select="$LangFeatures/codes/div[@region=$region]/code[@lang=$langSort/L]/@sars">
            <codes lang="{parent::*/@lang}">
                <xsl:copy-of select="ast:token(., ' ')" />
            </codes>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="langRegCodes">
        <xsl:for-each select="$LangFeatures/codes/div[@region=$region]/code[@lang=$langSort/L]/@registration[. = 'true']">
            <codes lang="{parent::*/@lang}">
                <xsl:copy-of select="ast:token(., ' ')" />
            </codes>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="excelRegistMode">
        <xsl:for-each select="$excelData/root/registration/spec">
            <xsl:sequence select="." />
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="excelProductMode">
        <xsl:for-each select="$excelData/root/productSpec/spec">
            <xsl:copy>
                <!--<xsl:apply-templates select="@* except @value" />-->
                <xsl:apply-templates select="@*" />
                <xsl:choose>
                    <xsl:when test="@item = 'cpu'"> 
                        <xsl:attribute name="values">
                            <xsl:call-template name="prodValuesCall">
                                <xsl:with-param name="cur" select="." />
                                <xsl:with-param name="values" select="@value" />
                            </xsl:call-template>
                        </xsl:attribute>
                    </xsl:when>
                    
                    <xsl:when test="@item = 'ossystem'"> 
                        <xsl:attribute name="values">
                            <xsl:call-template name="prodValuesCall">
                                <xsl:with-param name="cur" select="." />
                                <xsl:with-param name="values" select="@value" />
                            </xsl:call-template>
                        </xsl:attribute>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:attribute name="values">
                            <xsl:value-of select="replace(@value, '\s+', '')"/>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="excelElectMode">
        <xsl:for-each select="$excelData/root/electronic/spec">
            <!--<xsl:sequence select="." />-->
            <xsl:copy>
                <xsl:apply-templates select="@*" />
                <xsl:attribute name="values">
                    <xsl:value-of select="replace(@value, '\s+', '')"/>
                </xsl:attribute>
                <xsl:apply-templates select="node()" />
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="excelPackageMode">
        <xsl:for-each select="$excelData/root/packages/spec">
            <xsl:sequence select="." />
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:template name="prodValuesCall">
        <xsl:param name="cur"/>
        <xsl:param name="values"/>
        
        <xsl:choose>
            <xsl:when test="$cur[@item='cpu']">
                <xsl:analyze-string select="$values" regex="(\d.\d+\s?)(GHz)([,\s+]+)?">
                    <xsl:matching-substring>
                        <!--<xsl:value-of select="regex-group(1)"/>
                        <xsl:value-of select="regex-group(2)"/>
                        <xsl:value-of select="','"/>
                        <xsl:value-of select="regex-group(5)"/>
                        <xsl:value-of select="regex-group(6)"/>-->
                        <xsl:value-of select="replace(regex-group(0), '\s+', '')"/>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            
            <xsl:when test="$cur[@item='ossystem']">
                <xsl:analyze-string select="$values" regex="(.*?)(\s?\d+\.\d?)">
                    <xsl:matching-substring>
                        <xsl:value-of select="regex-group(1)"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="ValidVSsarCall">
        <xsl:param name="lang" />
        
        <sars>
            <xsl:variable name="matchExtract">
                <xsl:for-each select="$langSarCodes/codes[@lang=$lang]/a">
                    <xsl:variable name="cur" select="."/>
                    <xsl:variable name="parLang" select="parent::*/@lang"/>
                    <xsl:choose>
                        <xsl:when test=". = $excelSarMode/spec/@item">
                            <xsl:choose>
                                <xsl:when test="count($excelSarMode/spec[@item = $cur]) &gt; 1">
                                    <xsl:choose>
                                        <xsl:when test="$excelSarMode/spec[@item = $cur][@division = $parLang]">
                                            <xsl:copy-of select="$excelSarMode/spec[@item = $cur][@division = $parLang]" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:copy-of select="$excelSarMode/spec[@item = $cur][@division = 'Common']" />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of select="$excelSarMode/spec[@item = $cur]" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:for-each select="$matchExtract/*">
                <xsl:variable name="values0" select="replace(replace(@value, '(\s?W/kg)', ''), '(\s?mm)', '')"/>
                <xsl:variable name="values">
                    <xsl:call-template name="decimalChange">
                        <xsl:with-param name="cur" select="$values0" />
                    </xsl:call-template>
                </xsl:variable>
                <xsl:copy>
                    <xsl:apply-templates select="@*" />
                    <xsl:attribute name="values" select="$values" />
                    <xsl:apply-templates select="node()" />
                </xsl:copy>
            </xsl:for-each>
        </sars>
    </xsl:template>
    
    <xsl:template name="convert-to-twips">
        <xsl:param name="value"/>
        <xsl:param name="Unit"/>
        
        <xsl:variable name="scaling-factor">
            <xsl:choose>
                <xsl:when test="contains ($value, $Unit)">
                    <xsl:value-of select="'10'"/>
                </xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="numeric-value" select="number(replace(replace($value, $Unit, ''), '[,]', '.'))"/>
        <xsl:value-of select="$numeric-value * $scaling-factor"/>
    </xsl:template>
    
    <xsl:template name="UnitspaceRemoveCall">
        <xsl:param name="cur" />
        
        <xsl:analyze-string select="$cur" regex="(\d\.\d+)(\s)([GHgh]+z)">
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)" />
                <xsl:value-of select="regex-group(3)" />
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="(\d\.\d)(&#x201D;)">
                    <xsl:matching-substring>
                        <xsl:value-of select="regex-group(1)" />
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:analyze-string select="." regex="(\d+)(\s)(MP)(\s[/]\s+?)">
                            <xsl:matching-substring>
                                <xsl:value-of select="regex-group(1)" />
                                <xsl:value-of select="regex-group(3)" />
                                <xsl:value-of select="','" />
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <xsl:analyze-string select="." regex="(\d+)(\s)(MP)">
                                    <xsl:matching-substring>
                                        <xsl:value-of select="regex-group(1)" />
                                        <xsl:value-of select="regex-group(3)" />
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <xsl:analyze-string select="." regex="(\d+)(\s)(GB)">
                                            <xsl:matching-substring>
                                                <xsl:value-of select="regex-group(1)" />
                                                <xsl:value-of select="regex-group(3)" />
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
                                                <xsl:analyze-string select="." regex="(\d+)(Vcc?)([,])">
                                                    <xsl:matching-substring>
                                                        <xsl:value-of select="regex-group(1)" />
                                                        <xsl:value-of select="regex-group(2)" />
                                                    </xsl:matching-substring>
                                                    <xsl:non-matching-substring>
                                                        <xsl:value-of select="." />
                                                    </xsl:non-matching-substring>
                                                </xsl:analyze-string>
                                            </xsl:non-matching-substring>
                                        </xsl:analyze-string>
                                    </xsl:non-matching-substring>
                                </xsl:analyze-string>
                            </xsl:non-matching-substring>
                        </xsl:analyze-string>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    <xsl:template name="TextConvertCall">
        <xsl:param name="cur" />
        <xsl:param name="prePID" />
        
        <xsl:variable name="UnitspaceRemove">
           <xsl:call-template name="UnitspaceRemoveCall">
               <xsl:with-param name="cur" select="$cur" />
           </xsl:call-template>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$prePID = 'cpu'">
                <xsl:variable name="first" select="tokenize($UnitspaceRemove, ' ')[1]"/>
                <xsl:variable name="second" select="replace($UnitspaceRemove, concat($first, ' '), '')"/>
                <xsl:variable name="secondRepls" select="replace(replace(replace($second, '\(', ''), '\)', ''), ',\s', ',')"/>
                
                <xsl:value-of select="$secondRepls"/>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:value-of select="$UnitspaceRemove" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="valuesSplit">
        <xsl:param name="preP" />
        <xsl:param name="class" required="no" />
        
        <xsl:choose>
            <xsl:when test="matches($preP, '&#x482;')">
                <xsl:for-each select="tokenize($preP, ' &#x482; ')">
                    <xsl:variable name="first" select="tokenize(., '&#x23F5; ')[1]"/>
                    <xsl:variable name="other" select="tokenize(., '&#x23F5; ')[position() ne 1]"/>
                    <span>
                        <xsl:attribute name="class" select="'data-xlsx'" />
                        <xsl:choose>
                            <xsl:when test="$class = 'bandandmode'">
                                <xsl:value-of select="."/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$other"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </span>
                </xsl:for-each>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:variable name="first" select="tokenize($preP, '&#x23F5; ')[1]"/>
                <xsl:variable name="other" select="tokenize($preP, '&#x23F5; ')[position() ne 1]"/>
                <span>
                    <xsl:attribute name="class" select="'data-xlsx'" />
                    <xsl:choose>
                        <xsl:when test="$class = 'bandandmode'">
                            <xsl:value-of select="$preP"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$other"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="survive">
        <xsl:param name="target" />
        <xsl:param name="source" />
        <xsl:param name="pos" />
        <xsl:param name="cnt" />
        <xsl:param name="cur" />
        
        <xsl:variable name="sourceWrap">
            <spec>
                <xsl:value-of select="$source"/>
            </spec>
        </xsl:variable>
        
        <xsl:variable name="statusY">
            <xsl:for-each select="$excelPackageMode/spec[@supportstatus='Y']">
                <xsl:variable name="cur" select="."/>
                
                <xsl:choose>
                    <xsl:when test="$cur[. = $cur/@item]">
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="." />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:variable name="statusY01">
            <xsl:for-each select="$statusY/*">
                <xsl:variable name="item" select="substring(@item, 1, 5)"/>
                
                <xsl:choose>
                    <xsl:when test="matches($sourceWrap/*, $item)">
                        <xsl:sequence select="." />
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="functx:is-node-in-sequence-deep-equal($target[1], $sourceWrap/node())">
                <xsl:value-of select="$target[1]"/>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:variable name="str0">
                    <xsl:if test="$cnt &gt;= 1">
                        <xsl:call-template name="survive">
                            <xsl:with-param name="target" select="remove($target, 1)" />
                            <xsl:with-param name="source" select="$source" />
                            <xsl:with-param name="pos" select="$pos" />
                            <xsl:with-param name="cnt" select="$cnt - 1" />
                        </xsl:call-template>
                    </xsl:if>
                </xsl:variable>
                
                <xsl:choose>
                    <xsl:when test="string-length($str0) &gt; 0">
                        <xsl:value-of select="$str0"/>
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="$sourceWrap/* = 'no match languages file'">
                                <xsl:value-of select="'no match languages file'" />
                            </xsl:when>
                            
                            <xsl:when test="$statusY01/*">
                                <xsl:value-of select="$statusY01/*/@division" />
                            </xsl:when>
                            
                            <xsl:otherwise>
                                <xsl:value-of select="'This specification is not supported.'" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:function name="functx:is-node-in-sequence-deep-equal" as="xs:boolean" xmlns:functx="http://www.functx.com">
        <xsl:param name="node" as="node()?"/>
        <xsl:param name="seq" as="node()*"/>
        <xsl:sequence select="some $nodeInSeq in $seq satisfies deep-equal($nodeInSeq, $node)" />
    </xsl:function>
    
    <xsl:function name="ast:token">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:for-each select="tokenize($str, $char)">
            <a>
                <xsl:value-of select="."/>
            </a>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="ast:getPath">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], $char)" />
    </xsl:function>
    
    <xsl:function name="ast:last">
        <xsl:param name="arg1" />
        <xsl:param name="arg2" />
        <xsl:value-of select="tokenize($arg1, $arg2)[last()]" />
    </xsl:function>
</xsl:stylesheet>