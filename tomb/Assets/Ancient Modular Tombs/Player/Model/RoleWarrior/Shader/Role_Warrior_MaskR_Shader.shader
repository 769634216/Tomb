// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Role_Warrior_MaskR_Material"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_raiden_head_d("raiden_head_d", 2D) = "white" {}
		_mask_l("mask_l", 2D) = "white" {}
		_head_n("head_n", 2D) = "bump" {}
		_DisolveGuide("Disolve Guide", 2D) = "white" {}
		_BurnRamp("Burn Ramp", 2D) = "white" {}
		_DissolveAmount("Dissolve Amount", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _head_n;
		uniform float4 _head_n_ST;
		uniform sampler2D _raiden_head_d;
		uniform float4 _raiden_head_d_ST;
		uniform sampler2D _mask_l;
		uniform float4 _mask_l_ST;
		uniform float _DissolveAmount;
		uniform sampler2D _DisolveGuide;
		uniform float4 _DisolveGuide_ST;
		uniform sampler2D _BurnRamp;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_head_n = i.uv_texcoord * _head_n_ST.xy + _head_n_ST.zw;
			o.Normal = UnpackNormal( tex2D( _head_n, uv_head_n ) );
			float2 uv_raiden_head_d = i.uv_texcoord * _raiden_head_d_ST.xy + _raiden_head_d_ST.zw;
			float2 uv_mask_l = i.uv_texcoord * _mask_l_ST.xy + _mask_l_ST.zw;
			float2 uv_DisolveGuide = i.uv_texcoord * _DisolveGuide_ST.xy + _DisolveGuide_ST.zw;
			float temp_output_19_0 = ( (-0.6 + (( 1.0 - _DissolveAmount ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + tex2D( _DisolveGuide, uv_DisolveGuide ).r );
			float clampResult22 = clamp( (-4.0 + (temp_output_19_0 - 0.0) * (4.0 - -4.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
			float temp_output_23_0 = ( 1.0 - clampResult22 );
			float2 appendResult24 = (float2(temp_output_23_0 , 0.0));
			o.Emission = ( ( tex2D( _raiden_head_d, uv_raiden_head_d ) * tex2D( _mask_l, uv_mask_l ) ) + ( temp_output_23_0 * tex2D( _BurnRamp, appendResult24 ) ) ).rgb;
			o.Alpha = 1;
			clip( temp_output_19_0 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;101;1227;600;1097.716;835.0722;1.825055;True;False
Node;AmplifyShaderEditor.CommentaryNode;14;-976.3233,503.2209;Float;False;908.2314;498.3652;Dissolve - Opacity Mask;5;19;18;17;16;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-927.993,575.4351;Float;False;Property;_DissolveAmount;Dissolve Amount;8;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;16;-664.1974,576.281;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;17;-566.5091,792.0868;Float;True;Property;_DisolveGuide;Disolve Guide;4;0;Create;True;0;0;False;0;None;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;18;-535.3809,577.0656;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.6;False;4;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-328.6349,559.5674;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;20;-901.8831,42.23574;Float;False;814.5701;432.0292;Burn Effect - Emission;6;26;25;24;23;22;21;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;21;-887.1031,274.0336;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-4;False;4;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;22;-806.5845,83.45267;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;23;-636.5486,76.24026;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;24;-558.3884,300.2391;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;25;-431.0934,288.1503;Float;True;Property;_BurnRamp;Burn Ramp;5;0;Create;True;0;0;False;0;None;5798ded558355430c8a9b13ee12a847c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-601.2443,-826.9943;Float;True;Property;_raiden_head_d;raiden_head_d;1;0;Create;True;0;0;False;0;e00011b4860e6e545b7922580d74fc58;e00011b4860e6e545b7922580d74fc58;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-600.1111,-551.8087;Float;True;Property;_mask_l;mask_l;2;0;Create;True;0;0;False;0;b3ca315a7e2b8d84ba91acac49ed4eb2;b3ca315a7e2b8d84ba91acac49ed4eb2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-160.7287,-671.379;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-211.3136,118.9032;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;8;-913.7305,1542.025;Float;False;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;2.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1159.843,1584.435;Float;False;Property;_X_Ray_Scale;X_Ray_Scale;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;203.177,-270.1693;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-534.5511,1876.097;Float;False;Property;_OutLineWidth;OutLineWidth;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OutlineNode;13;-89.92349,1541.137;Float;False;0;True;Transparent;2;7;Back;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1170.465,1831.458;Float;False;Property;_X_Ray_Power;X_Ray_Power;10;0;Create;True;0;0;False;0;2.5;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1158.766,1335.147;Float;False;Property;_X_Ray_Bias;X_Ray_Bias;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-633.8933,-247.2591;Float;True;Property;_head_n;head_n;3;0;Create;True;0;0;False;0;05614e2f8fb2aae40a2119f417ba858b;fdf65069e3a4ab747b9f078e5c70caa0;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;-504.0763,1203.833;Float;False;Property;_OutLine_Color;OutLine_Color;6;0;Create;True;0;0;False;0;0,0,0,0;0,0.9019608,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;9;-512.5626,1553.594;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;504.7592,-210.6976;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Role_Warrior_MaskR_Material;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;15;0
WireConnection;18;0;16;0
WireConnection;19;0;18;0
WireConnection;19;1;17;1
WireConnection;21;0;19;0
WireConnection;22;0;21;0
WireConnection;23;0;22;0
WireConnection;24;0;23;0
WireConnection;25;1;24;0
WireConnection;4;0;1;0
WireConnection;4;1;2;0
WireConnection;26;0;23;0
WireConnection;26;1;25;0
WireConnection;8;1;5;0
WireConnection;8;2;6;0
WireConnection;8;3;7;0
WireConnection;27;0;4;0
WireConnection;27;1;26;0
WireConnection;13;0;11;0
WireConnection;13;2;9;0
WireConnection;13;1;10;0
WireConnection;9;0;8;0
WireConnection;0;1;3;0
WireConnection;0;2;27;0
WireConnection;0;10;19;0
ASEEND*/
//CHKSM=50CBFCB77BD80F3FEA5CE7946E0B52096A92208C