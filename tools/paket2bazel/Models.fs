module Paket2Bazel.Models

type Override = { buildFile: string }

type Package =
    { name: string
      group: string
      version: string
      buildFileOverride: string option }

type ProcessedPackage =
    { name: string
      package: string
      group: string
      version: string
      buildFileOverride: string option
      sha256: string
      lib: (string * string) list
      deps: (string * string list) list
      refItems: (string * string) list
      toolItems: (string * string) list
      fileItems: (string * string list) list }
