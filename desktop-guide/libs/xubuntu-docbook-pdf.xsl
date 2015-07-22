<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
	<!-- This file is a customization layer for PDF -->

	<!-- Imports -->
	<xsl:import href="/usr/share/xml/docbook/stylesheet/nwalsh/fo/docbook.xsl"/>

	<!-- Enabling this means we can have a PDF chapter index -->
	<xsl:param name="fop1.extensions" select="1"/>

	<xsl:param name="menuchoice.menu.separator" select="' » '"/>
	<xsl:param name="hyphenate" select="'false'"/>

</xsl:stylesheet>
