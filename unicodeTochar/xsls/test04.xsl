<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ast="http://www.astkorea.net/" exclude-result-prefixes="xs ast">

    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" />



    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()" priority="5">
        <xsl:analyze-string select="." regex="(/)?(\(\?=)">
            <xsl:matching-substring>
                <xsl:text disable-output-escaping="yes">&lt;b class=&quot;forwardSearch&quot;&gt;</xsl:text>
                <xsl:value-of select="replace(regex-group(2), '\?=', '')"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="(/)?(\(\?!)">
                    <xsl:matching-substring>
                        <xsl:text disable-output-escaping="yes">&lt;b class=&quot;nothing&quot;&gt;</xsl:text>
                        <xsl:value-of select="regex-group(2)"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:analyze-string select="." regex="(/)?(\()">
                            <xsl:matching-substring>
                                <xsl:text disable-output-escaping="yes">&lt;b&gt;</xsl:text>
                                <xsl:value-of select="regex-group(2)"/>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <xsl:analyze-string select="." regex="(\))">
                                    <xsl:matching-substring>
                                        <xsl:value-of select="regex-group(1)"/>
                                        <xsl:text disable-output-escaping="yes">&lt;/b&gt;</xsl:text>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <xsl:analyze-string select="." regex="(\\\\)(\d)">
                                            <xsl:matching-substring>
                                                <xsl:text disable-output-escaping="yes">&lt;pos&gt;</xsl:text>
                                                <xsl:value-of select="regex-group(2)"/>
                                                <xsl:text disable-output-escaping="yes">&lt;/pos&gt;</xsl:text>
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
                                                <xsl:analyze-string select="." regex="(/[a-z])$">
                                                    <xsl:matching-substring>
                                                    </xsl:matching-substring>
                                                    <xsl:non-matching-substring>
                                                        <xsl:value-of select="."/>
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
    
    
    <xsl:function name="ast:getcode">
        <xsl:param name="str" />
        <xsl:param name="char" />
        
        
        <xsl:variable name="str0">
            <xsl:for-each select="tokenize($str, $char)">
                <from>
                    <xsl:value-of select="concat('(', replace(replace(., '\(', ''), '\)', ''), ')')"/>
                </from>
                <xsl:if test="position()!=last()">
                    <xsl:text>&#xa;&#x9;&#x9;</xsl:text>
                </xsl:if>
                
            </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="$str0" />
    </xsl:function>

    <xsl:function name="ast:last">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="tokenize($str, $char)[last()]" />
    </xsl:function>

</xsl:stylesheet>
