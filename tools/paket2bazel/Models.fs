module Paket2Bazel.Models
open System.Collections.Generic

type Override = { buildFile: string }

type Config = { packageOverrides: Dictionary<string, Override option> option }

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
