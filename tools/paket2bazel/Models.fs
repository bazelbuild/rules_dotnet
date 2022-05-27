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
      dependencies: Map<string,seq<string>>
      libs: Map<string,seq<string>>
      refs: Map<string,seq<string>>
      pdbs: Map<string,seq<string>>
      runtimeFiles: Map<string,Map<string,seq<string>>> }

type Group =
    { name: string
      packages: Package seq
      tfms: string seq }

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
