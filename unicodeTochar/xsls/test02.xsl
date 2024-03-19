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
        <xsl:analyze-string select="." regex="(\{{\s)(&quot;)(from)([&quot;:\s]+)([\w+&quot;\(\\\)\[\]\-\?/!]+)?(&quot;)">
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)"/>
                <xsl:text disable-output-escaping="yes">&lt;List&gt;</xsl:text>
                
                <xsl:text disable-output-escaping="yes">&lt;from&gt;</xsl:text>
                <xsl:value-of select="regex-group(5)"/>
                <xsl:text disable-output-escaping="yes">&lt;/from&gt;</xsl:text>
                <xsl:value-of select="regex-group(6)"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="(\s&quot;)(to)([&quot;:\s]+)([\w+&quot;\(\\\)\[\]\-\?]+)?(&quot;)">
                    <xsl:matching-substring>
                        <xsl:text disable-output-escaping="yes">&lt;to&gt;</xsl:text>
                        <xsl:value-of select="regex-group(4)"/>
                        <xsl:text disable-output-escaping="yes">&lt;/to&gt;</xsl:text>
                        <xsl:text disable-output-escaping="yes">&lt;/List&gt;</xsl:text>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
        
    </xsl:template>
    

    <xsl:function name="ast:getName">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="string-join(tokenize($str, $char)[position() ne last()], '/')" />
    </xsl:function>

    <xsl:function name="ast:last">
        <xsl:param name="str" />
        <xsl:param name="char" />
        <xsl:value-of select="tokenize($str, $char)[last()]" />
    </xsl:function>

</xsl:stylesheet>
