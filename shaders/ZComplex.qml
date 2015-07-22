Shader {
    id: p1

  ///////////////////////////// выбор функции
  property var funcs: [ 
  "p = c_sin(p)*qq;",
  "p = c_tan(p)*qq;",
  "p = c_div( vec2(qq,0),p );",
  "p = c_mul( p,c_add( p, vec2(qq,0) ) );",
  "p = c_mul( p,vec2(10,10) );",  
  "p = c_log(p)*qq;",
  "p = c_div( vec2(qq,0), c_log(p) );",
  "p = c_div( c_log(p), c_sin(p) );",
  "p = c_div( vec2(1,0), c_sin(p) );",
  "p = p*qq;",

  "EDIT"
  ]

  RadioParam {
    id: pFuncNum
    text: "Функция"
    values: funcs
    onValueChanged: if (pFuncNum.value < funcs.length-1) pFunc.value = funcs[ pFuncNum.value ];
  }
  
  TextParam {
    visible: pFuncNum.value >= funcs.length-1
    width: 250
    id: pFunc
    text: "Своя"
  }

  //////////////////////////////////////////// параметры функции    
  
  Param {
    id: scaling
    text: "Distort ZComplex Scale"
    min: 0.1
    max: 200
    value: 7
    step: 0.1
  }
  
  Param {
    id: qq
    text: "Distort ZComplex qq"
    color: "red"
    min: 0
    max: 100
    step: 0.1
    value: 1
  }    
  
  /*
  CheckBoxParam {
    text: "Distort ZAxis sphere"
    width: 160
    checked: true
    id: pShowSphere
  }
  

  Spheres {
    positions: [0,0,100] //pCustom2.value]
    wire: true
    radius: custom1.value
    shader: undefined
    visible: pShowSphere.checked    
  }*/

  vertex: vtemplate.replace("FUNC",pFunc.value);

  property var vtemplate: "
#ifndef COMPLEX      
#define COMPLEX

// https://en.wikipedia.org/wiki/Hyperbolic_function
#define sinh(x) ( exp(x) - exp(-x) )/2.0
#define cosh(x) ( exp(x) + exp(-x) )/2.0
#define atan2(x,y) atan(x,y)

// https://github.com/julesb/glsl-util/blob/master/complexvisual.glsl

#ifndef PI
#define PI 3.14159265      
#endif

//#define c_mul(a, b) vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x)
//#define c_div(a, b) (c_mul(a , c_inv(b)))
#define c_div(a, b) vec2(((a.x*b.x+a.y*b.y)/(b.x*b.x+b.y*b.y)),((a.y*b.x-a.x*b.y)/(b.x*b.x+b.y*b.y)))
#define c_modulus(a) length(a)
#define c_conj(a) vec2(a.x,-a.y)
#define c_arg(a) atan2(a.y,a.x)
#define c_sin(a) vec2(sin(a.x) * cosh(a.y), cos(a.x) * sinh(a.y))
#define c_cos(a) vec2(cos(a.x) * cosh(a.y), -sin(a.x) * sinh(a.y))
//#define c_tan c_div(c_sin(a), c_cos(a))

vec2 c_add(vec2 a, vec2 b) { return a+b;} // is redundant
vec2 c_sub(vec2 a, vec2 b) { return a-b;} // is redundant
vec2 c_mul(vec2 a, vec2 b) { return vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x);}
//vec2 c_div(vec2 a, vec2 b) { return c_mul(a , c_inv(b));}
//float c_modulus(vec2 a) {return sqrt(a.x*a.x+a.y*a.y);}
//float c_modulus(vec2 a) {return length(a); }
//float c_arg(vec2 a) {return atan2(a.y,a.x);}

vec2 c_sqrt(vec2 a) {
    float r = sqrt(a.x*a.x+a.y*a.y);
    float rpart = sqrt(0.5*(r+a.x));
    float ipart = sqrt(0.5*(r-a.x));
    if (a.y < 0.0) ipart = -ipart;
    return vec2(rpart,ipart);
}

//vec2 c_sin(vec2 a) {return vec2(sin(a.x) * cosh(a.y), cos(a.x) * sinh(a.y));}
//vec2 c_cos(vec2 a) {return vec2(cos(a.x) * cosh(a.y), -sin(a.x) * sinh(a.y));}
vec2 c_tan(vec2 a) {return c_div(c_sin(a), c_cos(a)); }

vec2 c_log(vec2 a) {
    float rpart = sqrt((a.x*a.x)+(a.y*a.y));
    float ipart = atan2(a.y,a.x);
    if (ipart > PI) ipart=ipart-(2.0*PI);
    return vec2(log(rpart),ipart);
}

vec2 c_mobius(vec2 a) {
    vec2 c1 = a - vec2(1.0,0.0);
    vec2 c2 = a + vec2(1.0,0.0);
    return c_div(c1, c2);
}
vec2 c_z_plus_one_over_z(vec2 a) {
    return a + c_div(vec2(1.0,0.0), a);
    //return c_add(a, c_div(vec2(1.0,0.0), a));
}
vec2 c_z_squared_plus_c(vec2 z, vec2 c) {
    return c_mul(z, z) + c;
}

vec2 c_sin_of_one_over_z(vec2 z) {
    return c_sin(c_div(vec2(1.0,0.0), z));
}
#endif      

			uniform float sceneTime;
			uniform float scaling;
			uniform float qq;
			
			void main( void ) {
			  vec2 p = vec2( gl_Position.x / scaling, gl_Position.y / scaling );

			  FUNC
			  
			  gl_Position.x = p.x;
			  gl_Position.y = p.y;

//			  gl_Position.x = z.x * radius;
//			  gl_Position.y = z.y * radius;
			}
			"
 
}
