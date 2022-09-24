#!/bin/bash
set -e -o pipefail

TIDAL_DIR=$(cd $(dirname $0) && pwd)

source $TIDAL_DIR/../esp-idf/export.sh

export IOT_SOLUTION_PATH=$TIDAL_DIR/esp-iot-solution
export V=1

pushd $TIDAL_DIR
./scripts/firstTime.sh

pushd micropython
make -C mpy-cross

pushd ports/esp32
(cd boards && ln -sfn $TIDAL_DIR/tildamk6 ./tildamk6)

make submodules BOARD=tildamk6 USER_C_MODULES=$TIDAL_DIR/drivers/micropython.cmake
make BOARD=tildamk6 USER_C_MODULES=$TIDAL_DIR/drivers/micropython.cmake
popd
popd
popd
