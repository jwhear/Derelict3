/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.opengl3.wgl;

private
{
    import std.string;
    import derelict.util.wintypes;
}

version(Windows)
{
    extern(Windows)
    {
        alias BOOL function(void*,void*) da_wglCopyContext;
        alias void* function(void*) da_wglCreateContext;
        alias void* function(void*,int) da_wglCreateLayerContext;
        alias BOOL function(void*) da_wglDeleteContext;
        alias BOOL function(void*,int,int,UINT,LAYERPLANEDESCRIPTOR*) da_wglDescribeLayerPlane;
        alias void* function() da_wglGetCurrentContext;
        alias void* function() da_wglGetCurrentDC;
        alias int function(void*,int,int,int,COLORREF*) da_wglGetLayerPaletteEntries;
        alias FARPROC function(LPCSTR) da_wglGetProcAddress;
        alias BOOL function(void*,void*) da_wglMakeCurrent;
        alias BOOL function(void*,int,BOOL) da_wglRealizeLayerPalette;
        alias int function(void*,int,int,int,COLORREF*) da_wglSetLayerPaletteEntries;
        alias BOOL function(void*,void*) da_wglShareLists;
        alias BOOL function(void*,UINT) da_wglSwapLayerBuffers;
        alias BOOL function(void*,DWORD,DWORD,DWORD) da_wglUseFontBitmapsW;
        alias BOOL function(void*,DWORD,DWORD,DWORD,FLOAT,FLOAT,int,GLYPHMETRICSFLOAT*) da_wglUseFontOutlinesW;

    }

    da_wglCopyContext wglCopyContext;
    da_wglCreateContext wglCreateContext;
    da_wglCreateLayerContext wglCreateLayerContext;
    da_wglDeleteContext wglDeleteContext;
    da_wglDescribeLayerPlane wglDescribeLayerPlane;
    da_wglGetCurrentContext wglGetCurrentContext;
    da_wglGetCurrentDC wglGetCurrentDC;
    da_wglGetLayerPaletteEntries wglGetLayerPaletteEntries;
    da_wglGetProcAddress wglGetProcAddress;
    da_wglMakeCurrent wglMakeCurrent;
    da_wglRealizeLayerPalette wglRealizeLayerPalette;
    da_wglSetLayerPaletteEntries wglSetLayerPaletteEntries;
    da_wglShareLists wglShareLists;
    da_wglSwapLayerBuffers wglSwapLayerBuffers;
    da_wglUseFontBitmapsW wglUseFontBitmapsW;
    da_wglUseFontOutlinesW wglUseFontOutlinesW;

    alias wglUseFontBitmapsW    wglUseFontBitmaps;
    alias wglUseFontOutlinesW   wglUseFontOutlines;

    package
    {
        void loadPlatformGL(void delegate(void**, string, bool doThrow = true) bindFunc)
        {
            bindFunc(cast(void**)&wglCopyContext, "wglCopyContext");
            bindFunc(cast(void**)&wglCreateContext, "wglCreateContext");
            bindFunc(cast(void**)&wglCreateLayerContext, "wglCreateLayerContext");
            bindFunc(cast(void**)&wglDeleteContext, "wglDeleteContext");
            bindFunc(cast(void**)&wglDescribeLayerPlane, "wglDescribeLayerPlane");
            bindFunc(cast(void**)&wglGetCurrentContext, "wglGetCurrentContext");
            bindFunc(cast(void**)&wglGetCurrentDC, "wglGetCurrentDC");
            bindFunc(cast(void**)&wglGetLayerPaletteEntries, "wglGetLayerPaletteEntries");
            bindFunc(cast(void**)&wglGetProcAddress, "wglGetProcAddress");
            bindFunc(cast(void**)&wglMakeCurrent, "wglMakeCurrent");
            bindFunc(cast(void**)&wglRealizeLayerPalette, "wglRealizeLayerPalette");
            bindFunc(cast(void**)&wglSetLayerPaletteEntries, "wglSetLayerPaletteEntries");
            bindFunc(cast(void**)&wglShareLists, "wglShareLists");
            bindFunc(cast(void**)&wglSwapLayerBuffers, "wglSwapLayerBuffers");
            bindFunc(cast(void**)&wglUseFontBitmapsW, "wglUseFontBitmapsW");
            bindFunc(cast(void**)&wglUseFontOutlinesW, "wglUseFontOutlinesW");
        }

        void* loadGLFunc(string symName)
        {
            return cast(void*)wglGetProcAddress(symName.toStringz());
        }

        bool hasValidContext()
        {
            if(wglGetCurrentContext && wglGetCurrentContext())
                return true;
            return false;
        }
    }
}