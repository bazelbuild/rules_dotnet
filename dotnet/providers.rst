Dotnet providers
================

.. _providers: https://docs.bazel.build/versions/master/skylark/rules.html#providers
.. _runfiles: https://docs.bazel.build/versions/master/skylark/lib/runfiles.html
.. _File: https://docs.bazel.build/versions/master/skylark/lib/File.html

.. role:: param(emphasis)
.. role:: type(emphasis)
.. role:: value(code)
.. |mandatory| replace:: **mandatory value**


The providers_ are the outputs of the rules, you generaly get them by having a dependency on a rule,
and then asking for a provider of a specific type.

.. contents:: :depth: 2

-----

Design
------

The Dotnet providers are designed primarily for the efficiency of the dotnet rules, the information
they share is mostly there because it is required for the core rules to work.

All the providers are designed to hold only immutable data. This is partly because its a cleaner
design choice to be able to assume a provider will never change, but also because only immutable
objects are allowed to be stored in a depset, and it's really useful to have depsets of providers.
Specifically the :param:`deps` and :param:`transitive` fields on DotnetLibrary_ only work because
it is immutable.

API
---


DotnetLibrary
~~~~~~~~~~~~~

DotnetLibrary is a provider that exposes a compiled assembly along with it's full transitive
dependencies.

+--------------------------------+-----------------------------------------------------------------+
| **Name**                       | **Type**                                                        |
+--------------------------------+-----------------------------------------------------------------+
| :param:`label`                 | :type:`Label`                                                   |
+--------------------------------+-----------------------------------------------------------------+
| Label of the rules used to create this assembly                                                  |
+--------------------------------+-----------------------------------------------------------------+
| :param:`name`                  | :type:`string`                                                  |
+--------------------------------+-----------------------------------------------------------------+
| Name of the assembly. Label.name is used if not provided                                         |
+--------------------------------+-----------------------------------------------------------------+
| :param:`version`               | :type:`string`                                                  |
+--------------------------------+-----------------------------------------------------------------+
| Version number of the library.                                                                   |
+--------------------------------+-----------------------------------------------------------------+
| :param:`deps`                  | :type:`list of DotnetLibrary`                                   |
+--------------------------------+-----------------------------------------------------------------+
| The direct dependencies of this library.                                                         |
+--------------------------------+-----------------------------------------------------------------+
| :param:`transitive`            | :type:`depset of DotnetLibrary`                                 |
+--------------------------------+-----------------------------------------------------------------+
| The full set of transitive dependencies. This includes ``deps`` for this                         |
| library and all ``deps`` members transitively reachable through ``deps``.                        |
+--------------------------------+-----------------------------------------------------------------+
| :param:`result`                | :type:`file`                                                    |
+--------------------------------+-----------------------------------------------------------------+
| The assembly file                                                                                |
+--------------------------------+-----------------------------------------------------------------+
| :param:`pdb`                   | :type:`file`                                                    |
+--------------------------------+-----------------------------------------------------------------+
| The pdb file (with compilation mode dbg)                                                         |
+--------------------------------+-----------------------------------------------------------------+
| :param:`runfiles`              | :type:`depset of File`                                          |
+--------------------------------+-----------------------------------------------------------------+
| The depset of files required to run given assembly. It should include result and pdb             |
| (if generated).                                                                                  |
+--------------------------------+-----------------------------------------------------------------+
| :param:`ref`                   | :type:`file`                                                    |
+--------------------------------+-----------------------------------------------------------------+
| The reference assembly file to be used. If not provided then ``result`` is used for compilation  |
| of dependant targets.                                                                            |
+--------------------------------+-----------------------------------------------------------------+
| :param:`transitive_refs`       | :type:`depset of File`                                          |
+--------------------------------+-----------------------------------------------------------------+
| The full set of transitive refs. This includes ref or result for this assembly                   |
| and all ``transitive_refs`` members transitively reachable through ``deps``.                     |
+--------------------------------+-----------------------------------------------------------------+


DotnetResource
~~~~~~~~~~~~~~

DotnetResource is a provider that exposes a compiled resource (.resources file).

+--------------------------------+-----------------------------------------------------------------+
| **Name**                       | **Type**                                                        |
+--------------------------------+-----------------------------------------------------------------+
| :param:`identifer`             | :type:`string`                                                  |
+--------------------------------+-----------------------------------------------------------------+
| The logical name for the resource; the name that is used to load the resource.                   | 
| The default is the basename of the file name (no subfolder).                                     |
+--------------------------------+-----------------------------------------------------------------+
