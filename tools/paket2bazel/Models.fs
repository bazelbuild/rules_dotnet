module Paket2Bazel.Models

open System.Collections.Generic

type Override = { buildFile: string }

type Config =
    { packageOverrides: Dictionary<string, Override option> option }

type Package =
    { name: string
      group: string
      version: string
      buildFileOverride: string option
      sha512sri: string
      dependencies: Map<string,seq<string>>
      overrides: string seq }

type Group =
    { name: string
      packages: Package seq
      tfms: string seq }
