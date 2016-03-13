// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:1,bsrc:3,bdst:7,culm:2,dpts:2,wrdp:False,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3676471,fgcg:0.3676471,fgcb:0.3676471,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32719,y:32712|diff-66-OUT,diffpow-52-OUT,emission-121-OUT,alpha-142-A,clip-142-A;n:type:ShaderForge.SFN_Tex2d,id:2,x:33239,y:32434,ptlb:_Diffuse,ptin:__Diffuse,tex:9b8f9303c23eafc42972a6e905545403,ntxv:0,isnm:False|UVIN-13-UVOUT;n:type:ShaderForge.SFN_Panner,id:13,x:33407,y:32412,spu:0,spv:0.7;n:type:ShaderForge.SFN_Multiply,id:40,x:33091,y:32540|A-2-RGB,B-41-RGB;n:type:ShaderForge.SFN_Color,id:41,x:33234,y:32595,ptlb:_Tint,ptin:__Tint,glob:False,c1:0.9044118,c2:0.152952,c3:0.152952,c4:1;n:type:ShaderForge.SFN_Vector1,id:52,x:32967,y:32712,v1:0;n:type:ShaderForge.SFN_Tex2d,id:63,x:33239,y:32076,ptlb:_ArrowBack,ptin:__ArrowBack,tex:28c7aad1372ff114b90d330f8a2dd938,ntxv:0,isnm:False|UVIN-77-UVOUT;n:type:ShaderForge.SFN_Multiply,id:64,x:33094,y:32200|A-63-RGB,B-65-RGB;n:type:ShaderForge.SFN_Color,id:65,x:33239,y:32257,ptlb:_TintBack,ptin:__TintBack,glob:False,c1:0.2941176,c2:0,c3:0.127789,c4:1;n:type:ShaderForge.SFN_Add,id:66,x:32931,y:32350|A-64-OUT,B-40-OUT;n:type:ShaderForge.SFN_Panner,id:77,x:33431,y:32076,spu:0.2,spv:0.3;n:type:ShaderForge.SFN_Fresnel,id:120,x:33335,y:32787;n:type:ShaderForge.SFN_Multiply,id:121,x:33010,y:32788|A-41-RGB,B-125-OUT;n:type:ShaderForge.SFN_Slider,id:124,x:33335,y:32955,ptlb:_RimPower,ptin:__RimPower,min:0,cur:0.4927723,max:1;n:type:ShaderForge.SFN_Multiply,id:125,x:33168,y:32845|A-120-OUT,B-124-OUT;n:type:ShaderForge.SFN_Tex2d,id:142,x:33093,y:33030,ptlb:_Shape,ptin:__Shape,tex:8caa0b04693d0e64a93f5b6f45d613ed,ntxv:0,isnm:False;proporder:2-41-63-65-124-142;pass:END;sub:END;*/

Shader "Shader Forge/Arrow" {
    Properties {
        __Diffuse ("_Diffuse", 2D) = "white" {}
        __Tint ("_Tint", Color) = (0.9044118,0.152952,0.152952,1)
        __ArrowBack ("_ArrowBack", 2D) = "white" {}
        __TintBack ("_TintBack", Color) = (0.2941176,0,0.127789,1)
        __RimPower ("_RimPower", Range(0, 1)) = 0.4927723
        __Shape ("_Shape", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
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
            Blend SrcAlpha OneMinusSrcAlpha
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
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform sampler2D __Diffuse; uniform float4 __Diffuse_ST;
            uniform float4 __Tint;
            uniform sampler2D __ArrowBack; uniform float4 __ArrowBack_ST;
            uniform float4 __TintBack;
            uniform float __RimPower;
            uniform sampler2D __Shape; uniform float4 __Shape_ST;
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
                
                float nSign = sign( dot( viewDirection, i.normalDir ) ); // Reverse normal if this is a backface
                i.normalDir *= nSign;
                normalDirection *= nSign;
                
                float2 node_167 = i.uv0;
                float4 node_142 = tex2D(__Shape,TRANSFORM_TEX(node_167.rg, __Shape));
                clip(node_142.a - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = pow(max( 0.0, NdotL), 0.0) * attenColor + UNITY_LIGHTMODEL_AMBIENT.rgb;
////// Emissive:
                float3 emissive = (__Tint.rgb*((1.0-max(0,dot(normalDirection, viewDirection)))*__RimPower));
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float4 node_168 = _Time + _TimeEditor;
                float2 node_77 = (node_167.rg+node_168.g*float2(0.2,0.3));
                float2 node_13 = (node_167.rg+node_168.g*float2(0,0.7));
                finalColor += diffuseLight * ((tex2D(__ArrowBack,TRANSFORM_TEX(node_77, __ArrowBack)).rgb*__TintBack.rgb)+(tex2D(__Diffuse,TRANSFORM_TEX(node_13, __Diffuse)).rgb*__Tint.rgb));
                finalColor += emissive;
/// Final Color:
                return fixed4(finalColor,node_142.a);
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform sampler2D __Diffuse; uniform float4 __Diffuse_ST;
            uniform float4 __Tint;
            uniform sampler2D __ArrowBack; uniform float4 __ArrowBack_ST;
            uniform float4 __TintBack;
            uniform float __RimPower;
            uniform sampler2D __Shape; uniform float4 __Shape_ST;
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
                
                float nSign = sign( dot( viewDirection, i.normalDir ) ); // Reverse normal if this is a backface
                i.normalDir *= nSign;
                normalDirection *= nSign;
                
                float2 node_169 = i.uv0;
                float4 node_142 = tex2D(__Shape,TRANSFORM_TEX(node_169.rg, __Shape));
                clip(node_142.a - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = pow(max( 0.0, NdotL), 0.0) * attenColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float4 node_170 = _Time + _TimeEditor;
                float2 node_77 = (node_169.rg+node_170.g*float2(0.2,0.3));
                float2 node_13 = (node_169.rg+node_170.g*float2(0,0.7));
                finalColor += diffuseLight * ((tex2D(__ArrowBack,TRANSFORM_TEX(node_77, __ArrowBack)).rgb*__TintBack.rgb)+(tex2D(__Diffuse,TRANSFORM_TEX(node_13, __Diffuse)).rgb*__Tint.rgb));
/// Final Color:
                return fixed4(finalColor * node_142.a,0);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCollector"
            Tags {
                "LightMode"="ShadowCollector"
            }
            Cull Off
            
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCOLLECTOR
            #define SHADOW_COLLECTOR_PASS
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcollector
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform sampler2D __Shape; uniform float4 __Shape_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_COLLECTOR;
                float2 uv0 : TEXCOORD5;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_SHADOW_COLLECTOR(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                float2 node_171 = i.uv0;
                float4 node_142 = tex2D(__Shape,TRANSFORM_TEX(node_171.rg, __Shape));
                clip(node_142.a - 0.5);
                SHADOW_COLLECTOR_FRAGMENT(i)
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Cull Off
            Offset 1, 1
            
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform sampler2D __Shape; uniform float4 __Shape_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                float2 node_172 = i.uv0;
                float4 node_142 = tex2D(__Shape,TRANSFORM_TEX(node_172.rg, __Shape));
                clip(node_142.a - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
