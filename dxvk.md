# How to run DX9/10/11 traces

With a trace posted like on https://gitlab.freedesktop.org/mesa/mesa/-/issues/12880

Download apitrace windows build (32bits or 64bits depending on the
capture) at https://github.com/apitrace/apitrace/releases/

Download DXVK release from https://github.com/doitsujin/dxvk/releases

Copy the DXVK dll next to the apitrace windows binaries.

Replay the trace :

  $ wine ./d3dretrace.exe /path/to/trace.trace
