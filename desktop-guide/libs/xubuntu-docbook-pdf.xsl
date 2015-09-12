<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
	<!-- This file is a customization layer for PDF -->

	<!-- Imports -->
	<xsl:import href="/usr/share/xml/docbook/stylesheet/nwalsh/fo/docbook.xsl"/>

	<!-- Enabling this means we can have a PDF chapter index -->
	<xsl:param name="fop1.extensions" select="1"/>

	<!-- Page size and margins -->
	<xsl:param name="paper.type" select="'A4'"/>
	<xsl:param name="page.margin.inner" select="'1.5cm'"/>
	<xsl:param name="page.margin.outer" select="'1.5cm'"/>
	<xsl:param name="body.start.indent" select="'1cm'"/>

	<!-- General options -->
	<xsl:param name="hyphenate" select="'false'"/>
	<xsl:attribute-set name="root.properties">
		<xsl:attribute name="font-family">Droid Sans</xsl:attribute>
		<xsl:attribute name="line-height">1.5</xsl:attribute>
	</xsl:attribute-set>
	<xsl:param name="body.font.family" select="'Droid Sans'"/>
	<xsl:param name="title.font.family" select="'Droid Sans'"/>
	<xsl:param name="monospace.font.family" select="'Droid Sans Mono'"/>
	<!-- <xsl:param name="ulink.footnotes">1</xsl:param> -->

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
			<xsl:value-of select="$body.font.master * 1.1"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>

	<!-- Bold and italic styles-->
	<xsl:template match="application/menuchoice/guimenuitem | application/menuchoice/guisubmenu">
		<fo:inline xsl:use-attribute-sets="bold-italic">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="application | filename | guibutton | literal">
		<!-- TODO: This breaks literal since it changes the font -->
		<fo:inline xsl:use-attribute-sets="bold">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="guilabel | guimenu | guimenuitem | keycap">
		<fo:inline xsl:use-attribute-sets="italic">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>

	<xsl:attribute-set name="bold-italic">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="bold">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="italic">
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
	</xsl:attribute-set>

	<!-- Icons -->
	<xsl:template match="imagedata[@role = 'icon']">
		<fo:inline>
			<xsl:variable name="src">
				<xsl:value-of select="@fileref"/>
			</xsl:variable>
			<fo:external-graphic alignment-baseline="mathematical" content-width="1em" content-height="scale-to-fit" scaling="uniform" src="{$src}"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="imagedata[@role = 'icon-pad']">
			<fo:inline>
				<xsl:variable name="src">
					<xsl:value-of select="@fileref"/>
				</xsl:variable>
				<fo:external-graphic alignment-baseline="mathematical" width="1.3em" content-width="1em" content-height="scale-to-fit" scaling="uniform" src="{$src}"/> 
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

	<!-- Don't show links to PDF files in PDF files -->
	<xsl:template match="formalpara[@role= 'pdf-links']">
	</xsl:template>

	<!-- Title page, recto -->
	<xsl:template name="book.titlepage.recto">
		<fo:block text-align="center">
			<xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="title" />
			<fo:external-graphic src="../libs/images/logo.svg"/>
			<fo:block>
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/copyright/holder"/>
			</fo:block>
		</fo:block>
	</xsl:template>

	<!-- Title page, verso -->
	<xsl:template name="book.titlepage.verso">
		<fo:block>
			<xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/title" />
			<xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/copyright" />
			<xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/legalnotice" />
		</fo:block>
		<fo:block page-break-before="always">
			<xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/abstract" />
		</fo:block>
	</xsl:template>

</xsl:stylesheet>
