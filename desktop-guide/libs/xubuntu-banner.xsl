<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template name="header.navigation">
		<xsl:variable name="home" select="/*[1]"/>
		<xsl:variable name="up" select="parent::*"/>
			<div id="masthead">
				<a href="index.html">
					<img src="../libs/images/logo.png" alt="Xubuntu" />
				</a>
			</div>
	</xsl:template>
</xsl:stylesheet>
