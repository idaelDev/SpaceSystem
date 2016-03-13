// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:1,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3676471,fgcg:0.3676471,fgcb:0.3676471,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32719,y:32712|emission-6-OUT;n:type:ShaderForge.SFN_Cubemap,id:2,x:33297,y:32714,ptlb:node_2,ptin:_node_2,cube:2f821dbbb5e173e468876ef2e4eaa490,pvfc:0;n:type:ShaderForge.SFN_Fresnel,id:3,x:33501,y:32848;n:type:ShaderForge.SFN_Multiply,id:5,x:33102,y:32905|A-7-OUT,B-9-RGB;n:type:ShaderForge.SFN_Add,id:6,x:32957,y:32856|A-2-RGB,B-5-OUT;n:type:ShaderForge.SFN_Multiply,id:7,x:33328,y:32905|A-3-OUT,B-8-OUT;n:type:ShaderForge.SFN_Slider,id:8,x:33394,y:33075,ptlb:node_8,ptin:_node_8,min:0,cur:0.3931624,max:1;n:type:ShaderForge.SFN_Color,id:9,x:33266,y:33060,ptlb:node_9,ptin:_node_9,glob:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:2-8-9;pass:END;sub:END;*/

Shader "Shader Forge/Wormhole" {
    Properties {
        _node_2 ("node_2", Cube) = "_Skybox" {}
        _node_8 ("node_8", Range(0, 1)) = 0.3931624
        _node_9 ("node_9", Color) = (0.5,0.5,0.5,1)
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
            uniform samplerCUBE _node_2;
            uniform float _node_8;
            uniform float4 _node_9;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
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
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
////// Emissive:
                float3 emissive = (texCUBE(_node_2,viewReflectDirection).rgb+(((1.0-max(0,dot(normalDirection, viewDirection)))*_node_8)*_node_9.rgb));
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
