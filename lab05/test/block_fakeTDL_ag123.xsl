<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>

    <!-- Template to match the root element <fakeTDL> -->
    <xsl:template match="/fakeTDL">
        <xsl:choose>
            <!-- If any child element contains a <source> field with value 'AG123', output <blocked/> -->
            <xsl:when test="*/source = 'AG123'">
                <!-- <blocked/> -->
            </xsl:when>
            <!-- Otherwise, copy the entire structure of <fakeTDL> unchanged -->
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="node() | @*"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template to copy all attributes and child nodes recursively -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
