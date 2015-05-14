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

# appm node

node /as-mgt2/ inherits base {

    notify { $name: 
      message => "On appm node",
    }

  $docroot = "/mnt/${server_ip}/wso2appm-1.0.0-SNAPSHOT"

  class {'appm':

        version            => '1.0.0-SNAPSHOT',
	offset		   => 0,
	maintenance_mode   => 'zero',
        depsync            => false,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}"
  }
  
  require java	

  Class['java'] -> Class['appm']
}
