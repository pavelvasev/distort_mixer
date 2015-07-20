import components.show_points

Shader {
    id: p1

  Param {
    id: custom1
    text: "Distort ZAxis Radius"
    min: 0
    max: 100
    value: 20
  }  
  
  Param {
    id: custom2
    text: "Distort ZAxis POW"
    color: "red"
    min: 0
    max: 5
    step: 0.1
    value: 0
  }    
  
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
  }

  vertex: "
        // your things
        // uniform float time;
        uniform float custom1;
        uniform float custom2;

        void main()
        {
          //Get original position of the vertex
          vec3 v = gl_Position.xyz;
          
          //Compute value of distortion for current vertex
          float c2m10 = custom2;//-10.0;
          float dist = pow( v.x*v.x + v.y*v.y, 0.5); //distance( vec3(0.0,0.0,custom2), v );
          
          //float distort = dist*dist / (custom1+1.0);
          float distort = pow( dist / custom1, custom2 );//custom1/10.0 );

       	  v.x /= distort;
          v.y /= distort;

          gl_Position = vec4( v, 1.0);
        }
     " // vertex shader code

}
