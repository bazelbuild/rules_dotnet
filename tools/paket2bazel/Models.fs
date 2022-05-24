module Paket2Bazel.Models

open System.Collections.Generic
open Paket.Requirements
open Paket

type Override = { buildFile: string }

type Config =
    { packageOverrides: Dictionary<string, Override option> option }

type Package =
    { name: string
      group: string
      version: string
      buildFileOverride: string option
      sha256: string
      dependencies: Map<FrameworkIdentifier,list<string>>
      libs: Map<FrameworkIdentifier,list<string>>
      refs: Map<FrameworkIdentifier,list<string>>
      pdbs: Map<FrameworkIdentifier,list<string>>
      runtimeFiles: Map<FrameworkIdentifier,Map<string,list<string>>> }

type Group =
    { name: string
      packages: Package list
      tfms: FrameworkIdentifier list }

let supportedRids = ["win-x64"; "linux-x64"; "osx-x64"; "osx-arm64"]

// type TargetedPackage =
//     { lib: string option
//       deps: string list
//       ref: string option
//       tool: string option
//       pdb: string option
//       files: string list }

// type ProcessedPackage =
//     { name: string
//       package: string
//       group: string
//       version: string
//       buildFileOverride: string option
//       sha256: string
//       targets: Map<string, TargetedPackage> }
