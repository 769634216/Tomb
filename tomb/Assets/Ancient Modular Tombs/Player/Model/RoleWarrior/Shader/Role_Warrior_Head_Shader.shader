// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Role_Warrior_Head_Material"
{
	Properties
	{
		_head_l("head_l", 2D) = "white" {}
		_raiden_head_d("raiden_head_d", 2D) = "white" {}
		_head_n("head_n", 2D) = "white" {}
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

		uniform sampler2D _head_n;
		uniform float4 _head_n_ST;
		uniform sampler2D _raiden_head_d;
		uniform float4 _raiden_head_d_ST;
		uniform sampler2D _head_l;
		uniform float4 _head_l_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_head_n = i.uv_texcoord * _head_n_ST.xy + _head_n_ST.zw;
			o.Normal = tex2D( _head_n, uv_head_n ).rgb;
			float2 uv_raiden_head_d = i.uv_texcoord * _raiden_head_d_ST.xy + _raiden_head_d_ST.zw;
			float2 uv_head_l = i.uv_texcoord * _head_l_ST.xy + _head_l_ST.zw;
			o.Emission = ( tex2D( _raiden_head_d, uv_raiden_head_d ) * tex2D( _head_l, uv_head_l ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
123;79;1227;588;803.1289;71.45563;1.547638;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-721.5407,-110.3562;Float;True;Property;_head_l;head_l;0;0;Create;True;0;0;False;0;2ae8f9258e4823a408cd3d8a855b8fd2;2ae8f9258e4823a408cd3d8a855b8fd2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-722.3913,-335.2851;Float;True;Property;_raiden_head_d;raiden_head_d;1;0;Create;True;0;0;False;0;e00011b4860e6e545b7922580d74fc58;e00011b4860e6e545b7922580d74fc58;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;-751.543,491.0965;Float;False;Property;_OutLine_Color;OutLine_Color;3;0;Create;True;0;0;False;0;0,0,0,0;0,0.9019608,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-1406.232,622.4117;Float;False;Property;_X_Ray_Bias;X_Ray_Bias;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;9;-1161.197,829.2887;Float;False;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;2.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;10;-760.0291,840.8586;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1407.31,871.6996;Float;False;Property;_X_Ray_Scale;X_Ray_Scale;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-251.6099,-191.5111;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-782.0178,1163.361;Float;False;Property;_OutLineWidth;OutLineWidth;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-766.682,245.9296;Float;True;Property;_head_n;head_n;2;0;Create;True;0;0;False;0;05614e2f8fb2aae40a2119f417ba858b;05614e2f8fb2aae40a2119f417ba858b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-1417.932,1118.721;Float;False;Property;_X_Ray_Power;X_Ray_Power;6;0;Create;True;0;0;False;0;2.5;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OutlineNode;13;-319.9969,883.48;Float;False;0;True;Transparent;2;7;Back;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;514.1542,408.135;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Role_Warrior_Head_Material;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;1;6;0
WireConnection;9;2;7;0
WireConnection;9;3;8;0
WireConnection;10;0;9;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;13;0;11;0
WireConnection;13;2;10;0
WireConnection;13;1;12;0
WireConnection;0;1;5;0
WireConnection;0;2;3;0
ASEEND*/
//CHKSM=976525BEDC56A1846776F1C9197F21A5A49B0618