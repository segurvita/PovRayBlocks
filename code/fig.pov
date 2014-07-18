#include "colors.inc"
#include "skies.inc"
#include "shapes.inc"
#include "textures.inc"
#include "Woods.inc"
#include "stones.inc"
#include "glass.inc"
#include "metals.inc"

//-------------------------------
//	初期設定
//-------------------------------

//変数定義
#declare O = <0,0,0>;
#declare X = <1,0,0>;
#declare Y = <0,1,0>;
#declare Z = <0,0,1>;

#declare golden_ratio = 1.618;	//黄金比
                                       
//背景
sky_sphere  {
   S_Cloud1
}

//-------------------------------
//	視点設定
//-------------------------------
//#declare eye_location = 4*X+2*Y+6*Z;  //fig1:通常視点
//#declare eye_location = 5*X-0.5*Y+5*Z;  //fig2:文字の正面
#declare eye_location = 1*X+1*Y+10*Y;         //fig3:プロジェクタから
#declare look_at_location = O;
camera{
	location eye_location
	right <-1.33, 0, 0>
	sky <0, 1, 0>
	look_at look_at_location
	angle 60	
}

//光源
light_source {
	eye_location-X+2*Y+2*Z
	color White
	shadowless	//影を消す
}

//-------------------------------
//	矢印オブジェクト
//-------------------------------

//座標軸の表示サイズ
#declare arrow_length = 2.5;		//座標軸の長さ
#declare arrow_radius = 0.025;		//座標軸の太さ

//矢印オブジェクト
#declare arrow = union{	
	cone {	//円錐
		arrow_length*X, arrow_radius*2	// 一方の面の中心と半径
		(arrow_length + arrow_radius*4*golden_ratio)*X, 0	// もう一方の面の中心と半径
		open			// 両底面を取り除く
	}
	cylinder{	//円柱
		O, arrow_length*X, arrow_radius
	}
	disc{
		arrow_length*X, -X, arrow_radius*2
	}
}

//-------------------------------
//	単位ブロック
//-------------------------------
#declare block_unit = 1.0;
#declare block = union{	
    box{
        <0,0,0>,<block_unit,block_unit,block_unit>
        pigment { Blue }
        finish{phong 1 reflection 0.1}
    }
}
object{ block }

//-------------------------------
//	ピース
//-------------------------------
                           
//-------------------------------
//	壁
//-------------------------------
#declare wall_span = 1.0;
#declare wall = union{
	plane { Y, 0 pigment { checker White, Gray scale wall_span}}		//床
	plane { Z, -6*wall_span pigment { checker Gray, White scale wall_span}}	    //壁
	plane { X, -6*wall_span pigment { checker Gray, White scale wall_span}}	    //壁
	plane { -X, -6*wall_span pigment { checker Gray, White scale wall_span}}	//壁
	plane { Z, 10*wall_span pigment { checker Gray, White scale wall_span}}	    //壁
}

object{ wall pigment { checker White, Gray scale wall_span} }

