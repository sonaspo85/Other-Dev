<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:idPkg="http://ns.adobe.com/AdobeInDesign/idml/1.0/packaging"
    xmlns:ast="http://www.astkorea.net/" 
    exclude-result-prefixes="xs idPkg ast" 
    version="2.0">
    
    
    <xsl:output method="xml" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="*"/>
    
    <xsl:key name="flwroot" match="*[ancestor::root[matches(@filename, 'translationPrice_output')]][@tempID]" use="@tempID" />
    <xsl:key name="preroot" match="*[ancestor::root[matches(@filename, 'claimUnitPrice_output')]][@tempID]" use="@tempID" />
    
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="*[@tempID]">
        <xsl:variable name="tempid" select="@tempID" />

        <xsl:choose>
            <xsl:when test="ancestor::root[matches(@filename, 'claimUnitPrice_output')]">
                <xsl:copy>
                    <xsl:apply-templates select="@*" />

                    <xsl:choose>
                        <xsl:when test="not(node())">
                            <xsl:choose>
                                <xsl:when test="key('flwroot', $tempid) and 
                                                key('flwroot', $tempid)/*">
                                    <xsl:copy-of select="key('flwroot', $tempid)/*" />
                                </xsl:when>

                                <xsl:otherwise>
                                    <xsl:apply-templates select="node()"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:apply-templates select="node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:copy>
            </xsl:when>

            <!-- <xsl:when test="ancestor::root[matches(@filename, 'translationPrice_output')]">
                <xsl:copy>
                    <xsl:choose>
                        <xsl:when test="key('preroot', $tempid)">
                            <vvv />
                        </xsl:when>
                    
                        <xsl:otherwise>
                            <xsl:apply-templates select="@* | node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:copy>
            </xsl:when>
        
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
            </xsl:otherwise> -->
        </xsl:choose>
        
    </xsl:template>

    <xsl:template match="root[matches(@filename, 'translationPrice_output')]">
    </xsl:template>
    
</xsl:stylesheet>
