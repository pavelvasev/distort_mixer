// import "."

// Строит тримеш на указанных точках Points. Индексы вершин треугольников загружает из файла.
Scene {
  id: scen

  property var pt /// входные точки
  property alias file: triFileParam.file // входной файл

  property var shader
  
  property alias acolorize: colorTrianglesParam.value
  property alias awire: wireParam.value
  property alias aopacity: triop.value

  property alias fileParam: triFileParam
  
 ///////////////////////////////// 

  FileParam {
    text: "Файл индексов треугольников"
//    file: Qt.resolvedUrl("data/triangles.txt")
    id: triFileParam
  }

  Text {
    property var tag:"left"
    text: "Загружено треугольников: "+trimesh.indices.length/3
  }

  Param {
    text: "Раскрасить треугольники"
    values: ["нет","да"]
    id: colorTrianglesParam
  }



  CsvLoader {
    file: triFileParam.file

    function filter( item ) {
      return parseInt( item );
    }

    Flatten {
      id: flatTriangle
    }
  }
  
  Trimesh {
    id: trimesh
    positions: pt.positions
    colors: colorTrianglesParam.value > 0 ? pt.colors : []
    visible: opacity > 0
    
    indices: flatTriangle.output

    wireon: wireParam.value>0
    opacity: triop.value/100.0
    color: [1,1,1]
    
    shader: scen.shader
  }
  

  Param {
    id: wireParam
    title: "Каркас"
    min:0
    max:1
    value:0
  }
  
  Param {
    text: "Прозрачность треугольников"
    id: triop
    value: 100
  }

}