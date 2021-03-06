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
#declare eye_location = 4*Z+15*Y;         //fig3:プロジェクタから
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
#declare unitBlock = box
{
    <0,0,0>,<1,1,1>
    texture {T_Wood10}
}

//-------------------------------
//	ピースの定義
//-------------------------------
#declare piece_size = 2;
#declare piece = union{
    object{unitBlock translate <0,0,0>}
    object{unitBlock translate <1,0,0>}
    object{unitBlock translate <0,0,1>}
}            

//-------------------------------
//	ピースの配置
//-------------------------------
#declare set_span = piece_size +1;
#declare x_init = -5;
#declare z_init = -4;

object{ piece rotate y*90*0 translate <x_init,                      0,z_init> }
object{ piece rotate y*90*1 translate <x_init+1*set_span,           0,z_init+piece_size> }
object{ piece rotate y*90*2 translate <x_init+2*set_span+piece_size,0,z_init+piece_size> }
object{ piece rotate y*90*3 translate <x_init+3*set_span+piece_size,0,z_init> }

object{ piece rotate x*90*1+y*90*0 translate <x_init,                      piece_size,z_init+set_span> }
object{ piece rotate x*90*1+y*90*1 translate <x_init+1*set_span,           piece_size,z_init+set_span+piece_size> }
object{ piece rotate x*90*1+y*90*2 translate <x_init+2*set_span+piece_size,piece_size,z_init+set_span+piece_size> }
object{ piece rotate x*90*1+y*90*3 translate <x_init+3*set_span+piece_size,piece_size,z_init+set_span> }

object{ piece rotate x*90*2+y*90*0 translate <x_init,                       1,z_init+2*set_span+piece_size> }
object{ piece rotate x*90*2+y*90*1 translate <x_init+1*set_span+piece_size, 1,z_init+2*set_span+piece_size> }
object{ piece rotate x*90*2+y*90*2 translate <x_init+2*set_span+piece_size, 1,z_init+2*set_span> }
object{ piece rotate x*90*2+y*90*3 translate <x_init+3*set_span,            1,z_init+2*set_span> }

                           
//-------------------------------
//	壁
//-------------------------------
#declare wall_span = 1.0;
#declare wall = union{
	plane { Y, 0 pigment { checker White, Gray scale wall_span}}		//床
}

object{ wall pigment { checker White, Gray scale wall_span} }

