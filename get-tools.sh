#!/bin/bash

git clone https://github.com/matt-kempster/mips_to_c.git
git clone --recurse-submodules -j8 https://github.com/queueRAM/sm64tools.git
cd sm64tools && make; cd -
