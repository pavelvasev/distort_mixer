Shader {
  
  Param {
    id: tm
    text: "Morphing"
    min: 0; max: 1; step: 0.01; 
    value: 1
  }    

  property var vertex: "
        uniform float tm; 
        
        void main()
        {
          // position is original
          // gl_Position is what contains after previous shaders
          gl_Position = vec4(position,1.0) * (1.0-tm) + gl_Position * tm;
        }
     " // vertex shader code

}