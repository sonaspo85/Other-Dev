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
    
    <xsl:template name="HeadSection">
        <head>
            <meta charset="UTF-8" />
            <style>
                <xsl:text>
                    .source {
                            
                    }
                    .data-xlsx {
                        color: blue;
                    }
                    .fail {
                        color: red;
                    }
                    span {
                        display: block;
                    }
                    table tr td, table tr th {
                        border: 1px solid black;
                    	padding: 5px;
                    }
                    table {
                    	border-collapse: collapse;
                    	width: 100%;
                    }
            		hr {
            			margin: 50px 0;
            		}
            		p {
            			margin: 0 0;
            		}
            		#result {
            			font-weight: 800;
            			color: red;
            			font-size: 1.5em;
            		}
                </xsl:text>
            </style>
            <title>
                <xsl:value-of select="@zipName"/>
            </title>
        </head>
    </xsl:template>
    
    <xsl:template match="tr">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="td">
        <xsl:choose>
            <xsl:when test="@remover = 'yes'">
            </xsl:when>
            
            <xsl:when test="ancestor::Table[@class='regNum'] and 
                            position() = 1">
                <xsl:copy>
                    <xsl:apply-templates select="@*" />
                    <p>
                        <xsl:value-of select="*[1]/@value"/>
                    </p>
                </xsl:copy>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*, node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="table">
        <h1><xsl:value-of select="@class"/></h1>
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*[matches(name(), '(RowSpan|ColumnSpan)')]">
        <xsl:choose>
            <xsl:when test="name() = 'RowSpan'">
                <xsl:attribute name="rowspan" select="." />
            </xsl:when>
            <xsl:when test="name() = 'ColumnSpan'">
                <xsl:attribute name="colspan" select="." />
            </xsl:when>
        </xsl:choose>
    </xsl:template>
        
</xsl:stylesheet>