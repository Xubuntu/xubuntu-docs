<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
	<!-- This file is a customization layer for HTML -->

	<!-- Imports -->
	<xsl:import href="/usr/share/xml/docbook/stylesheet/nwalsh/xhtml/chunk.xsl"/>

	<!-- Params -->
	<xsl:param name="generate.legalnotice.link" select="1"/>
	<xsl:param name="generate.revhistory.link" select="1"/>	<!-- requires DocBook XSL 1.69.1a -->
	<xsl:param name="use.id.as.filename" select="1"/>
	<xsl:param name="toc.section.depth" select="1"/>
	<xsl:param name="chunker.output.indent" select="'yes'"/>
	<xsl:param name="body.font.master" select="10"/>
	<xsl:param name="html.stylesheet" select="'../libs-common/css/style.css'"/>
	<xsl:param name="shade.verbatim" select="0"/>
	<xsl:param name="draft.mode" select="'no'"/>

	<!-- Write HTML header -->
	<xsl:template name="user.head.content">
		<!-- Favicon -->
		<link rel="shortcut icon" href="../libs-common/images/favicon.png" />
		<!-- Viewport meta -->
		<meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1.0, initial-scale=1" />
		<!-- Responsive design -->
		<link rel="stylesheet" href="../libs-common/css/style-resp-950.css" media="only screen and (max-width:950px)" />
		<link rel="stylesheet" href="../libs-common/css/style-resp-400.css" media="only screen and (max-width:400px)" />
	</xsl:template>

	<!-- Print header with logo -->
	<xsl:template name="header.navigation">
		<xsl:variable name="home" select="/*[1]"/>
		<xsl:variable name="up" select="parent::*"/>
			<div id="masthead">
				<a href="index.html">
					<img src="../libs-common/images/logo.png" alt="Xubuntu" />
				</a>
			</div>
	</xsl:template>

	<!-- Navigation Graphics -->
	<xsl:param name="navig.graphics" select="1"/>
	<xsl:param name="navig.graphics.path" select="'../libs-common/images/'"/>
	<xsl:param name="navig.graphics.extension" select="'.png'"/> 
	<xsl:param name="navig.showtitles" select="1"/>

	<!-- Admon Graphics --> 
	<xsl:param name="admon.graphics" select="1"/>
	<xsl:param name="admon.textlabel" select="0"/>
	<xsl:param name="admon.graphics.path" select="'../libs-common/images/'"/>
	<xsl:param name="admon.graphics.extension" select="'.png'"/>
	
	<!-- Show all subpages directly below the mainpage -->
	<xsl:param name="chunk.section.depth" select="0" />

	<!-- Formatting -->
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
	<xsl:template match="formalpara[@role = 'pdf-links']" mode="class.value">
		<xsl:value-of select="'pdf-links'"/>
	</xsl:template>

	<!-- Icons -->
	<xsl:template match="inlinemediaobject[@role = 'icon-branch']" mode="class.value">
		<xsl:value-of select="'inline-icon-branch'"/>
	</xsl:template>
	<xsl:template match="inlinemediaobject[@role = 'icon-pkg']" mode="class.value">
		<xsl:value-of select="'inline-icon-pkg'"/>
	</xsl:template>
	<xsl:template match="inlinemediaobject[@role = 'icon-key']" mode="class.value">
		<xsl:value-of select="'inline-icon-key'"/>
	</xsl:template>
	<xsl:template match="inlinemediaobject[@role = 'icon-location']" mode="class.value">
		<xsl:value-of select="'inline-icon-location'"/>
	</xsl:template>
	<xsl:template match="inlinemediaobject[@role = 'icon-menu']" mode="class.value">
		<xsl:value-of select="'inline-icon-menu'"/>
	</xsl:template>
	<xsl:template match="inlinemediaobject[@role = 'icon-submenu']" mode="class.value">
		<xsl:value-of select="'inline-icon-submenu'"/>
	</xsl:template>

	<!-- Normalize appearance of cross references -->
	<xsl:template match="bridgehead|refsection|refsect1|refsect2|refsect3|sect1|sect2
		|sect3|sect4|sect5|section|simplesect" mode="object.xref.template">
		<xsl:text>%t</xsl:text>
	</xsl:template>

	<!-- Disable tooltips on links -->
	<xsl:template match="*" mode="html.title.attribute"/>

</xsl:stylesheet>
