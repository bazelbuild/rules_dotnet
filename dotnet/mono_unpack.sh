#!/bin/bash
# Copyright 2015 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

working_dir=$1
pkg_file=${2:-"mono.xar"}

cd $working_dir

function clean()
{
    rm -rf mono-mac \
           mono.pkg \
           Distribution \
           Resources \
           Library
}

function unpack()
{
    # NOTE(jwall): This script is intended to work on OS X only.
    # These utilities are for the moment guaranteed to exist
    # on that platform.
    xar -x -f $pkg_file || exit 1
    cpio -i < mono.pkg/Payload || exit 1
    mv Library/Frameworks/Mono.framework/Versions/4.* mono || exit 1
}

rewrite()
{
    cat > mono/bin/mcs <<EOF
#!/bin/sh
script_dir=\$(dirname \$0)

export PATH=\$PATH:\$script_dir
export PKG_CONFIG_PATH=\$PKG_CONFIG_PATH:\$script_dir/../lib/pkgconfig:\$script_dir/../share/pkgconfig

exec \$script_dir/mono \$MONO_OPTIONS \$script_dir/../lib/mono/4.5/mcs.exe "\$@"
EOF
}

all()
{
    clean
    unpack && rewrite
}

all
