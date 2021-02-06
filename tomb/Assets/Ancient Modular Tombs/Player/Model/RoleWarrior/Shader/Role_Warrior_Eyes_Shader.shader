// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Role_Warrior_Eyes_Material"
{
	Properties
	{
		_Eye_s("Eye_s", 2D) = "white" {}
		_raiden_head_d("raiden_head_d", 2D) = "white" {}
		_raiden_head_n("raiden_head_n", 2D) = "white" {}
		_EyeColor("EyeColor", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
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
		uniform sampler2D _Eye_s;
		uniform float4 _Eye_s_ST;
		uniform float4 _EyeColor;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_raiden_head_n = i.uv_texcoord * _raiden_head_n_ST.xy + _raiden_head_n_ST.zw;
			o.Normal = tex2D( _raiden_head_n, uv_raiden_head_n ).rgb;
			float2 uv_raiden_head_d = i.uv_texcoord * _raiden_head_d_ST.xy + _raiden_head_d_ST.zw;
			float2 uv_Eye_s = i.uv_texcoord * _Eye_s_ST.xy + _Eye_s_ST.zw;
			o.Emission = ( tex2D( _raiden_head_d, uv_raiden_head_d ) * tex2D( _Eye_s, uv_Eye_s ) * _EyeColor ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
38;64;1227;738;1085.385;265.4415;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;4;-603.5212,-58.9789;Float;True;Property;_Eye_s;Eye_s;0;0;Create;True;0;0;False;0;0a4e2bafbd717ce479a168b8efa9f0fc;0a4e2bafbd717ce479a168b8efa9f0fc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;10;-570.5848,158.3585;Float;False;Property;_EyeColor;EyeColor;3;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-603.8364,-305.8192;Float;True;Property;_raiden_head_d;raiden_head_d;1;0;Create;True;0;0;False;0;e00011b4860e6e545b7922580d74fc58;e00011b4860e6e545b7922580d74fc58;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-61.3632,-124.5835;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;6;-457.7445,355.0602;Float;True;Property;_raiden_head_n;raiden_head_n;2;0;Create;True;0;0;False;0;421f62f5de926d0439ade9233f7a822e;421f62f5de926d0439ade9233f7a822e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;295.4969,-37.32223;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Role_Warrior_Eyes_Material;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;9;0
WireConnection;3;1;4;0
WireConnection;3;2;10;0
WireConnection;0;1;6;0
WireConnection;0;2;3;0
ASEEND*/
//CHKSM=CB855A855F16AE35274D1EB9E97C78CE239DC461