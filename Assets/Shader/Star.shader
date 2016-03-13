// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3676471,fgcg:0.3676471,fgcb:0.3676471,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32536,y:32668|emission-134-OUT;n:type:ShaderForge.SFN_Tex2d,id:2,x:33433,y:32342,ptlb:_BaseDiffuse,ptin:__BaseDiffuse,tex:8f765ab3dee163b4e861484b6eb8a5cf,ntxv:0,isnm:False|UVIN-7-UVOUT;n:type:ShaderForge.SFN_Panner,id:7,x:33604,y:32349,spu:0.003,spv:0;n:type:ShaderForge.SFN_Tex2d,id:45,x:33433,y:32515,ptlb:_FlameDiffuse,ptin:__FlameDiffuse,tex:d8594cb39cb586c42a582858948b5014,ntxv:0,isnm:False|UVIN-193-UVOUT;n:type:ShaderForge.SFN_Add,id:46,x:33227,y:32342|A-2-RGB,B-45-RGB;n:type:ShaderForge.SFN_Fresnel,id:80,x:33768,y:32728;n:type:ShaderForge.SFN_Multiply,id:82,x:33061,y:32838|A-113-OUT,B-241-RGB;n:type:ShaderForge.SFN_OneMinus,id:113,x:33452,y:32760|IN-153-OUT;n:type:ShaderForge.SFN_Add,id:134,x:32854,y:32768|A-179-OUT,B-82-OUT;n:type:ShaderForge.SFN_Multiply,id:153,x:33580,y:32787|A-80-OUT,B-158-OUT;n:type:ShaderForge.SFN_Slider,id:158,x:33768,y:32883,ptlb:_CoreStrengh,ptin:__CoreStrengh,min:0,cur:1.581578,max:5;n:type:ShaderForge.SFN_Multiply,id:179,x:32987,y:32513|A-230-OUT,B-182-RGB;n:type:ShaderForge.SFN_Color,id:182,x:33263,y:32627,ptlb:_StarColor,ptin:__StarColor,glob:False,c1:1,c2:0.2689655,c3:0,c4:1;n:type:ShaderForge.SFN_Panner,id:193,x:33604,y:32499,spu:-0.03,spv:0;n:type:ShaderForge.SFN_Desaturate,id:230,x:33059,y:32298|COL-46-OUT;n:type:ShaderForge.SFN_Color,id:241,x:33276,y:32889,ptlb:_CoreColor,ptin:__CoreColor,glob:False,c1:1,c2:0.7655172,c3:0,c4:1;proporder:182-2-45-158-241;pass:END;sub:END;*/

Shader "Shader Forge/Star" {
    Properties {
        __StarColor ("_StarColor", Color) = (1,0.2689655,0,1)
        __BaseDiffuse ("_BaseDiffuse", 2D) = "white" {}
        __FlameDiffuse ("_FlameDiffuse", 2D) = "white" {}
        __CoreStrengh ("_CoreStrengh", Range(0, 5)) = 1.581578
        __CoreColor ("_CoreColor", Color) = (1,0.7655172,0,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D __BaseDiffuse; uniform float4 __BaseDiffuse_ST;
            uniform sampler2D __FlameDiffuse; uniform float4 __FlameDiffuse_ST;
            uniform float __CoreStrengh;
            uniform float4 __StarColor;
            uniform float4 __CoreColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
////// Lighting:
////// Emissive:
                float4 node_257 = _Time + _TimeEditor;
                float2 node_256 = i.uv0;
                float2 node_7 = (node_256.rg+node_257.g*float2(0.003,0));
                float2 node_193 = (node_256.rg+node_257.g*float2(-0.03,0));
                float3 emissive = ((dot((tex2D(__BaseDiffuse,TRANSFORM_TEX(node_7, __BaseDiffuse)).rgb+tex2D(__FlameDiffuse,TRANSFORM_TEX(node_193, __FlameDiffuse)).rgb),float3(0.3,0.59,0.11))*__StarColor.rgb)+((1.0 - ((1.0-max(0,dot(normalDirection, viewDirection)))*__CoreStrengh))*__CoreColor.rgb));
                float3 finalColor = emissive;
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
