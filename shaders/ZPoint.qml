Shader {

  Param {
    id: pCustom1
    text: "Distort ZPoint Radius"
    min: 0
    max: 100
    value: 20
  }  

  Param {
    id: pCustom2
    text: "Distort ZPoint POW"
    color: "red"
    min: 0
    max: 5
    step: 0.1
    value: 0
  }    

  Param {
    id: pCustom3
    text: "Distort ZPoint Center"
    min: -50
    max: 150
    step: 0.5
    value: 2
  }  

  CheckBoxParam {
    text: "Distort ZPoint sphere"
    checked: true
    id: pShowSphere
    width: 160
  }

  Spheres {
    positions: [0,0,pCustom3.value]
    wire: true
    radius: pCustom1.value
    shader: undefined
    visible: pShowSphere.checked
  }


    id: p1

    //property real time: theScene.sceneTime
    property real zpcustom1: pCustom1.value 
    property real zpcustom2: pCustom2.value 
    property real zpcustom3: pCustom3.value 

    vertex: "

        // uniform float time;
        uniform float zpcustom1;
        uniform float zpcustom2;
        uniform float zpcustom3;
        

        void main()
        {
          //Get original position of the vertex
          // vec3 v = position.xyz;
          vec3 v = gl_Position.xyz;

          //Compute value of distortion for current vertex
          float c2m10 = zpcustom3;//-10.0;
          float dist = distance( vec3(0.0,0.0,c2m10), v );
          //float dist = pow( v.x*v.x + v.y*v.y, 0.5); //distance( vec3(0.0,0.0,custom2), v );

          //float distort = custom1 * sin( time + 0.015 * v.y );
          //float distort = dist*dist / (custom1+1.0);
          float distort = pow( dist / zpcustom1, zpcustom2 );//custom1/10.0 );

       	  v.x /= distort;
          v.y /= distort;
          //v.z /= distort;
          v.z = (v.z - c2m10) / distort + c2m10;
                    
	        //float alfa = 0.01*distance( vec3(0.0,0.0,0.0), v );
          
          //Move the position
          /*
       	  v.x /= (0.1 + distort)*alfa;
          v.y /= (0.1 + distort)*alfa;
          v.z = (v.z - c2m10)/( (0.1 + distort)*alfa ) + c2m10;
          */

          vec3 newposition = v;

          //float zz = position.z * sin(time*custom2/400.0);
          //float zz = position.z;
          //vec3 newposition = vec3(position.x + sin(time)*custom2, position.y + cos(time * custom1) * custom2, zz);
  
          // MAIN CODE END
          gl_Position = vec4( newposition, 1.0 );
        }
     " // vertex shader code

}
