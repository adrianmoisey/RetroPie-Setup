// GLSL shader autogenerated by cg2glsl.py.
#if defined(VERTEX)
varying     vec2 VARomega;


struct sine_coord {
    vec2 VARomega;
};

struct input_dummy {
    vec2 _video_size;
    vec2 _texture_size;
    vec2 _output_dummy_size;
};

vec4 _oPosition1;
sine_coord _coords1;
uniform mat4 MVPMatrix;
input_dummy _IN1;
vec4 _r0006;
attribute vec4 VertexCoord;
attribute vec4 COLOR;
varying vec4 COL0;
attribute vec4 TexCoord;
varying vec4 TEX0;

 

         mat4 transpose_(mat4 matrix)
         {
            mat4 ret;
            for (int i = 0; i != 4; i++)
               for (int j = 0; j != 4; j++)
                  ret[i][j] = matrix[j][i];

            return ret;
         }
         
uniform int FrameDirection;
uniform int FrameCount;
#ifdef GL_ES
uniform mediump vec2 OutputSize;
uniform mediump vec2 TextureSize;
uniform mediump vec2 InputSize;
#else
uniform vec2 OutputSize;
uniform vec2 TextureSize;
uniform vec2 InputSize;
#endif
void main()
{
    mat4 MVPMatrix_ = transpose_(MVPMatrix);

    vec4 _oColor;
    vec2 _oTex;
    sine_coord _TMP4;

    _r0006.x = dot(MVPMatrix_[0], VertexCoord);
    _r0006.y = dot(MVPMatrix_[1], VertexCoord);
    _r0006.z = dot(MVPMatrix_[2], VertexCoord);
    _r0006.w = dot(MVPMatrix_[3], VertexCoord);
    _oPosition1 = _r0006;
    _oColor = COLOR;
    _oTex = TexCoord.xy;
    _TMP4.VARomega = vec2((3.14150000E+000*OutputSize.x*TextureSize.x)/InputSize.x, 6.28299999E+000*TextureSize.y);
    VARomega = _TMP4.VARomega;
    gl_Position = _r0006;
    COL0 = COLOR;
    TEX0.xy = TexCoord.xy;
} 
#elif defined(FRAGMENT)
#ifdef GL_ES
precision mediump float;
#endif
varying     vec2 VARomega;


struct sine_coord {
    vec2 VARomega;
};

struct input_dummy {
    vec2 _video_size;
    vec2 _texture_size;
    vec2 _output_dummy_size;
};

vec4 _ret_0;
float _TMP2;
vec2 _TMP1;
float _TMP4;
float _TMP3;
vec4 _TMP0;
sine_coord _co1;
uniform sampler2D Texture;
vec2 _x0013;
vec2 _a0019;
varying vec4 TEX0;

 
uniform int FrameDirection;
uniform int FrameCount;
#ifdef GL_ES
uniform mediump vec2 OutputSize;
uniform mediump vec2 TextureSize;
uniform mediump vec2 InputSize;
#else
uniform vec2 OutputSize;
uniform vec2 TextureSize;
uniform vec2 InputSize;
#endif
void main()
{

    vec3 _scanline;

    _TMP0 = texture2D(Texture, TEX0.xy);
    _x0013 = TEX0.xy*VARomega;
    _TMP3 = sin(_x0013.x);
    _TMP4 = sin(_x0013.y);
    _TMP1 = vec2(_TMP3, _TMP4);
    _a0019 = vec2( 5.00000007E-002, 1.50000006E-001)*_TMP1;
    _TMP2 = dot(_a0019, vec2( 1.00000000E+000, 1.00000000E+000));
    _scanline = _TMP0.xyz*(9.49999988E-001 + _TMP2);
    _ret_0 = vec4(_scanline.x, _scanline.y, _scanline.z, 1.00000000E+000);
    gl_FragColor = _ret_0;
    return;
} 
#endif