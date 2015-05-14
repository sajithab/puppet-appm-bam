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
# Class: appm
#
# This class installs WSO2 AppManager
# Actions:
#   - Install WSO2 AppManager
#
# Requires:
#
# Sample Usage:
#

class appm (
  $version            = undef,
  $offset             = 0,
  $maintenance_mode   = true,
  $depsync            = false,
  $owner              = 'root',
  $group              = 'root',
  $target             = "/mnt/${server_ip}",
  
) inherits params {

  $deployment_code = 'appm'
  $carbon_version  = $version
  $service_code    = 'appm'
  $carbon_home     = "${target}/wso2${service_code}-${carbon_version}"
  $service_templates = [
      'conf/app-manager.xml',
      'conf/datasources/master-datasources.xml',
      ]

  tag($service_code)

  appm::clean { $deployment_code:
    mode   => $maintenance_mode,
    target => $carbon_home,
  }

  appm::initialize { $deployment_code:
    repo      => $package_repo,
    version   => $carbon_version,
    service   => $service_code,
    local_dir => $local_package_dir,
    target    => $target,
    mode      => $maintenance_mode,
    owner     => $owner,
    require   => Appm::Clean[$deployment_code],
  }

  appm::deploy { $deployment_code:
    security => true,
    owner    => $owner,
    group    => $group,
    target   => $carbon_home,
    require  => Appm::Initialize[$deployment_code],
  }

  appm::push_templates {
    $service_templates:
      target    => $carbon_home,
      directory => $deployment_code,
      require   => Appm::Deploy[$deployment_code];
  }

  file {
    "${carbon_home}/repository/components/lib/${mysql_connector_name}":
      ensure => present,
      source => ["puppet:///modules/${$deployment_code}/${mysql_connector_name}"],
      mode    => '0755',
      require   => Appm::Push_templates[$service_templates];
  }

  appm::start { $deployment_code:
    owner   => $owner,
    target  => $carbon_home,
    require => [
      Appm::Initialize[$deployment_code],
      Appm::Deploy[$deployment_code],
      Appm::Push_templates[$service_templates],
      ],
  }
}
