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
//#declare eye_location = 4*X-2*Y+6*Z;  //fig1:通常視点
//#declare eye_location = 5*X-0.5*Y+5*Z;  //fig2:文字の正面
#declare eye_location = 10*Y;         //fig3:プロジェクタから
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
	eye_location-X-2*Y+2*Z
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
//	壁
//-------------------------------
#declare wall_span = 2.5;
#declare wall = union{
	plane { Y, -6*wall_span pigment { checker White, Gray scale wall_span}}		//床
	plane { Z, -6*wall_span pigment { checker Gray, White scale wall_span}}	    //壁
	plane { X, -6*wall_span pigment { checker Gray, White scale wall_span}}	    //壁
	plane { -X, -6*wall_span pigment { checker Gray, White scale wall_span}}	//壁
	plane { Z, 10*wall_span pigment { checker Gray, White scale wall_span}}	    //壁
}

object{ wall pigment { checker White, Gray scale wall_span} }

//-------------------------------
//	座標軸
//-------------------------------
#declare axis = union{
    object{	arrow	translate O}
    object{	arrow	rotate z*90 translate O}
    object{	arrow	rotate y*-90 translate O}
}

object{
	axis pigment{color Green}
}

//-------------------------------
//	座標軸の文字
//-------------------------------
#declare axis_string_position = 2.8;
#declare axis_string_direction = y*30;
#declare axis_string = union{
    text {
        ttf "timrom.ttf" //フォントの指定
        "X" 0.01,0//文字列、奥行き、文字間隔
        scale 0.5   rotate axis_string_direction
        translate <axis_string_position,0,0>        
    }
    text {
        ttf "timrom.ttf" //フォントの指定
        "Y" 0.01,0//文字列、奥行き、文字間隔
        scale 0.5   rotate axis_string_direction
        translate <0,axis_string_position,0>
    }
    text {
        ttf "timrom.ttf" //フォントの指定
        "Z" 0.01,0//文字列、奥行き、文字間隔
        scale 0.5   rotate axis_string_direction
        translate <0,0,axis_string_position>
    }
}

//object{ axis_string pigment{color Green} }

//-------------------------------
//	半球面パネル
//-------------------------------
#declare sphere_panel_uni = union{
    intersection{
        difference{
            sphere{ O, 2 }
            sphere{ O, 1.99 } 
        }
  	    plane {Y, 0}
    }
}

object{	sphere_panel_uni pigment{rgbt<0.8,1.0,0.8,0.5>}}

//-------------------------------
//	表示方向
//-------------------------------
#declare display_direc = -45;
object{	arrow	rotate y*display_direc translate O pigment {color SkyBlue}}

//-------------------------------
//	スクリーン
//-------------------------------
#declare display_plane = intersection{
    polygon{
        4,
        <0,0,2>,<0,0,-2>,<0,-2,-2>,<0,-2,2>
    }
    sphere{ O, 2 }
}
//object{	display_plane	rotate y*display_direc translate O pigment {color SkyBlue}}

//-------------------------------
//	文字
//-------------------------------
#declare text_string = union{
    text {
        ttf "timrom.ttf" //フォントの指定
        "ABCDEFGHIJKL" 0.01,0//文字列、奥行き、文字間隔
        scale 0.5
        translate <-1.9,-0.5,0.0>
    }
    text {
        ttf "timrom.ttf" //フォントの指定
        "MNOPQRSTU" 0.01,0//文字列、奥行き、文字間隔
        scale 0.5
        translate <-1.5,-1.1, 0.0>
    }
    text {
        ttf "timrom.ttf" //フォントの指定
        "VWXYZ" 0.01,0//文字列、奥行き、文字間隔
        scale 0.5
        translate <-1.0,-1.7, 0.0>
    }
}
//object{	text_string	rotate y*(display_direc+90) pigment {color Red}}

//-------------------------------
//	文字押出
//-------------------------------
#declare text_string_push = difference{
    intersection{
        union{
            text {
                ttf "timrom.ttf" //フォントの指定
                "ABCDEFGHIJKL" 10,0//文字列、奥行き、文字間隔
                scale 0.4
                translate <-1.5,-0.5,0.0>
            }
            text {
                ttf "timrom.ttf" //フォントの指定
                "MNOPQRSTU" 10,0//文字列、奥行き、文字間隔
                scale 0.4
                translate <-1.2,-1.0, 0.0>
            }
            text {
                ttf "timrom.ttf" //フォントの指定
                "VWXYZ" 10,0//文字列、奥行き、文字間隔
                scale 0.4
                translate <-0.8,-1.5, 0.0>
            }
        }
        sphere{ O, 2.01 }
    }
    sphere{ O, 1.98 }
}
object{	text_string_push	rotate y*(display_direc+90) pigment {color Red}}

