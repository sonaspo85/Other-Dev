<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <xsl:attribute-set name="ol.li">
        <xsl:attribute name="margin-left">2mm</xsl:attribute>
        <xsl:attribute name="space-after">1.5pt</xsl:attribute>
        <xsl:attribute name="space-before">1.5pt</xsl:attribute>
        <xsl:attribute name="relative-align">baseline</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ol.li__label__content">
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    	<xsl:attribute name="font-family">Arial</xsl:attribute>
    	<xsl:attribute name="font-size">13pt</xsl:attribute>
    	<xsl:attribute name="font-stretch">semi-condensed</xsl:attribute>
        <xsl:attribute name="color">cmyk(0%,0%,0%,80%)</xsl:attribute>
    	<xsl:attribute name="baseline-shift">-1pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ul.li">
        <xsl:attribute name="margin-left">2mm</xsl:attribute>
        <xsl:attribute name="space-after">
        	<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]">0mm</xsl:when>
        		<xsl:otherwise>4mm</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="space-before">
        	<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]">0mm</xsl:when>
        		<xsl:otherwise>3mm</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="relative-align">baseline</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ul.li__label__content">
		<xsl:attribute name="padding-top">
			<xsl:choose>
        		<xsl:when test="*[contains(@class, ' task/cmd ')]">
        			<xsl:choose>
        				<xsl:when test="*[contains(@class, ' task/cmd ')]//image">
		        			<xsl:choose>
				        		<xsl:when test="*[contains(@class, ' task/cmd ')]//image[1][@height &gt;= 17]">4pt</xsl:when>
				        		<xsl:when test="*[contains(@class, ' task/cmd ')]//image[1][@height &gt;= 13]">3pt</xsl:when>
				        		<xsl:when test="*[contains(@class, ' task/cmd ')]//image[1][@height &gt;= 11]">1pt</xsl:when>
				        	</xsl:choose>
        				</xsl:when>
        				<xsl:when test="*[contains(@class, ' task/cmd ')]/cmdname and *[contains(@class, ' task/cmd ')]/apiname">2pt</xsl:when>
        				<xsl:otherwise>0pt</xsl:otherwise>
					</xsl:choose>
        		</xsl:when>
        		<xsl:otherwise>
        			<xsl:choose>
						<xsl:when test="image">
							<xsl:variable name="str">
								<xsl:value-of select="image[1]/preceding-sibling::node()"/>
							</xsl:variable>
							<xsl:choose>
				        		<xsl:when test="string-length($str) &gt; 130">0pt</xsl:when>
						        <xsl:otherwise>
						        	<xsl:choose>
						        		<xsl:when test="image[1][@height &gt;= 17]">4pt</xsl:when>
						        		<xsl:when test="image[1][@height &gt;= 13]">3pt</xsl:when>
						        		<xsl:when test="image[1][@height &gt;= 11]">1pt</xsl:when>
								        <xsl:otherwise>0pt</xsl:otherwise>
								    </xsl:choose>
						        </xsl:otherwise>
				        	</xsl:choose>
						</xsl:when>
		        		<xsl:when test="node()[1][self::text()] and string-length(node()[1]) &gt; 130">0pt</xsl:when>
		        		<xsl:when test="parent::*[contains(@class, ' topic/ul ')]/ancestor::*[contains(@class, ' topic/ul ')] and not(preceding-sibling::li)">
		        			<xsl:choose>
        						<xsl:when test="apiname">2pt</xsl:when>
		        				<xsl:otherwise>
				        			<xsl:choose>
						        		<xsl:when test="image[1][@height &gt;= 17]">4pt</xsl:when>
						        		<xsl:when test="image[1][@height &gt;= 13]">3pt</xsl:when>
						        		<xsl:when test="image[1][@height &gt;= 11]">1pt</xsl:when>
						        		<xsl:otherwise>0pt</xsl:otherwise>
						        	</xsl:choose>
		        				</xsl:otherwise>
		        			</xsl:choose>
		        		</xsl:when>
		        		<xsl:when test="*[1][contains(@class, ' topic/p ')] and *[contains(@class, ' topic/ul ')]">
		        			<xsl:choose>
				        		<xsl:when test="*[1][contains(@class, ' topic/p ')]/image[1][@height &gt;= 17]">4pt</xsl:when>
				        		<xsl:when test="*[1][contains(@class, ' topic/p ')]/image[1][@height &gt;= 13]">3pt</xsl:when>
				        		<xsl:when test="*[1][contains(@class, ' topic/p ')]/image[1][@height &gt;= 11]">1pt</xsl:when>
				        		<xsl:otherwise>0pt</xsl:otherwise>
				        	</xsl:choose>
		        		</xsl:when>
		        		<xsl:when test="image and not(*[name()!='image'])">
		        			<xsl:choose>
				        		<xsl:when test="image[1][@height &gt;= 17]">4pt</xsl:when>
				        		<xsl:when test="image[1][@height &gt;= 13]">3pt</xsl:when>
				        		<xsl:when test="image[1][@height &gt;= 11]">1pt</xsl:when>
				        		<xsl:otherwise>0pt</xsl:otherwise>
				        	</xsl:choose>
		        		</xsl:when>
		        		<xsl:when test="*[contains(@class, ' topic/p ')]">0pt</xsl:when>
		        		<xsl:otherwise>
		        			<xsl:choose>
				        		<xsl:when test=".//image[1][@height &gt;= 17]">4pt</xsl:when>
				        		<xsl:when test=".//image[1][@height &gt;= 13]">3pt</xsl:when>
				        		<xsl:when test=".//image[1][@height &gt;= 11]">1pt</xsl:when>
				        		<xsl:otherwise>0pt</xsl:otherwise>
				        	</xsl:choose>
			        	</xsl:otherwise>
					</xsl:choose>
        		</xsl:otherwise>
        	</xsl:choose>
		</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ul.li__body">
        <xsl:attribute name="start-indent">
        	<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' task/steps-unordered ')]">body-start()</xsl:when>
        		<xsl:when test="contains(@class, ' task/substep ')">0mm</xsl:when>
        		<xsl:otherwise>body-start()</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ul.li.first">
        <xsl:attribute name="margin-left">2mm</xsl:attribute>
        <xsl:attribute name="space-after">
        	<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]">0mm</xsl:when>
        		<xsl:otherwise>4mm</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="space-before">
        	<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]">0mm</xsl:when>
        		<xsl:otherwise>3mm</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="relative-align">baseline</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ol.li.first">
        <xsl:attribute name="margin-left">2mm</xsl:attribute>
        <xsl:attribute name="space-after">
        	<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]">0mm</xsl:when>
        		<xsl:otherwise>4mm</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="space-before">
        	<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]">0mm</xsl:when>
        		<xsl:otherwise>3mm</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="relative-align">baseline</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="sl.sli.first">
        <xsl:attribute name="margin-left">2mm</xsl:attribute>
        <xsl:attribute name="space-after">
        	<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]">0mm</xsl:when>
        		<xsl:otherwise>4mm</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="space-before">
        	<xsl:choose>
        		<xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]">0mm</xsl:when>
        		<xsl:otherwise>3mm</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>