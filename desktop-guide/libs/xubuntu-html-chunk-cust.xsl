<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

	<!-- This file is a customization layer for HTML only -->
	<!-- ======================= -->
	<!-- Imports -->
	<xsl:import href="/usr/share/xml/docbook/stylesheet/nwalsh/xhtml/chunk.xsl"/>
	<xsl:import href="xubuntu-banner.xsl"/>	

	<!-- Params -->
	<xsl:param name="generate.legalnotice.link" select="1"/>
	<xsl:param name="generate.revhistory.link" select="1"/>	<!-- requires DocBook XSL 1.69.1a -->
	<xsl:param name="use.id.as.filename" select="1"/>
	<!-- <xsl:param name="generate.toc" select="'no'"/> -->
	<xsl:param name="toc.section.depth" select="1"/>
	<xsl:param name="chunker.output.indent" select="'yes'"/>
	<xsl:param name="body.font.master" select="10"/>
	<xsl:param name="html.stylesheet" select="'../libs/xubuntu-book.css'"/>
	<xsl:param name="shade.verbatim" select="0"/>
	<xsl:param name="draft.mode" select="'no'"/>

	<!-- disable scaling (which is needed for PDF generation) -->
	<xsl:param name="ignore.image.scaling" select="1"/>

	<!--Navigation Graphics-->
	<xsl:param name="navig.graphics" select="1"/>
	<xsl:param name="navig.graphics.path" select="'../libs/navig/'"/>
	<xsl:param name="navig.graphics.extension" select="'.png'"/> 
	<xsl:param name="navig.showtitles" select="1"/>
	
	<!--Admon Graphics--> 
	<xsl:param name="admon.graphics" select="1"/>
	<xsl:param name="admon.textlabel" select="0"/>
	<xsl:param name="admon.graphics.path" select="'../libs/admon/'"/>
	<xsl:param name="admon.graphics.extension" select="'.png'"/>
	
	<!-- Callout Graphics -->
	<xsl:param name="callout.unicode" select="1"/>
	<xsl:param name="callout.graphics" select="0"/>
	<xsl:param name="callout.graphics.path" select="'../libs/callouts/'"/>
	<xsl:param name="callout.graphics.extension" select="'.png'"/>
	
	<!-- Show all subpages directly below the mainpage -->
	<xsl:param name="chunk.section.depth" select="0" />

	<!-- Inline Formatting -->
	<xsl:template match="application">
		<xsl:call-template name="inline.boldseq"/>
	</xsl:template>
	<xsl:template match="guibutton">
		<xsl:call-template name="inline.boldseq"/>
	</xsl:template>
	<xsl:template match="guilabel">
		<xsl:call-template name="inline.italicseq"/>
	</xsl:template>
	<xsl:template match="processing-instruction('br')">
		<br />
		<fo:block/>
	</xsl:template>

	<!-- Icons -->
	<xsl:template match="inlinemediaobject[@role = 'icon-pkg']" mode="class.value">
		<xsl:value-of select="'inline-icon-pkg'"/>
	</xsl:template>
	<xsl:template match="inlinemediaobject[@role = 'icon-key']" mode="class.value">
		<xsl:value-of select="'inline-icon-key'"/>
	</xsl:template>
	<xsl:template match="inlinemediaobject[@role = 'icon-location']" mode="class.value">
		<xsl:value-of select="'inline-icon-location'"/>
	</xsl:template>

	<!-- Not in use (yet) -->
	<xsl:template match="legalnotice/screen">
		<xsl:param name="content">
			<xsl:call-template name="simple.xlink">
				<xsl:with-param name="content">
					<xsl:apply-templates/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:param>

		<xsl:comment>
			<xsl:copy-of select="$content"/>
		</xsl:comment>
	</xsl:template>
	<!-- -->

</xsl:stylesheet>
