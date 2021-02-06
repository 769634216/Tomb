// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Harpy_Material"
{
	Properties
	{
		_T_HARPY_BreastsCovered_Albedo("T_HARPY_BreastsCovered_Albedo", 2D) = "white" {}
		_T_HARPY_BrestsCovered_NRM_Yinv("T_HARPY_BrestsCovered_NRM_Yinv", 2D) = "white" {}
		_T_HARPY_BreastsCovered_RoughnessSpecularMetallic("T_HARPY_BreastsCovered_RoughnessSpecularMetallic", 2D) = "white" {}
		[HDR]_Grain_Color("Grain_Color", Color) = (0,0,0,0)
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

		uniform sampler2D _T_HARPY_BrestsCovered_NRM_Yinv;
		uniform float4 _T_HARPY_BrestsCovered_NRM_Yinv_ST;
		uniform sampler2D _T_HARPY_BreastsCovered_Albedo;
		uniform float4 _T_HARPY_BreastsCovered_Albedo_ST;
		uniform sampler2D _T_HARPY_BreastsCovered_RoughnessSpecularMetallic;
		uniform float4 _T_HARPY_BreastsCovered_RoughnessSpecularMetallic_ST;
		uniform float4 _Grain_Color;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_T_HARPY_BrestsCovered_NRM_Yinv = i.uv_texcoord * _T_HARPY_BrestsCovered_NRM_Yinv_ST.xy + _T_HARPY_BrestsCovered_NRM_Yinv_ST.zw;
			o.Normal = tex2D( _T_HARPY_BrestsCovered_NRM_Yinv, uv_T_HARPY_BrestsCovered_NRM_Yinv ).rgb;
			float2 uv_T_HARPY_BreastsCovered_Albedo = i.uv_texcoord * _T_HARPY_BreastsCovered_Albedo_ST.xy + _T_HARPY_BreastsCovered_Albedo_ST.zw;
			o.Albedo = tex2D( _T_HARPY_BreastsCovered_Albedo, uv_T_HARPY_BreastsCovered_Albedo ).rgb;
			float2 uv_T_HARPY_BreastsCovered_RoughnessSpecularMetallic = i.uv_texcoord * _T_HARPY_BreastsCovered_RoughnessSpecularMetallic_ST.xy + _T_HARPY_BreastsCovered_RoughnessSpecularMetallic_ST.zw;
			o.Emission = ( ( 1.0 - tex2D( _T_HARPY_BreastsCovered_RoughnessSpecularMetallic, uv_T_HARPY_BreastsCovered_RoughnessSpecularMetallic ).b ) * _Grain_Color ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
421;296;1352;732;1204.516;-29.24078;1;True;False
Node;AmplifyShaderEditor.SamplerNode;5;-1037,399.5;Float;True;Property;_T_HARPY_BreastsCovered_RoughnessSpecularMetallic;T_HARPY_BreastsCovered_RoughnessSpecularMetallic;2;0;Create;True;0;0;False;0;1d5dc0a79cd13f44f8c80d61fd6017b8;1d5dc0a79cd13f44f8c80d61fd6017b8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;7;-662.4061,346.1634;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;-701.7125,602.278;Float;False;Property;_Grain_Color;Grain_Color;3;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-413.5847,474.1587;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-473,62.5;Float;True;Property;_T_HARPY_BrestsCovered_NRM_Yinv;T_HARPY_BrestsCovered_NRM_Yinv;1;0;Create;True;0;0;False;0;2014ca40146602744a8f76be24522b76;2014ca40146602744a8f76be24522b76;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-483,-242.5;Float;True;Property;_T_HARPY_BreastsCovered_Albedo;T_HARPY_BreastsCovered_Albedo;0;0;Create;True;0;0;False;0;2e77f1f28bb848c4fa8f8cf24269003b;2e77f1f28bb848c4fa8f8cf24269003b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Harpy_Material;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;5;3
WireConnection;8;0;7;0
WireConnection;8;1;9;0
WireConnection;0;0;1;0
WireConnection;0;1;2;0
WireConnection;0;2;8;0
ASEEND*/
//CHKSM=4014C2BF18773311CC5AA7C59E81D80A22AA6DBD