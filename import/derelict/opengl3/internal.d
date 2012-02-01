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
module derelict.opengl3.internal;

private
{
    import core.stdc.string;
    import std.string;
    import std.conv;

    import derelict.util.exception;
    import derelict.util.system;
    import derelict.opengl3.constants;
    import derelict.opengl3.functions;
    static if(Derelict_OS_Windows) import derelict.opengl3.wgl;
}

package
{
        void bindGLFunc(void** ptr, string symName)
        {
            auto sym = loadGLFunc(symName);
            if(!sym)
                throw new SymbolLoadException("Failed to load OpenGL symbol [" ~ symName ~ "]");
            *ptr = sym;
        }

        bool isExtSupported(string name)
        {
            if(glGetIntegerv && glGetStringi)
            {
                auto cstr = name.toStringz();
                int count;
                glGetIntegerv(GL_NUM_EXTENSIONS, &count);
                for(int i=0; i<count; ++i)
                {
                    if(strcmp(glGetStringi(GL_EXTENSIONS, i), cstr) == 0)
                        return true;
                }
            }
            else
            {
                auto extstr = to!string(glGetString(GL_EXTENSIONS));
                if(extstr.indexOf(name) != -1)
                    return true;
            }
            return false;
        }
}