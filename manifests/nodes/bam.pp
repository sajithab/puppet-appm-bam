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

# bam node

node /as-mgt1/ inherits base {

    notify { $name: 
      message => "On bam node",
    }

  $docroot = "/mnt/${server_ip}/wso2bam-2.5.0"

  class {'bam':

        version            => '2.5.0',
	offset		   => 0,
	maintenance_mode   => 'zero',
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}"
  }
  
  require java	

  Class['java'] -> Class['bam']
}
