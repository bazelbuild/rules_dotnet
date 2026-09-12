# internals_visible_to

`collect_compile_info` picks a dependency's internals-carrying reference
assembly when the target being compiled is named in that dependency's
`internals_visible_to`. With `--@rules_dotnet//dotnet/settings:strict_deps=false`
it also walks each dependency's transitive closure in the same loop, so the
assembly name it matches on has to survive that walk.

`consumer` depends on `chain` and `secrets`, in that order. `chain` has a
dependency of its own, so the closure walk runs at least once before `secrets`
is looked at; `secrets` grants its internals to `consumer`. If the name is lost
during the walk, the compile fails with CS0117.

The order matters, and it is deliberately the order buildifier sorts `deps`
into, so that formatting the file cannot quietly defeat the test.
