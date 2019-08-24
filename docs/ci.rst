CI Configuration
================

Azure DevOps setup
------------------

* Install `Chocolatey build task <https://marketplace.visualstudio.com/items?itemName=gep13.chocolatey-azuredevops>`_.


Windows build agent
-------------------

Windows build agent requires the following steps to prepare:

* Upgrade to the `latest version <https://www.microsoft.com/en-us/software-download/windows10>`_. It is required to support long paths and symbolic file linking.

* Install `chocolatey <https://chocolatey.org/install>`_.

* Enable long file path support (via group policy)

* Install all dependencies:

  .. code:: bash

    choco install netfx-4.7.2-devpack netfx-4.7.1-devpack netfx-4.7-devpack netfx-4.6.2-devpack netfx-4.6.1-devpack 
    netfx-4.6-devpack netfx-4.5.2-devpack netfx-4.5.1-devpack mono bazel

* Install dependencies not available from chocolatey (at the time of this writing):

   * .Net Framework 4.8 developer pack


