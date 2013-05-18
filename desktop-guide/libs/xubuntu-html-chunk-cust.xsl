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
	<!-- requires DocBook XSL 1.69.1a -->
	<xsl:param name="generate.revhistory.link" select="1"/>
	<!-- <xsl:param name="generate.toc" select="'no'"/> -->

	<xsl:param name="toc.section.depth" select="1"/>
	<xsl:param name="chunker.output.indent" select="'yes'"/>
	<xsl:param name="body.font.master" select="10"/>
	<xsl:param name="html.stylesheet" select="'includes/xubuntu-book.css'"/>
	<xsl:param name="shade.verbatim" select="0"/>
	<xsl:param name="draft.mode" select="'no'"/>

	<!-- disable scaling (which is needed for PDF generation) -->
	<xsl:param name="ignore.image.scaling" select="1"/>

	<!--Navigation Graphics-->
	<xsl:param name="navig.graphics" select="1"/>
	<xsl:param name="navig.graphics.path" select="'includes/navig/'"/>
	<xsl:param name="navig.graphics.extension" select="'.png'"/> 
	<xsl:param name="navig.showtitles" select="1"/>
	
	<!--Admon Graphics--> 
	<xsl:param name="admon.graphics" select="1"/>
	<xsl:param name="admon.textlabel" select="0"/>
	<xsl:param name="admon.graphics.path" select="'includes/admon/'"/>
	<xsl:param name="admon.graphics.extension" select="'.png'"/>
	
	<!-- Callout Graphics -->
	<xsl:param name="callout.unicode" select="1"/>
	<xsl:param name="callout.graphics" select="0"/>
	<xsl:param name="callout.graphics.path" select="'includes/callouts/'"/>
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


	<xsl:param name="use.id.as.filename" select="1"/>
    
	<!-- this strippath template is copied from the 1.68.1 version of common.xls  -->
	<xsl:template name="strippath">
		<xsl:param name="filename" select="''"/>
		<xsl:choose>
			<!-- Leading .. are not eliminated -->
			<xsl:when test="starts-with($filename, '../')">
				<xsl:value-of select="'../'"/>
				<xsl:call-template name="strippath">
					<xsl:with-param name="filename" select="substring-after($filename, '../')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="contains($filename, '/../')">
				<xsl:call-template name="strippath">
					<xsl:with-param name="filename">
						<xsl:call-template name="getdir">
							<xsl:with-param name="filename" select="substring-before($filename, '/../')"/>
						</xsl:call-template>
						<xsl:value-of select="substring-after($filename, '/../')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$filename"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
