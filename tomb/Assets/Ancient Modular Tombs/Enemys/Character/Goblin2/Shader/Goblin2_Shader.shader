// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Goblin2_Material"
{
	Properties
	{
		_Gobin_d("Gobin_d", 2D) = "white" {}
		_Gobin_d_color("Gobin_d_color", 2D) = "white" {}
		_Gobin_n("Gobin_n", 2D) = "white" {}
		_Gobin_layered("Gobin_layered", 2D) = "white" {}
		_Gobin_color("Gobin_color", 2D) = "white" {}
		[HDR]_Earrings_Color("Earrings_Color", Color) = (1,1,1,0)
		[HDR]_Dec_Color("Dec_Color", Color) = (1,1,1,0)
		[HDR]_Grain_Color("Grain_Color", Color) = (1,1,1,0)
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

		uniform sampler2D _Gobin_n;
		uniform float4 _Gobin_n_ST;
		uniform sampler2D _Gobin_d;
		uniform float4 _Gobin_d_ST;
		uniform sampler2D _Gobin_d_color;
		uniform float4 _Gobin_d_color_ST;
		uniform float4 _Earrings_Color;
		uniform sampler2D _Gobin_layered;
		uniform float4 _Gobin_layered_ST;
		uniform float4 _Grain_Color;
		uniform sampler2D _Gobin_color;
		uniform float4 _Gobin_color_ST;
		uniform float4 _Dec_Color;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Gobin_n = i.uv_texcoord * _Gobin_n_ST.xy + _Gobin_n_ST.zw;
			o.Normal = tex2D( _Gobin_n, uv_Gobin_n ).rgb;
			float2 uv_Gobin_d = i.uv_texcoord * _Gobin_d_ST.xy + _Gobin_d_ST.zw;
			float2 uv_Gobin_d_color = i.uv_texcoord * _Gobin_d_color_ST.xy + _Gobin_d_color_ST.zw;
			o.Albedo = ( tex2D( _Gobin_d, uv_Gobin_d ) * tex2D( _Gobin_d_color, uv_Gobin_d_color ) ).rgb;
			float2 uv_Gobin_layered = i.uv_texcoord * _Gobin_layered_ST.xy + _Gobin_layered_ST.zw;
			float4 tex2DNode4 = tex2D( _Gobin_layered, uv_Gobin_layered );
			float2 uv_Gobin_color = i.uv_texcoord * _Gobin_color_ST.xy + _Gobin_color_ST.zw;
			float4 color24 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			o.Emission = ( ( _Earrings_Color * tex2DNode4.r ) + ( ( 1.0 - tex2DNode4.b ) * _Grain_Color ) + ( tex2D( _Gobin_color, uv_Gobin_color ).b * _Dec_Color * ( 1.0 - ( i.uv_texcoord.y * color24 * 1.2 ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
293;189;1576;907;2219.888;-922.9219;1.3;True;False
Node;AmplifyShaderEditor.ColorNode;24;-2139.456,1972.382;Float;False;Constant;_Color0;Color 0;8;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-1949.372,2154.201;Float;False;Constant;_Float0;Float 0;8;0;Create;True;0;0;False;0;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-2159.643,1592.436;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-1582.5,689.2831;Float;True;Property;_Gobin_layered;Gobin_layered;3;0;Create;True;0;0;False;0;af0a218de24eabe4c8675246cfda44ad;af0a218de24eabe4c8675246cfda44ad;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-1681.599,1754.197;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;8;-1297.321,355.5323;Float;False;Property;_Earrings_Color;Earrings_Color;5;1;[HDR];Create;True;0;0;False;0;1,1,1,0;2,1.365517,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;11;-1213.901,763.2053;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-1252.501,1001.205;Float;False;Property;_Grain_Color;Grain_Color;7;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,0.2689656,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;17;-1457.546,1507.054;Float;False;Property;_Dec_Color;Dec_Color;6;1;[HDR];Create;True;0;0;False;0;1,1,1,0;3,2.42069,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-1901.5,1208.283;Float;True;Property;_Gobin_color;Gobin_color;4;0;Create;True;0;0;False;0;32e1375613f9c3e438749fdbc52ef161;32e1375613f9c3e438749fdbc52ef161;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;26;-1438.261,1754.366;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-982.9009,870.2053;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-575,-229.5;Float;True;Property;_Gobin_d;Gobin_d;0;0;Create;True;0;0;False;0;0033f98edfb59bb40878d1aa4f2a0b74;0033f98edfb59bb40878d1aa4f2a0b74;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1035.747,1287.053;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-573,-21.5;Float;True;Property;_Gobin_d_color;Gobin_d_color;1;0;Create;True;0;0;False;0;bfc705afe7e71024f97ca63341ad9725;bfc705afe7e71024f97ca63341ad9725;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1006.07,464.5499;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-276,-120.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-577.9722,166.6643;Float;True;Property;_Gobin_n;Gobin_n;2;0;Create;True;0;0;False;0;ce2e521e3d3789e4e95dd076d3aa445a;ce2e521e3d3789e4e95dd076d3aa445a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-367.9844,1115.319;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Goblin2_Material;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;20;2
WireConnection;23;1;24;0
WireConnection;23;2;25;0
WireConnection;11;0;4;3
WireConnection;26;0;23;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;16;0;5;3
WireConnection;16;1;17;0
WireConnection;16;2;26;0
WireConnection;9;0;8;0
WireConnection;9;1;4;1
WireConnection;6;0;1;0
WireConnection;6;1;2;0
WireConnection;10;0;9;0
WireConnection;10;1;13;0
WireConnection;10;2;16;0
WireConnection;0;0;6;0
WireConnection;0;1;3;0
WireConnection;0;2;10;0
ASEEND*/
//CHKSM=7448CD931B2AF688E9DCF9E35A22DC624126C789