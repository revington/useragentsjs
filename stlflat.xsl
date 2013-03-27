<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="1.0">
    <xsl:strip-space elements="*"/>
    <xsl:output method="text" indent="yes" omit-xml-declaration="yes"    />
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 29, 2012</xd:p>
            <xd:p><xd:b>Author:</xd:b> pedro</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="folder">
        
        {"description": "<xsl:value-of select="@description"/>",
        "elements": [<xsl:if test="folder">
            [ <xsl:for-each select="folder">
                <xsl:apply-templates select="." />  
                <xsl:if test="position()!=last()">
                    <xsl:text>,</xsl:text>
                </xsl:if>
            </xsl:for-each>],
        </xsl:if>
        <xsl:for-each select="useragent">
            <xsl:apply-templates select="." />  
            <xsl:if test="position()!=last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each> ]}
        
    </xsl:template>
    <xsl:template match="useragent">
        {"name": "<xsl:value-of select="@description"/>",
            "ua" : "<xsl:value-of select="@useragent"/>",
            "vendor" : "<xsl:value-of select="@vendor"/>",
            "tags": [<xsl:for-each select="ancestor::folder">
                    "<xsl:value-of select="@description"/>"
                    <xsl:if test="position()!=last()">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>]}
    </xsl:template>
    <xsl:template name="tags">
        <xsl:param name="pAncestor"></xsl:param>
        "<xsl:value-of select="$pAncestor/@description"/>",
        <xsl:call-template name="tags">
            <xsl:with-param name="pAncestor" select="ancestor::folder"></xsl:with-param> 
        </xsl:call-template>
    </xsl:template>
<xsl:template match="*">
        module.exports =[<xsl:for-each select="//useragent">
        <xsl:apply-templates select="." />  
        <xsl:if test="position()!=last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:for-each>];
    </xsl:template>
</xsl:stylesheet>
