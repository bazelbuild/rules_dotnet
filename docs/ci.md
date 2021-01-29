CI Configuration
================

Azure DevOps setup
------------------

* Install [Chocolatey build task](https://marketplace.visualstudio.com/items?itemName=gep13.chocolatey-azuredevops).


Windows build agent
-------------------

Windows build agent requires the following steps to prepare:

* Install Azure Dev build agent. Make sure it runs as an admin.

* Upgrade to the [latest version](https://www.microsoft.com/en-us/software-download/windows10). It is required to support long paths and symbolic file linking.

* Install [chocolatey](https://chocolatey.org/install).

* Enable long file path support (via group policy).

* Enable Developer's mode to support non-admin symbolic linking.

