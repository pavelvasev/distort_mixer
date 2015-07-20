Shader {
  
  Param {
    id: custom1
    text: "Param 1"
    min: -100; max: 100; step: 0.1; 
    value: 0
  }    

  property var vertex: "

        uniform float sceneTime;
        uniform float custom1; 
        
        void main()
        {
          vec3 v = gl_Position.xyz;
          v.z = v.z + custom1;

          gl_Position = vec4( v, 1.0);
        }
     " // vertex shader code

}