module Paket2Bazel.Models

open System.Collections.Generic

type Package =
    { name: string
      group: string
      version: string
      sha512sri: string
      sources: string seq
      dependencies: Map<string, seq<string>>
      overrides: string seq
      frameworkList: string seq }

type Group =
    { name: string
      packages: Package seq
      tfms: string seq }
