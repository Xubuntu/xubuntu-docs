<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
	<!-- This file is a customization layer for PDF -->

	<!-- Imports -->
	<xsl:import href="/usr/share/xml/docbook/stylesheet/nwalsh/fo/docbook.xsl"/>

	<!-- Enabling this means we can have a PDF chapter index -->
	<xsl:param name="fop1.extensions" select="1"/>

	<!-- Page size and margins -->
	<xsl:param name="page.margin.inner" select="'1.5cm'"/>
	<xsl:param name="page.margin.outer" select="'1.5cm'"/>
	<xsl:param name="body.start.indent" select="'1cm'"/>

	<!-- General options -->
<!--	<xsl:param name="menuchoice.menu.separator" select="' » '"/>-->
	<xsl:param name="hyphenate" select="'false'"/>

	<!-- Section title styles -->
	<xsl:attribute-set name="section.title.properties">
		<xsl:attribute name="color">#555</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level1.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 2"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level2.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 1.5"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level3.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 1.2"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level4.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="admonition.title.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 1.1 "/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>

	<!-- Icons -->
	<xsl:template match="imagedata[@role = 'icon']">
		<fo:inline>
			<xsl:variable name="src">
				<xsl:value-of select="@fileref"/>
			</xsl:variable>
			<fo:external-graphic alignment-baseline="hanging" content-width="1em" content-height="scale-to-fit" scaling="uniform" src="{$src}"/>
		</fo:inline>
	</xsl:template>

	<!-- Admonitions -->
	<xsl:template name="nongraphical.admonition">
		<xsl:variable name="id">
			<xsl:call-template name="object.id"/>
		</xsl:variable>

		<fo:block border-left="0.5pt solid black"
			padding-left="1em"
			start-indent="2cm"
			space-before.optimum="1em"
			space-before.maximum="1.2em"
			id="{$id}">
			<xsl:if test="$admon.textlabel != 0 or title">
				<fo:block keep-with-next='always'
					xsl:use-attribute-sets="admonition.title.properties">
					<xsl:apply-templates select="." mode="object.title.markup"/>
				</fo:block>
			</xsl:if>

			<fo:block xsl:use-attribute-sets="admonition.properties">
				<xsl:apply-templates/>
			</fo:block>
		</fo:block>
	</xsl:template>

	<!-- Title page -->
<xsl:template name="book.titlepage.recto">
  <fo:block>
    <fo:table inline-progression-dimension="100%" table-layout="fixed">
      <fo:table-column column-width="50%"/>
      <fo:table-column column-width="50%"/>
      <fo:table-body>
        <fo:table-row >
          <fo:table-cell number-columns-spanned="2">
            <fo:block text-align="center">
              <xsl:choose>
                <xsl:when test="bookinfo/title">
                  <xsl:apply-templates 
                         mode="book.titlepage.recto.auto.mode" 
                         select="bookinfo/title"/>
                </xsl:when>
                <xsl:when test="title">
                  <xsl:apply-templates 
                         mode="book.titlepage.recto.auto.mode" 
                         select="title"/>
                </xsl:when>
              </xsl:choose>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
        <fo:table-row >
          <fo:table-cell number-columns-spanned="2">
            <fo:block text-align="center">
					<fo:external-graphic src="../libs/images/logo.svg"/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
        <fo:table-row >
          <fo:table-cell number-columns-spanned="2">
            <fo:block text-align="center">
              <xsl:choose>
                <xsl:when test="bookinfo/copyright/holder">
                  <xsl:apply-templates 
                         mode="book.titlepage.recto.auto.mode" 
                         select="bookinfo/copyright/holder"/>
                </xsl:when>
              </xsl:choose>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body> 
    </fo:table>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
