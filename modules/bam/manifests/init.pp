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
# Class: bam
#
# Requires:
#
# Sample Usage:
#

class bam (
  $version            = undef,
  $offset             = 0,
  $maintenance_mode   = true,
  $owner              = 'root',
  $group              = 'root',
  $target             = "/mnt/${server_ip}",
  
) inherits params {

  $deployment_code = 'bam'
  $carbon_version  = $version
  $service_code    = 'bam'
  $carbon_home     = "${target}/wso2${service_code}-${carbon_version}"
  $service_templates =  [
      'conf/carbon.xml',
      'conf/datasources/bam-datasources.xml',
      'conf/data-bridge/data-bridge-config.xml',
  ]

  tag($service_code)

  bam::clean { $deployment_code:
    mode   => $maintenance_mode,
    target => $carbon_home,
  }

  bam::initialize { $deployment_code:
    repo      => $package_repo,
    version   => $carbon_version,
    service   => $service_code,
    local_dir => $local_package_dir,
    target    => $target,
    mode      => $maintenance_mode,
    owner     => $owner,
    require   => Bam::Clean[$deployment_code],
  }

  bam::deploy { $deployment_code:
    security => true,
    owner    => $owner,
    group    => $group,
    target   => $carbon_home,
    require  => Bam::Initialize[$deployment_code],
  }

  bam::push_templates {
    $service_templates:
      target    => $carbon_home,
      directory => $deployment_code,
      require   => Bam::Deploy[$deployment_code];
  }


  file {
    "${carbon_home}/repository/deployment/server/bam-toolbox/App_Manager_Analytics.tbox":
      ensure => present,
      source => ["puppet:///modules/bam/App_Manager_Analytics.tbox"],
      mode    => '0755',
      require   => Bam::Push_templates[$service_templates];
  }

  if $is_mysql_connector == true {
	  file {
	    "${carbon_home}/repository/components/lib/${mysql_connector_name}":
	      ensure => present,
	      source => ["puppet:///modules/bam/${mysql_connector_name}"],
	      mode    => '0755',
	      require   => Bam::Push_templates[$service_templates];
	  }
  }

  bam::start { $deployment_code:
    owner   => $owner,
    target  => $carbon_home,
    require => [
      Bam::Initialize[$deployment_code],
      Bam::Deploy[$deployment_code],
      Bam::Push_templates[$service_templates],
      ],
  }

}
