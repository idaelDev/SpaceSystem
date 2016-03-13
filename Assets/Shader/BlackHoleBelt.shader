// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:2,bsrc:0,bdst:0,culm:2,dpts:2,wrdp:False,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3676471,fgcg:0.3676471,fgcb:0.3676471,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32719,y:32712|emission-8-OUT;n:type:ShaderForge.SFN_Tex2d,id:2,x:33181,y:32640,ptlb:_Diffuse,ptin:__Diffuse,tex:d8ebc19896279d34ca47dd49913401df,ntxv:0,isnm:False|UVIN-22-UVOUT;n:type:ShaderForge.SFN_Multiply,id:8,x:32991,y:32687|A-2-RGB,B-13-RGB;n:type:ShaderForge.SFN_Color,id:13,x:33181,y:32822,ptlb:_Color,ptin:__Color,glob:False,c1:1,c2:0.7241379,c3:0,c4:1;n:type:ShaderForge.SFN_Panner,id:22,x:33349,y:32630,spu:0.02,spv:0;proporder:2-13;pass:END;sub:END;*/

Shader "Shader Forge/BlackHoleBelt" {
    Properties {
        __Diffuse ("_Diffuse", 2D) = "white" {}
        __Color ("_Color", Color) = (1,0.7241379,0,1)
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D __Diffuse; uniform float4 __Diffuse_ST;
            uniform float4 __Color;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 node_40 = _Time + _TimeEditor;
                float2 node_22 = (i.uv0.rg+node_40.g*float2(0.02,0));
                float3 emissive = (tex2D(__Diffuse,TRANSFORM_TEX(node_22, __Diffuse)).rgb*__Color.rgb);
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
