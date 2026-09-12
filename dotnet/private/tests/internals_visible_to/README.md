# internals_visible_to

`collect_compile_info` hands the compiler a dependency's internals-carrying
reference assembly when the target being compiled is named in that dependency's
`internals_visible_to`. Under
`--@rules_dotnet//dotnet/settings:strict_deps=false` the same loop also walks
each dependency's transitive closure, so the assembly name it matches on has to
survive that walk. CI runs the suite with strict deps both on and off.

`consumer` depends on `chain` and then `secrets`. `chain` has a dependency of
its own, so the closure walk runs before `secrets` is reached; `secrets` is the
one that grants its internals to `consumer`. If the name is lost during the
walk, the compile fails with CS0117.

That order is also the one buildifier sorts `deps` into, so formatting the file
cannot quietly defeat the test. Renaming either library would.
