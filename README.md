
# Ricky and Morty fan app

Proyecto en el que consultaremos los personajes de la serie, mediante la API https://rickandmortyapi.com.




## Funcionalidades

 - Listado de personajes con paginación
 - Buscador de personajes por nombre
 - Vista detalle de cada personaje
 - Cacheado en base de datos interna
 - Test Unitarios


## Librerías

En el proyecto utilizamos 2 librerías: SD Web Image y Realm (MongoDb)

La librería SD Web Image, la utilizamos para cachear las imágenes de forma que aunque no dispongamos de internet, podremos visualizarlas.

https://github.com/SDWebImage/SDWebImage

La Librería Realm Swift, se utiliza como base de datos interna, en la que iremos guardando los datos que vaya visualizando el usuario, de forma que cuando el dispositivo no tenga internet, podremos recuperar estos datos guardados, filtrarlos y obtener el detalle del personaje.

https://github.com/realm/realm-swift

Estas dos librerías, las hemos instalado mediante el Swift Package Manager.




