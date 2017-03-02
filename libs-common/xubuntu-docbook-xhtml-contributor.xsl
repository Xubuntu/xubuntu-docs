<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
	<!-- This file is a customization layer for HTML -->

	<!-- Imports -->
	<xsl:import href="xubuntu-docbook-xhtml.xsl"/>

	<!-- Params -->
	<xsl:param name="toc.max.depth" select="3"/>
	<xsl:param name="chunk.section.depth" select="1" />
	<xsl:param name="chunk.first.sections" select="1" />
	<xsl:param name="generate.section.toc.level" select="3"/>

	<xsl:param name="generate.toc">
		appendix toc
		appendix/section nop
		appendix/section/section nop
		book toc
		chapter toc
		chapter/section/section nop
		part toc
		section toc
	</xsl:param>

	<xsl:template match="chapter" mode="toc">
		<xsl:call-template name="subtoc">
			<xsl:with-param name="nodes" select="section|section/sect1"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="sect1" mode="toc">
		<dd><xsl:call-template name="toc.line"/></dd>
	</xsl:template>
</xsl:stylesheet>
