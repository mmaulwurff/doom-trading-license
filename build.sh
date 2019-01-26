#!/bin/bash

name=trading-license

acc source/$name.acs acs/$name.o \
&& \
rm -f $name.pk3 \
&& \
git log --date=short --pretty=format:"-%d %ad %s%n" | \
    grep -v "^$" | \
    sed "s/HEAD -> master, //" | \
    sed "s/, origin\/master//" | \
    sed "s/ (HEAD -> master)//" | \
    sed "s/ (origin\/master)//"  |\
    sed "s/- (tag: \(v\?[0-9.]*\))/\n\1\n-/" \
    > changelog.txt \
&& \
zip $name.pk3 \
    acs/$name.o \
    source/$name.acs \
    zscript/*.txt \
    *.txt \
    *.md \
    graphics/*.png \
&& \
cp $name.pk3 $name-$(git describe --abbrev=0 --tags).pk3 \
&& \
gzdoom \
       -iwad ~/Programs/Games/wads/doom/HERETIC.WAD \
       -file \
       $name.pk3 \
       ~/Programs/Games/wads/maps/HERETEST.wad \
       "$1" "$2" \
       +map test \
       +notarget \
       +summon mummy \
       +give all \
