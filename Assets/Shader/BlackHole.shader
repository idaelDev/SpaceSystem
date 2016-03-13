// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:0,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3676471,fgcg:0.3676471,fgcb:0.3676471,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32719,y:32712|diff-3-RGB;n:type:ShaderForge.SFN_Tex2d,id:3,x:33205,y:32632,ptlb:_Diffuse,ptin:__Diffuse,tex:89361b0d1ec45b744a7253dfe7cbd94e,ntxv:0,isnm:False|UVIN-9-UVOUT;n:type:ShaderForge.SFN_Rotator,id:9,x:33358,y:32603|UVIN-41-UVOUT,SPD-40-OUT;n:type:ShaderForge.SFN_Slider,id:40,x:33458,y:32789,ptlb:_Rotation,ptin:__Rotation,min:0,cur:0.4358974,max:1;n:type:ShaderForge.SFN_TexCoord,id:41,x:33536,y:32525,uv:0;proporder:3-40;pass:END;sub:END;*/

Shader "Shader Forge/BlackHole" {
    Properties {
        __Diffuse ("_Diffuse", 2D) = "white" {}
        __Rotation ("_Rotation", Range(0, 1)) = 0.4358974
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
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
////// Lighting:
                float3 finalColor = 0;
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
