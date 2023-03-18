
/* 
 

https://docs.google.com/document/d/1D9FnLSTTJiW6ZAOU5xMwptPnyI26wqv3jOI9cPlMKmo/edit

Archivos necesarios:
  - etapa1.mp4 : video informativo sobre el fenomeno del niño
  - etapa2.mp4 : video informativo sobre el plan de reconstruccion con cambios
  - etapa3.mp4 : video informativo sobre el actual fenomeno del niño
  
  - menu1.mp4 : menu vertical (solo opcion 1)
  - menu2.mp4 : menu vertical (opcion 1 y 2)
  - menu3.mp4 : menu vertical (opcion 1 2 y 3)

  - mano_reinicio.mp4 : animacion de la mano parpadeando y texto que dice click aquí para reiniciar la experiencia
  - mano.mp4 : animacion de la mano parpadeando y texto que dice click aquí para pasar a la siguiente etapa
  

ETAPA 0 - INICIO
  - Proyección 'menu1.mp4'
  - Detectar presión del botón (con sensor de proximidad), al presionar se pasa a la etapa 1 y se oculta el menu

ETAPA 1 - ANTECEDENTES
  - Proyección 'etapa1.mp4'sobre la pared izquierda
  - El menú no se proyecta mientras se reproduce el video
  
ETAPA 15 - TRANSICIÓN
  - Ya se terminó de reproducir el video 'etapa1.mp4'
  - Aparece el menú para avanzar a la etapa 2
  - Detectar presión del botón (con sensor de proximidad), al presionar se pasa a la etapa 2 y se oculta el menu


ETAPA 2 - RECONSTRUCCIÓN CON CAMBIOS
  - Proyección 'etapa2.mp4' sobre la pared izquierda
  - El menú no se proyecta mientras se reproduce el video
 
ETAPA 25 - TRANSICIÓN
  - Ya se terminó de reproducir el video 'etapa2.mp4'
  - Aparece el menú para avanzar a la etapa 3
  - Detectar presión del botón (con sensor de proximidad), al presionar se pasa a la etapa 2 y se oculta el menu


ETAPA 3 - ACTUALIDAD
  - Proyección 'etapa3.mp4' sobre la pared izquierda
  - El menú no se proyecta mientras se reproduce el video, cuando se termina de reproducir, aparece el menú para apretar el botón de reinicio
  - Detectar presión del botón (con sensor de proximidad), al presionar se reinicia y se muestra el menu etapa 0

ETAPA 35 - TRANSICIÓN A REINICIO
  - Ya se terminó de reproducir el video 'etapa3.mp4'
  - Aparecen las 3 etapas proyectadas
  - Aparece el video de reinicio 'mano_reinicio.mp4'
  - Detectar presión del botón (con sensor de proximidad), al presionar se reinicia



PARA SIMULARLO AQUÍ, LA PRESIÓN DEL BOTÓN LA SIMULARÉ CON LA TECLA x
*/
 
 
 
 
 // Importamos bibliotecas:
import processing.video.*;
import processing.sound.*;

Movie video_etapa1;
Movie video_etapa2;
Movie video_etapa3;
Movie video_mano_siguiente;
Movie video_mano_inicio;
Movie video_mano_reinicio;
 
PImage foto_menu1;
PImage foto_menu2;
PImage foto_menu3;




int WindowHeight = 1280;
int WindowWidth = 720;

/* posiciones de inicio de los videos */
int VideoX = 400;
int VideoY = 35;

/* tamaño del video */
int TamañoY = 200 +650;
int TamañoX = 200 + 850;


// Declaramos variables para unir ambos etapas
int etapa;
/****************************************************************/

void setup(){
  
  // Configuramos ventana y modo de color
  //size(1280, 720);
  fullScreen();
  // Asignamos archivos a objetos
  println("Cargando archivos ...");
  video_etapa1 = new Movie(this, "etapa1.mp4");
  video_etapa2 = new Movie(this, "etapa2.mp4");
  video_etapa3 = new Movie(this, "etapa3.mp4");

  video_mano_siguiente = new Movie(this, "mano_siguiente.mp4");
  video_mano_inicio = new Movie(this, "mano_iniciar.mp4");
  video_mano_reinicio = new Movie(this, "mano_reinicio.mp4");
  
  foto_menu1 = loadImage("menu1.png");
  foto_menu2 = loadImage("menu2.png");
  foto_menu3 = loadImage("menu3.png");
  
  println("Carga de archivos finalizada.");
  
  video_mano_siguiente.loop();
  video_mano_reinicio.loop();
  video_mano_inicio.loop();
  
  // Empezamos mostrando el etapa 0
  etapa = 0;
  // Configuramos e inicializamos variables para etapa 01
  frameRate(30);  
 
}

/****************************************************************/

void draw(){
  println("Etapa: " + etapa);
  background(0);
  switch(etapa){
    case 0:
      image(video_mano_inicio, 0, 0,WindowHeight,WindowWidth);
      loopearVideo(video_mano_inicio);
    break;
    case 1:
      
      image(video_etapa1, VideoX, VideoY,TamañoX,TamañoY);
      
      video_etapa1.loop();

      image(foto_menu1,0,0,WindowHeight,WindowWidth);

      if(is_movie_finished(video_etapa1)){
        etapa = 15;
      }
    
    break;
    case 15:
      image(video_mano_siguiente, 0, 0,WindowHeight,WindowWidth);
      loopearVideo(video_mano_siguiente);
      image(foto_menu1,0,0,WindowHeight,WindowWidth);

    break;
    case 2:

      image(video_etapa2, VideoX, VideoY,TamañoX,TamañoY);
      video_etapa2.loop();
      image(foto_menu2,0,0,WindowHeight,WindowWidth);

      if(is_movie_finished(video_etapa2)){
        etapa = 25;
      }
    
    break;
    case 25:
      image(video_mano_siguiente, 0, 0,WindowHeight,WindowWidth);
      loopearVideo(video_mano_siguiente);
      image(foto_menu2,0,0,WindowHeight,WindowWidth);

    break;
    case 3:
      image(video_etapa3, VideoX, VideoY,TamañoX,TamañoY);
      video_etapa3.loop();
      image(foto_menu3,0,0,WindowHeight,WindowWidth);

      if(is_movie_finished(video_etapa3)){
        etapa = 35;
      }

    break;
    case 35:

      image(video_mano_reinicio, 0, 0,WindowHeight,WindowWidth);
      loopearVideo(video_mano_reinicio);
      image(foto_menu3,0,0,WindowHeight,WindowWidth);

    break;
    


  }

}

  
 
/* Este evento sería remplazado por la llegada de la señal desde arduino */
void keyPressed(){

  if(key=='x'){
    switch (etapa) {
      case 0:
        etapa = 1;

        break;
      case 1:
        etapa = 15;  
        video_etapa1.stop();
        


        break;
      case 15:
        etapa = 2; //esto es para no tener que tragarme el video entero xd
        

        break;
      case 2:
        etapa = 25;  
        video_etapa2.stop();
        

        break;
      case 25:
        etapa = 3; //esto es para no tener que tragarme el video entero xd
        
        break;
      case 3:
        etapa = 35;  
        video_etapa3.stop();
        
        break;

      case 35:
        etapa = 0;


        break;
    

    
      
    }





  }

 
 
   

}
 
 
void loopearVideo(Movie m){
  if(is_movie_finished(m)){
    m.jump(0);
  }
}

boolean is_movie_finished(Movie m) {
  return m.duration() - m.time() < 0.05;
}
 
// Copiar siempre esta función cuando se reproducen videos
void movieEvent(Movie m){
  m.read();
}
