#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="openbor"
rp_module_desc="OpenBOR - Beat 'em Up Game Engine"
rp_module_menus="4+"
rp_module_flags="!x11 !mali"

function depends_openbor() {
    getDepends libsdl1.2-dev libsdl-gfx1.2-dev libogg-dev libvorbisidec-dev libvorbis-dev libpng12-dev zlib1g-dev
}

function sources_openbor() {
    gitPullOrClone "$md_build" https://github.com/rofl0r/openbor.git
}

function build_openbor() {
    make clean
    NO_GL=1 make
    cd "$md_build/tools/borpak/"
    ./build-linux.sh
    md_ret_require="$md_build/OpenBOR"
}

function install_openbor() {
    md_ret_files=(
       'OpenBOR'
       'tools/borpak/borpak'
       'tools/unpack.sh'
    )
}

function configure_openbor() {
    mkRomDir "ports"
    mkRomDir "ports/$md_id"
    mkUserDir "$configdir/$md_id"

    cat >"$md_inst/extract.sh" <<_EOF_
#!/bin/bash
PORTDIR="$md_inst"
BORROMDIR="$romdir/ports/$md_id"
mkdir \$BORROMDIR/original/
mkdir \$BORROMDIR/original/borpak/
mv \$BORROMDIR/*.pak \$BORROMDIR/original/
cp \$PORTDIR/unpack.sh \$BORROMDIR/original/
cp \$PORTDIR/borpak \$BORROMDIR/original/borpak/
cd \$BORROMDIR/original/
for i in *.pak
do
  CURRENTFILE=\`basename "\$i" .pak\`
  ./unpack.sh "\$i"
  mkdir "\$CURRENTFILE"
  mv data/ "\$CURRENTFILE"/
  mv "\$CURRENTFILE"/ ../
done

echo "Your games are extracted and ready to be played. Your originals are stored safely in $BORROMDIR/original/ but they won't be needed anymore. Everything within it can be deleted."
_EOF_
    chmod +x "$md_inst/extract.sh"
    mkdir "$configdir/$md_id/ScreenShots/"
    mkdir "$configdir/$md_id/Logs/"
    mkdir "$configdir/$md_id/Saves/"
    ln -snf "$configdir/$md_id/ScreenShots/" "$md_inst/ScreenShots"
    ln -snf "$configdir/$md_id/Logs/" "$md_inst/Logs"
    ln -snf "$configdir/$md_id/Saves/" "$md_inst/Saves"

    ln -snf "$romdir/ports/$md_id/" "$md_inst/Paks"
    addPort "$md_id" "openbor" "OpenBOR - Beats of Rage Engine" "pushd $md_inst; $md_inst/OpenBOR; popd"
     __INFMSGS+=("OpenBOR games need to be extracted to function properly. Place your pak files in $romdir/ports/$md_id/ and then run $md_inst/extract.sh. When the script is done, your original pak files will be found in $romdir/ports/$md_id/originals/ and can be deleted.")
}
