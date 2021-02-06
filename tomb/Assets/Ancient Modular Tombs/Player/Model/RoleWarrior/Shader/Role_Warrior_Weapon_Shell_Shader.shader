// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Role_Warrior_Weapon_Shell_Material"
{
	Properties
	{
		_raiden_head_d("raiden_head_d", 2D) = "white" {}
		_raiden_head_n("raiden_head_n", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _raiden_head_n;
		uniform float4 _raiden_head_n_ST;
		uniform sampler2D _raiden_head_d;
		uniform float4 _raiden_head_d_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_raiden_head_n = i.uv_texcoord * _raiden_head_n_ST.xy + _raiden_head_n_ST.zw;
			o.Normal = UnpackNormal( tex2D( _raiden_head_n, uv_raiden_head_n ) );
			float2 uv_raiden_head_d = i.uv_texcoord * _raiden_head_d_ST.xy + _raiden_head_d_ST.zw;
			o.Emission = tex2D( _raiden_head_d, uv_raiden_head_d ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;149;1227;612;2223.884;419.938;2.88839;True;False
Node;AmplifyShaderEditor.RangedFloatNode;8;-1421.895,661.8413;Float;False;Property;_X_Ray_Power;X_Ray_Power;5;0;Create;True;0;0;False;0;2.5;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1410.195,165.5311;Float;False;Property;_X_Ray_Bias;X_Ray_Bias;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1411.273,414.8191;Float;False;Property;_X_Ray_Scale;X_Ray_Scale;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;10;-1165.16,372.4082;Float;False;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;2.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-755.506,34.21645;Float;False;Property;_OutLine_Color;OutLine_Color;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;9;-763.9921,383.9781;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-785.9808,706.4813;Float;False;Property;_OutLineWidth;OutLineWidth;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-350.6252,-324.6284;Float;True;Property;_raiden_head_d;raiden_head_d;0;0;Create;True;0;0;False;0;e00011b4860e6e545b7922580d74fc58;e00011b4860e6e545b7922580d74fc58;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-351.925,-26.92839;Float;True;Property;_raiden_head_n;raiden_head_n;1;0;Create;True;0;0;False;0;fdf65069e3a4ab747b9f078e5c70caa0;fdf65069e3a4ab747b9f078e5c70caa0;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OutlineNode;5;-323.9595,426.5995;Float;False;0;True;Transparent;2;7;Back;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;315,-181.5;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Role_Warrior_Weapon_Shell_Material;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;1;7;0
WireConnection;10;2;6;0
WireConnection;10;3;8;0
WireConnection;9;0;10;0
WireConnection;5;0;4;0
WireConnection;5;2;9;0
WireConnection;5;1;3;0
WireConnection;0;1;2;0
WireConnection;0;2;1;0
ASEEND*/
//CHKSM=FCF4A86B9AA03CECD7939FB9C710D2B86B0AAA99