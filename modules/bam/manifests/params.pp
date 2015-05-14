# ----------------------------------------------------------------------------
#  Copyright 2005-2015 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------
#
# Class bam::params
#
# This class manages bam parameters



class bam::params {

  $local_package_dir    = '/mnt/packs'
  $admin_username       = 'ADMIN_USER'
  $admin_password       = 'ADMIN_PASSWORD'

  # Database details
  $is_mysql_connector	= true
  $mysql_connector_name = 'mysql-connector-java-5.1.23-bin.jar'
  $is_mysql_carbon_db   = true
  $is_h2_carbon_db      = false
  $is_mysql_stat_db	= true
  $is_h2_stat_db	= false
  $jndi_datasource_for_carbon_db= 'jdbc/WSO2CarbonDB'
  $jndi_datasource_for_am_db	= 'jdbc/WSO2AM_DB'
  $jndi_datasource_for_stat_db	= 'jdbc/WSO2AM_STATS_DB'

  # MySQL server configuration details
  $mysql_server         = '10.100.7.19'
  $mysql_port           = '3306'
  $max_connections      = '100000'
  $max_active           = '50'
  $max_wait             = '60000'
  $mysql_database_name_for_carbon_db	= 'WSO2_CARBON_DB'
  $mysql_username	= 'user'
  $mysql_password	= 'password'
  $mysql_database_name_for_stat_db	= 'WSO2AM_STATS_DB'

  # H2 server configuration details
  $h2_db_path_for_carbon_db	= 'repository/database'
  $h2_db_path_for_stat_db	= 'repository/database'
  $h2_database_name_for_carbon_db	= 'WSO2CARBON_DB'
  $h2_username		= 'wso2carbon'
  $h2_password		= 'wso2carbon'
  $h2_database_name_for_stat_db		= 'WSO2AM_STATS_DB'

  # Thrift protocol configration details
  $thrift_datareceiver_host_name= '0.0.0.0'
  $thrift_datareceiver_port	= '7611'
  $thrift_datareceiver_sslport	= '7711'

  $registry_user        = 'DB_USER'
  $registry_password    = 'DB_PASSWORD'
  $registry_database    = 'REGISTRY_DB'

  $userstore_user       = 'DB_USER'
  $userstore_password   = 'DB_PASSWORD'
  $userstore_database   = 'USERSTORE_DB'

  #LDAP settings - Not used
  $ldap_connection_uri      = 'ldap://localhost:10389'
  $bind_dn                  = 'uid=admin,ou=system'
  $bind_dn_password         = 'adminpassword'
  $user_search_base         = 'ou=system'
  $group_search_base        = 'ou=system'
  $sharedgroup_search_base  = 'ou=SharedGroups,dc=wso2,dc=org'

  #Proxy ports
  $http_proxy_port             = '80'
  $https_proxy_port             = '443'
}
