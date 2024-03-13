<?xml  version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ast="http://www.astkorea.net/" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    
    exclude-result-prefixes="xs ast xsi">

    <xsl:strip-space elements="*"/>
    <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="no" />
    
    
    <xsl:template name="package-structure">
        <xsl:variable name="preP" select="@sourceFalseValues"/>
        <tr>
            <td>
                <p>
                    <xsl:attribute name="class" select="if ($preP) then 'source fail' else 'source'" />
                    <xsl:apply-templates select="node()" />
                </p>
            </td>
            <td>
                <p>
                    <xsl:attribute name="class" select="'data-xlsx'" />
                    <xsl:value-of select="if ($preP) then $preP else @sameExcelValues"/>
                </p>
            </td>
        </tr>
    </xsl:template>
    
</xsl:stylesheet>