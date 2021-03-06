<?xml version="1.0" encoding="UTF-8"?>
<!-- XSLT file to add the security domains to the standalone.xml -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:as="urn:jboss:domain:1.4"
  xmlns="urn:jboss:domain:1.4" xmlns:inf="urn:jboss:domain:infinispan:1.4"
  xmlns:xalan="http://xml.apache.org/xalan" 
  exclude-result-prefixes="inf xalan as" version="1.0">

  <xsl:output method="xml" encoding="UTF-8" indent="yes" xalan:indent-amount="2" />

  <xsl:template match="as:server/as:extensions">
      <extensions>
        <xsl:apply-templates select="@* | *" />
        <extension module="org.modeshape"/>
      </extensions>
  </xsl:template>

  <xsl:template match="as:profile">
    <profile>
        <xsl:apply-templates select="@* | *" />
        <subsystem xmlns="urn:jboss:domain:modeshape:1.0">
            <repository name="sramp" cache-name="sramp" cache-container="modeshape" 
                        security-domain="overlord-idp" use-anonymous-upon-failed-authentication="false"
                        anonymous-roles="readonly">
            </repository>
        </subsystem>
    </profile>
  </xsl:template>

  <xsl:template match="as:profile/inf:subsystem">
        <subsystem xmlns="urn:jboss:domain:infinispan:1.4" default-cache-container="hibernate">
            <xsl:apply-templates select="@* | *" />
            <cache-container name="modeshape">
                <local-cache name="sramp">
                    <locking isolation="NONE"/>
                    <transaction mode="NON_XA"/>
                    <string-keyed-jdbc-store datasource="java:jboss/datasources/srampDS" passivation="false" purge="false">
                        <string-keyed-table prefix="ispn_bucket">
                            <id-column name="id" type="VARCHAR(500)"/>
                            <data-column name="datum" type="VARBINARY(60000)"/>
                            <timestamp-column name="version" type="BIGINT"/>
                        </string-keyed-table>
                    </string-keyed-jdbc-store>
                </local-cache>
            </cache-container>
        </subsystem>
  </xsl:template>

  <!-- Copy everything else. -->
  <xsl:template match="@*|node()|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()|text()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>