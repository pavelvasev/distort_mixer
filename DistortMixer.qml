import components.appmix

Item {
  id: scen
 
  property var ctag: "right"

  property var shader: [ sh.shader, sh2.shader, sh3.shader ] 

  Links {
    tag: ctag
    text: "Справка по шейдерам"
    height: 30
    values: [ ["readme.md",Qt.resolvedUrl("readme.md")] ]
  }

  Text {
    text: "Выбор шейдеров"
    property var tag: ctag
  }  
  

  property var apps: ["DenisDistortShader", "ZAxisDistortShader", "ZPointDistortShader","ZComplexDistortShader", "ExampleDistortShader", "MorphingShader"]
  
  AppChooser {
    id: sh
    apps: scen.apps
    objectParent: sh.paramPlace
    ctag: ctag
  }

  AppChooser {
    id: sh2
    apps: scen.apps    
    objectParent: sh2.paramPlace
    ctag: ctag
  }

  AppChooser {
    id: sh3
    apps: scen.apps    
    objectParent: sh3.paramPlace
    selectedNumber: 6 // Morphing
    ctag: ctag
  }
}