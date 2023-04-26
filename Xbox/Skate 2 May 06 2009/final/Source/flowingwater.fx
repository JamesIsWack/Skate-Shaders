
void defaultVS ( VS_IN_FLOWING In , out PS_IN_FLOWING Out ) 
{
float4 P = float4 ( In.pos, 1.0 );

Out.vNormal.xy = In.lm_norm.zw;
half2 signs = saturate ( half2 ( 65535, 65535 )*In.lm_norm.xy );
signs = signs*2-1;
float xy_len = min ( 0.999f , dot ( Out.vNormal.xy , Out.vNormal.xy ) );
Out.vNormal.z = signs.y*sqrt ( 1-xy_len );
Out.vTangent = In.tangent;
Out.vBinormal = signs.x*cross ( Out.vNormal , Out.vTangent );
Out.vPos = In.pos.xyz;
Out.Pos = mul ( P , g_matVP );

Out.UV.xy = In.uv;
Out.UV.zw = abs ( In.lm_norm.xy );
Out.Fog = ComputeFogFactor ( P , g_matV );
Out.lightmapchannel = i_monoLightmap_Dot;
}

half4 defaultPS ( PS_IN_FLOWING In ) : COLOR 
{
half4 uv = GetAnimatedUV ( half4 ( m_params[2].xy, m_params[2].zw ) , half4 ( m_params[1].xy, m_params[1].zw ) , In.UV.xy );
half4 cDiffuse = GetDiffuseTextureValue ( i_diffuse , In.UV.xy );
half3 cSpecEccRefMask = saturate ( GetSpecularEccentricityReflectionMaskValue ( i_specular , In.UV.xy )-m_params[3].y );
half3 vViewDir = normalize ( g_vViewPos-In.vPos );
half3 vNormal = normalize ( m_params[0].xzw*( GetNormalMapValue ( i_normal , uv.xy )+GetNormalMapValue ( i_normal , uv.zw ) ) );

half3x3 matTBN = GetTangentMatrix ( In.vTangent , In.vBinormal , In.vNormal );
half3 wNormal = TransformToWorldFromTangent_normalize ( vNormal , matTBN );

half NdotL = dot ( wNormal , g_vLightDir.xyz );
half shadow_inv_lerp = ( NdotL > 0.0 ) ? CSM_ShadowMap_PS ( float4 ( In.vPos, 1 ) , half3 ( -0.005, 10.0, 25.0 ) ) : 1.0;
half4 cLightMap = GetShadowedLightMap ( i_lightmap , i_chromaticity , In.UV.zw+0.01*vNormal.xz , In.lightmapchannel , half4 ( 4.5, 4.5, 4.5, 1.5 ) , half4 ( 0.07, 0.09, 0.1, 0.04 ) , 50.0 , shadow_inv_lerp );


half kd = GetTangentLight ( wNormal , half3 ( 0.64, 0.64, 0.420465 ) , g_vLightDir.xyz );
half3 diffTerm = GetDiffuseTerm ( cLightMap.rgb , kd );
struct tSpecularTerm specTermParts;

half reflection_luminosity = 0.3*saturate ( 4.0*( cSpecEccRefMask.b-1.5 ) );
half3 reflected = cSpecEccRefMask.b*GetReflectionTerm ( i_environment , wNormal , vViewDir , cLightMap.a , reflection_luminosity )*1.5;

half ks = phong_specular ( wNormal , vViewDir , g_vLightDir.xyz , m_params[3].z );
half3 calculated = cSpecEccRefMask.r*ks*half3 ( 18.0, 15.0, 10.5 )*saturate ( cLightMap.a-0.1 );


half3 specTerm = ( calculated+reflected );
half4 outcolor = half4 ( diffTerm, 1 )*cDiffuse+half4 ( specTerm, 0 );


half4 returncolour = half4 ( PS_Fog_Bloom_Tone ( outcolor*m_params[0].y , In.Fog , g_envattributes[2].x ).rgb, 1 );
return returncolour;
}
