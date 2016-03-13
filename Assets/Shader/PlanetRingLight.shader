// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:2,bsrc:0,bdst:0,culm:2,dpts:2,wrdp:False,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3676471,fgcg:0.3676471,fgcb:0.3676471,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32719,y:32712|emission-4-OUT;n:type:ShaderForge.SFN_Color,id:2,x:33269,y:32560,ptlb:_RingColor,ptin:__RingColor,glob:False,c1:1,c2:0.6413794,c3:0,c4:1;n:type:ShaderForge.SFN_Tex2d,id:3,x:33269,y:32730,ptlb:_RingDiffuse,ptin:__RingDiffuse,tex:4d1d74d8cd580de4ab4155e4c96b863b,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4,x:33009,y:32598|A-2-RGB,B-3-RGB;proporder:2-3;pass:END;sub:END;*/

Shader "Shader Forge/PlanetRingLight" {
    Properties {
        __RingColor ("_RingColor", Color) = (1,0.6413794,0,1)
        __RingDiffuse ("_RingDiffuse", 2D) = "white" {}
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
            uniform float4 __RingColor;
            uniform sampler2D __RingDiffuse; uniform float4 __RingDiffuse_ST;
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
                float2 node_8 = i.uv0;
                float3 emissive = (__RingColor.rgb*tex2D(__RingDiffuse,TRANSFORM_TEX(node_8.rg, __RingDiffuse)).rgb);
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
