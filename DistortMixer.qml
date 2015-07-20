import components.appmix

Item {
  id: scen

  property var shader: [ sh.shader, sh2.shader, sh3.shader ] 

  Links {
    tag: "right"
    text: "Справка по шейдерам"
    height: 30
    values: [ ["readme.md",Qt.resolvedUrl("readme.md")] ]
  }

  Text {
    text: "Выбор шейдеров"
    property var tag: "right"
  }  
  

  property var apps: ["DenisDistortShader", "ZAxisDistortShader", "ZPointDistortShader","ExampleDistortShader"]
  
  AppChooser {
    id: sh
    apps: scen.apps
    objectParent: sh.paramPlace
  }

  AppChooser {
    id: sh2
    apps: scen.apps    
    objectParent: sh2.paramPlace
  }

  AppChooser {
    id: sh3
    apps: scen.apps    
    objectParent: sh3.paramPlace
  }
}