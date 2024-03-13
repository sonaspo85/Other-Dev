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

	<xsl:template match="Table/*">
		<xsl:variable name="class" select="tokenize(parent::Table/@class, '\s')[last()]" />
		
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:for-each-group select="node()" group-starting-with="*[matches(@newrow, 'newrow')]">
				<xsl:choose>
					<xsl:when test="current-group()[1][matches(@newrow, 'newrow')][matches(@class, '_Heding')]">
						<tr>
							<xsl:attribute name="class">
								<xsl:value-of select="$class" />
                            </xsl:attribute>
							<xsl:for-each select="current-group()">
								<th>
									<xsl:apply-templates select="@*, node()" />
                                </th>
                            </xsl:for-each>
                        </tr>
                	</xsl:when>

					<xsl:when test="current-group()[1][matches(@newrow, 'newrow')][not(matches(@class, '_Heding'))]">
						<tr>
							<xsl:attribute name="class">
								<xsl:value-of select="$class" />
							</xsl:attribute>
							<xsl:for-each select="current-group()">
								<td>
									<xsl:apply-templates select="@*, node()" />
								</td>
							</xsl:for-each>
						</tr>
					</xsl:when>

					<xsl:otherwise>
						<tr>
							<xsl:attribute name="class">
								<xsl:value-of select="$class" />
							</xsl:attribute>
							<xsl:for-each select="current-group()">
								<td>
									<xsl:apply-templates select="@*, node()" />
								</td>
							</xsl:for-each>
						</tr>
                    </xsl:otherwise>
            	</xsl:choose>
            </xsl:for-each-group>
    	</xsl:copy>
    </xsl:template>

	<xsl:template match="Table[not(matches(@class, 'Table_Maintenance'))][descendant::*[matches(@class, 'image_box')]]">
		<xsl:apply-templates select="descendant::Cell/node()" />
    </xsl:template>
	
	<xsl:template match="*[matches(@class, 'image_box')]">
		<xsl:variable name="cur" select="name()" />
		
		<xsl:choose>
			<xsl:when test="count(Image) &gt; 1 and 
					  		Image[following-sibling::node()[1][matches(@class, 'Description')]]">
				
				<xsl:for-each-group select="node()" group-starting-with="Image">
					<xsl:choose>
						<xsl:when test="current-group()[1][name()='Image']">
							<xsl:element name="{$cur}">
								<xsl:apply-templates select="parent::*/@*" />
								<xsl:apply-templates select="current-group()" />
							</xsl:element>
                        </xsl:when>

						<xsl:otherwise>
							<xsl:apply-templates select="current-group()" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each-group>
            </xsl:when>
			
			<xsl:when test="not(node()[matches(name(), '(p|ol|ul|div|text())')]) and count(Image) &gt; 1">
				<xsl:for-each select="*">
					<div class="image_box">
						<xsl:apply-templates select="." />
                    </div>
                </xsl:for-each>
        	</xsl:when>

            <!--<xsl:when test="following-sibling::node()[1][matches(@class, 'UnorderList1-Child')]">
                <xsl:copy>
                    <xsl:apply-templates select="@*, node()" />
                    <yyy>
                    <xsl:copy-of select="following-sibling::node()[1]" /></yyy>
                </xsl:copy>
            </xsl:when>-->

			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()" />
				</xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<xsl:template match="li[*[matches(@class, 'image_box')]]">
		<xsl:variable name="name" select="name()" />

		<xsl:apply-templates />
    </xsl:template>
	
</xsl:stylesheet>