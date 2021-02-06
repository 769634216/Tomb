// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Role_Warrior_MaskBr_Material"
{
	Properties
	{
		_armorc_d("armorc_d", 2D) = "white" {}
		_armorc_l("armorc_l", 2D) = "white" {}
		_armorc_n("armorc_n", 2D) = "bump" {}
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

		uniform sampler2D _armorc_n;
		uniform float4 _armorc_n_ST;
		uniform sampler2D _armorc_d;
		uniform float4 _armorc_d_ST;
		uniform sampler2D _armorc_l;
		uniform float4 _armorc_l_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_armorc_n = i.uv_texcoord * _armorc_n_ST.xy + _armorc_n_ST.zw;
			o.Normal = UnpackNormal( tex2D( _armorc_n, uv_armorc_n ) );
			float2 uv_armorc_d = i.uv_texcoord * _armorc_d_ST.xy + _armorc_d_ST.zw;
			float2 uv_armorc_l = i.uv_texcoord * _armorc_l_ST.xy + _armorc_l_ST.zw;
			o.Emission = ( tex2D( _armorc_d, uv_armorc_d ) * tex2D( _armorc_l, uv_armorc_l ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;173;1227;588;1480.839;316.1043;1.6;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-886.5956,-245.9844;Float;True;Property;_armorc_d;armorc_d;0;0;Create;True;0;0;False;0;9221d010f101bfc499f34b83d183fe14;9221d010f101bfc499f34b83d183fe14;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-882.3823,11.66196;Float;True;Property;_armorc_l;armorc_l;1;0;Create;True;0;0;False;0;deea595908eca2a4394be99d53ad3664;deea595908eca2a4394be99d53ad3664;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-436.6808,-93.27103;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-713.6052,239.98;Float;True;Property;_armorc_n;armorc_n;2;0;Create;True;0;0;False;0;14fea346ec405f548a7f51ad24e44604;14fea346ec405f548a7f51ad24e44604;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Role_Warrior_MaskBr_Material;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;1;0
WireConnection;4;1;2;0
WireConnection;0;1;3;0
WireConnection;0;2;4;0
ASEEND*/
//CHKSM=0BBFBE5D0224979294673ECFAF59C4FFB4E5686F