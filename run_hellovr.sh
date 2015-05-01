#!/bin/sh

#ARCH=32
ARCH=64

#Only for mesa, doesn't hurt anyone else
#Only works for radeon, not for intel. Why?
export MESA_GL_VERSION_OVERRIDE=4.1 MESA_GLSL_VERSION_OVERRIDE=410

export LD_LIBRARY_PATH=lib/linux$ARCH

# must be run with -nocompositor on linux for now https://github.com/ValveSoftware/openvr/issues/5#issuecomment-98466806
samples/hellovr_opengl/hellovr -nocompositor "$@"
