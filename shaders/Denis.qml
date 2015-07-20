Shader {
  
  Param {
    id: custom1
    text: "Phase"
    min: -Math.PI*3/2; max: Math.PI*3/2; step: 0.1; 
    value: 0
  }    

  Param {
    id: custom2
    text: "Radius"
    min: 0; max: 10; step: 0.1
    value: 1
  }    

  property var vertex: "

        uniform float sceneTime;
        uniform float custom1; 
        uniform float custom2; 
        
        void main()
        {
          vec3 v = gl_Position.xyz;
          float phase = custom1;
          float distortAmount = custom2;

          //Compute value of distortion for current vertex
          float distort = distortAmount * sin( phase + 0.015 * v.z );
          
          //Move the position
         	v.x /= 1.0 + distort;
	        v.y /= 1.0 + distort;
          v.z /= 1.0 + distort;          

          gl_Position = vec4( v, 1.0);
        }
     " // vertex shader code

}