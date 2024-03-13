<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:son="http://www.astkorea.net/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs son xsi"
    version="2.0">

	<xsl:output method="xml" encoding="UTF-8" indent="no" />
	<xsl:strip-space elements="*"/>

	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
	
	<xsl:template match="ol">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:for-each select="node()">
				<xsl:variable name="number">
					<xsl:choose>
						<xsl:when test="parent::*/*[1][matches(@class, 'UnorderList_Alp1_1')]">
							<xsl:number from="ol" count="p[matches(@class, 'UnorderList_Alp')]" level="any" format="A" />
						</xsl:when>

                        <xsl:when test="parent::*/*[1][matches(@class, '1_11$')]">
                            <xsl:variable name="one">
                                <xsl:number from="ol" count="p[matches(@class, '\d_\d+')]" level="single" format="1" />
                            </xsl:variable>

                            <xsl:value-of select="xs:integer($one) + 10" />
                        </xsl:when>

                        <xsl:when test="parent::*/*[1][matches(@class, '1_20$')]">
                            <xsl:variable name="one">
                                <xsl:number  format="1" />
                            </xsl:variable>

                            <xsl:value-of select="(xs:integer($one)-1)+20" />
                        </xsl:when>
						
						
                        <xsl:when test="parent::*/*[1][matches(@class, '1_1(_UpSp)?$')]">
                            <xsl:number from="ol" count="p[matches(@class, '\d_\d')]" level="any" format="1" />
                        </xsl:when>

						<xsl:when test="parent::*/*[1][matches(@class, 'UnorderList_Alp1_2')]">
							<xsl:number from="ol[*[1][matches(@class, 'UnorderList_Alp1_1')]]" count="p[matches(@class, 'UnorderList_Alp\d_\d')]" level="any" format="A" />
						</xsl:when>
						
						<xsl:when test="parent::*/*[1][matches(@class, 'List1_2')]">
							<xsl:number from="ol[*[1][matches(@class, 'List1_1')]]" count="p[matches(@class, 'List\d_\d')]" level="any" format="1" />
						</xsl:when>

						<xsl:when test="parent::*/*[1][matches(@class, '1_2')]">
							<xsl:number from="ol[*[1][matches(@class, '1_1')]]" count="p[matches(@class, '\d_\d$')]" level="any" format="1" />
						</xsl:when>

						<xsl:when test="parent::*/*[1][matches(@class, '1_0')]">
							<xsl:variable name="one">
								<xsl:number from="ol" count="p[matches(@class, '\d_\d')]" level="any" format="1" />
							</xsl:variable>

							<xsl:value-of select="xs:integer($one) - 1" />
						</xsl:when>

						<xsl:otherwise>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				
				<xsl:copy>
					<xsl:attribute name="Num" select="$number" />
					<xsl:apply-templates select="@*" />
						
					<xsl:apply-templates select="node()" />
                </xsl:copy>
            </xsl:for-each>
    	</xsl:copy>
    </xsl:template>

</xsl:stylesheet>