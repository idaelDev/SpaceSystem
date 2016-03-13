// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32600,y:32715|diff-24-OUT,spec-323-OUT,emission-18-OUT,lwrap-17-RGB;n:type:ShaderForge.SFN_Tex2d,id:2,x:33498,y:32136,ptlb:_Diffuse,ptin:__Diffuse,tex:5fce97a32ace31a4b83ba10039d4c2dd,ntxv:0,isnm:False|UVIN-25-UVOUT;n:type:ShaderForge.SFN_Multiply,id:8,x:33328,y:32225|A-2-RGB,B-10-RGB;n:type:ShaderForge.SFN_Color,id:10,x:33498,y:32315,ptlb:_DiffuseColor,ptin:__DiffuseColor,glob:False,c1:0.3538603,c2:0.4871069,c3:0.5661765,c4:1;n:type:ShaderForge.SFN_Fresnel,id:16,x:33628,y:32737;n:type:ShaderForge.SFN_Color,id:17,x:33280,y:33082,ptlb:_RimColor,ptin:__RimColor,glob:False,c1:0.01016437,c2:0.4093782,c3:0.6911765,c4:1;n:type:ShaderForge.SFN_Multiply,id:18,x:33008,y:32852|A-215-OUT,B-17-RGB;n:type:ShaderForge.SFN_Add,id:24,x:33017,y:32415|A-8-OUT,B-161-RGB;n:type:ShaderForge.SFN_Panner,id:25,x:33754,y:32205,spu:0.0035,spv:0;n:type:ShaderForge.SFN_Tex2d,id:161,x:33330,y:32556,ptlb:_Clouds,ptin:__Clouds,tex:28c7aad1372ff114b90d330f8a2dd938,ntxv:0,isnm:False|UVIN-172-UVOUT;n:type:ShaderForge.SFN_Panner,id:172,x:33498,y:32556,spu:0.006,spv:0;n:type:ShaderForge.SFN_Multiply,id:215,x:33296,y:32836|A-16-OUT,B-218-OUT;n:type:ShaderForge.SFN_Slider,id:218,x:33524,y:32972,ptlb:_RimPower,ptin:__RimPower,min:0,cur:0.5770274,max:1;n:type:ShaderForge.SFN_Multiply,id:323,x:32952,y:32622|A-371-OUT,B-330-OUT;n:type:ShaderForge.SFN_Slider,id:330,x:33164,y:32744,ptlb:_SpeculatPower,ptin:__SpeculatPower,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:371,x:32981,y:32064|A-2-RGB,B-382-RGB;n:type:ShaderForge.SFN_Color,id:382,x:33228,y:32112,ptlb:_SpecularColor,ptin:__SpecularColor,glob:False,c1:0.4779412,c2:0.71856,c3:0.9558824,c4:1;proporder:10-2-161-382-330-17-218;pass:END;sub:END;*/

Shader "Shader Forge/PlanetEnhance" {
    Properties {
        __DiffuseColor ("_DiffuseColor", Color) = (0.3538603,0.4871069,0.5661765,1)
        __Diffuse ("_Diffuse", 2D) = "white" {}
        __Clouds ("_Clouds", 2D) = "white" {}
        __SpecularColor ("_SpecularColor", Color) = (0.4779412,0.71856,0.9558824,1)
        __SpeculatPower ("_SpeculatPower", Range(0, 1)) = 1
        __RimColor ("_RimColor", Color) = (0.01016437,0.4093782,0.6911765,1)
        __RimPower ("_RimPower", Range(0, 1)) = 0.5770274
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
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform sampler2D __Diffuse; uniform float4 __Diffuse_ST;
            uniform float4 __DiffuseColor;
            uniform float4 __RimColor;
            uniform sampler2D __Clouds; uniform float4 __Clouds_ST;
            uniform float __RimPower;
            uniform float __SpeculatPower;
            uniform float4 __SpecularColor;
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
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 w = __RimColor.rgb*0.5; // Light wrapping
                float3 NdotLWrap = NdotL * ( 1.0 - w );
                float3 forwardLight = max(float3(0.0,0.0,0.0), NdotLWrap + w );
                float3 diffuse = forwardLight * attenColor + UNITY_LIGHTMODEL_AMBIENT.rgb;
////// Emissive:
                float3 emissive = (((1.0-max(0,dot(normalDirection, viewDirection)))*__RimPower)*__RimColor.rgb);
///////// Gloss:
                float gloss = 0.5;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float4 node_400 = _Time + _TimeEditor;
                float2 node_399 = i.uv0;
                float2 node_25 = (node_399.rg+node_400.g*float2(0.0035,0));
                float4 node_2 = tex2D(__Diffuse,TRANSFORM_TEX(node_25, __Diffuse));
                float3 specularColor = ((node_2.rgb*__SpecularColor.rgb)*__SpeculatPower);
                float3 specular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float2 node_172 = (node_399.rg+node_400.g*float2(0.006,0));
                finalColor += diffuseLight * ((node_2.rgb*__DiffuseColor.rgb)+tex2D(__Clouds,TRANSFORM_TEX(node_172, __Clouds)).rgb);
                finalColor += specular;
                finalColor += emissive;
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform sampler2D __Diffuse; uniform float4 __Diffuse_ST;
            uniform float4 __DiffuseColor;
            uniform float4 __RimColor;
            uniform sampler2D __Clouds; uniform float4 __Clouds_ST;
            uniform float __RimPower;
            uniform float __SpeculatPower;
            uniform float4 __SpecularColor;
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
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 w = __RimColor.rgb*0.5; // Light wrapping
                float3 NdotLWrap = NdotL * ( 1.0 - w );
                float3 forwardLight = max(float3(0.0,0.0,0.0), NdotLWrap + w );
                float3 diffuse = forwardLight * attenColor;
///////// Gloss:
                float gloss = 0.5;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float4 node_402 = _Time + _TimeEditor;
                float2 node_401 = i.uv0;
                float2 node_25 = (node_401.rg+node_402.g*float2(0.0035,0));
                float4 node_2 = tex2D(__Diffuse,TRANSFORM_TEX(node_25, __Diffuse));
                float3 specularColor = ((node_2.rgb*__SpecularColor.rgb)*__SpeculatPower);
                float3 specular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float2 node_172 = (node_401.rg+node_402.g*float2(0.006,0));
                finalColor += diffuseLight * ((node_2.rgb*__DiffuseColor.rgb)+tex2D(__Clouds,TRANSFORM_TEX(node_172, __Clouds)).rgb);
                finalColor += specular;
/// Final Color:
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
