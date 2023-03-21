/* 

Archivos necesarios:
  - etapa1.mp4 : video informativo sobre el fenomeno del niño
  - etapa2.mp4 : video informativo sobre el plan de reconstruccion con cambios
  - etapa3.mp4 : video informativo sobre el actual fenomeno del niño

ETAPA 0
  - Espera a que se active un sensor
ETAPA 1 - ANTECEDENTES
  - Se activa el sensor 1 y arduino envía a processing la cadena "1"
  - Proyección 'etapa1.mp4'sobre la pared
ETAPA 2 - RECONSTRUCCIÓN CON CAMBIOS
  - Se activa el sensor 1 y arduino envía a processing la cadena "2"
  - Proyección 'etapa2.mp4' sobre la pared
ETAPA 3 - ACTUALIDAD
  - Se activa el sensor 1 y arduino envía a processing la cadena "3"
  - Proyección 'etapa3.mp4' sobre la pared
  
Para probar SOLO EL PROCESSING se puede usar las teclas 1 2 y 3 para reproducir los videos y la letra x minuscula para cerrarlos.
*/
 
 // Importamos bibliotecas:
import processing.video.*;
import processing.sound.*;
import processing.serial.*;

Serial puertoSerial;

Movie video_etapa1;
Movie video_etapa2;
Movie video_etapa3;

 

/* posiciones de inicio de los videos */
int PosVideo_X = 280;
int PosVideo_Y = 0;

/* tamaño del video */
int TamañoVideo_Y = 720;
int TamañoVideo_X = 720;
String nombre_puerto ="COM6";

boolean ignore_new_orders = false;

// Declaramos variables para unir ambos etapas
int etapa;
/****************************************************************/

void setup(){
  
  // Configuramos ventana
  size(1280, 720);
  //fullScreen();
  // Asignamos archivos a objetos
  println("Cargando archivos ...");
  video_etapa1 = new Movie(this, "etapa1.mp4");
  video_etapa2 = new Movie(this, "etapa2.mp4");
  video_etapa3 = new Movie(this, "etapa3.mp4");

  println("Carga de archivos finalizada.");
   
  
  puertoSerial = new Serial(this, nombre_puerto, 9600);
  

  // Empezamos mostrando el etapa 0
  etapa = 0;
  // Configuramos e inicializamos variables para etapa 01
  frameRate(30);  
 
}

/****************************************************************/

String mensaje_llegado;
void draw(){
  
  leerPuertoSerial();

  
  background(0);
  switch(etapa){
    case 0:
      
    break;
    case 1:
      
      image(video_etapa1, PosVideo_X, PosVideo_Y,TamañoVideo_X,TamañoVideo_Y);
      video_etapa1.play();
      if(is_movie_finished(video_etapa1)){
        detenerVideosTodos();
        etapa = 0;
        ignore_new_orders = false; //desbloqueamos la actualizacion de etapas
      } 
    break;    
    case 2:

      image(video_etapa2, PosVideo_X, PosVideo_Y,TamañoVideo_X,TamañoVideo_Y);
      video_etapa2.play();
      if(is_movie_finished(video_etapa2)){
        detenerVideosTodos();
        etapa = 0;
        ignore_new_orders = false;//desbloqueamos la actualizacion de etapas
      }

    break;
    case 3:
      image(video_etapa3, PosVideo_X, PosVideo_Y,TamañoVideo_X,TamañoVideo_Y);
      video_etapa3.play();
      if(is_movie_finished(video_etapa3)){
        detenerVideosTodos();
        etapa = 0;
        ignore_new_orders = false;//desbloqueamos la actualizacion de etapas
      } 
    break;
  }

  println("Etapa: " + etapa);
  puertoSerial.write(etapa);


}


void leerPuertoSerial(){

  if(puertoSerial.available()>0){
    mensaje_llegado = puertoSerial.readString();
    println("sensor activado:"+mensaje_llegado);

    /* verificamos que haya un mensaje llegando de arduino */
    if(mensaje_llegado != null && !mensaje_llegado.equals("0")){
      int nueva_etapa = Integer.parseInt(mensaje_llegado);
      //Verificamos que se pueda cambiar la etapa y que la nueva etapa sea distinta a la actual
      if(!ignore_new_orders && etapa != nueva_etapa){
        detenerVideosTodos();
        etapa = nueva_etapa; 
        ignore_new_orders = true; //bloqueamos la actualizacion de etapas
      }
    }
  }

}



void keyPressed(){
  
  /* para que no se reproduzca un video sobre otro (no avanzar de etapa si se esta reproduciendo) */
  if(!ignore_new_orders){
    if(key == '1' || key == '2' || key == '3'){
      etapa = Integer.parseInt(str(key));
      ignore_new_orders = true; //bloqueamos la actualizacion de etapas
    }
  }

  /* salir del video con x */
  if(key=='x'){
    detenerVideosTodos();
    
    switch (etapa) {
      case 1:
        etapa = 0;  
        break;
      case 2:
        etapa = 0;  
        break;
      case 3:
        etapa = 0;  
        break;
    }
    ignore_new_orders = false;//desbloqueamos la actualizacion de etapas
 
  }

}

void detenerVideosTodos(){
  if(!is_movie_finished(video_etapa1)){
    video_etapa1.stop();
  }
  if(!is_movie_finished(video_etapa2)){
    video_etapa2.stop();
  }
  if(!is_movie_finished(video_etapa3)){
    video_etapa3.stop();
  }

}
 
  

boolean is_movie_finished(Movie m) {
  return m.duration() - m.time() < 0.05;
}
 
// Copiar siempre esta función cuando se reproducen videos
void movieEvent(Movie m){
  m.read();
}
