# Шейдеры искажения

По предложению Дениса Перевалова идея - выворачивать фигуры. Затем, чтобы смотреть их изнанку.

Запуск демо-сцены: http://viewlang.ru/viewlang/scene.html?s=https://github.com/pavelvasev/distort_mixer/blob/master/run-demo-all.vl

## Список шейдеров

[DenisDistortShader](shaders/Denis.qml) - синус-преобразование из книги Дениса Перевалова

- это пример из Mastering openFrameworks
https://www.youtube.com/watch?v=7uyqGC5GmDw

- глава 8, пример 06-VertexDeformation 
https://cloud.mail.ru/public/aa1a8e7d91e8/MasteringOF-Examples-OF0074-VS2010

[ZAxisDistortShader](shaders/ZAxis.qml) - сжатие вдоль оси Z по формуле 1/расстояние

[ZPointDistortShader](shaders/ZPoint.qml) - сжатие вокруг точки на оси Z по формуле 1/расстояние

[ExampleDistortShader](shaders/Example.qml) - пример шейдера с 1 параметром

## Пояснение по демо-сцене 
Шейдеры можно запускать в цепочке, до 3х штук одновременно. Последующий вертекс-шейдер использует результаты предыдущего. 

## Развитие
Развитие (Михаил Бахтерев) - создать семейство ZAxis-функций на основе каких-то хороших комплексных функций.
