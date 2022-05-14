module Paket2Bazel.Models

type Override = { buildFile: string }

type Package =
    { name: string
      group: string
      version: string
      buildFileOverride: string option }

type TargetedPackage =
    { lib: string option
      deps: string list
      ref: string option
      tool: string option 
      pdb: string option
      files: string list }

type ProcessedPackage =
    { name: string
      package: string
      group: string
      version: string
      buildFileOverride: string option
      sha256: string
      targets: Map<string, TargetedPackage> }
