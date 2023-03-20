

/* 

La versión testeable de este código está en 
https://www.tinkercad.com/things/g29wGx3ESqS-3sensoresdistancia/editel?sharecode=E_B-ecPCfF6KbyEXxUpX4azZBuNa2oXLY5SuUtATBuQ


 */

#define Rojo_s1 7
#define Verde_s1 6
#define Rojo_s2 5
#define Verde_s2 4
#define Rojo_s3 3
#define Verde_s3 2

// SENSOR DE DISTANCIA 1
int ts1=13,es1=12;

// SENSOR DE DISTANCIA 2
int ts2=11,es2=10;

// SENSOR DE DISTANCIA 3
int ts3=9,es3=8;

int dist_s1,dist_s2,dist_s3;

/* en segundos */
int duracion_video_1 = 19;
int duracion_video_2 = 50;
int duracion_video_3 = 69;

bool activar_logs = true;

void setup(){
  // Configuramos los sensores de distancia
  rsHCSR04_Inicializa(ts1, es1); //sensor1
  rsHCSR04_Inicializa(ts2, es2); //sensor2
  rsHCSR04_Inicializa(ts3, es3); //sensor3
  
  // Configurar comunicación serial
  Serial.begin(9600);
}

void loop(){
  // Leemos el valor entregado por cada sensor	
  dist_s1 = rsHCSR04_CalcDistancia(ts1, es1);
  dist_s2 = rsHCSR04_CalcDistancia(ts2, es2);
  dist_s3 = rsHCSR04_CalcDistancia(ts3, es3);
  // Transmitimos dicho valor por puerto serial
  
  log("Leyendo sensores...");
  pintarLeds();


}

void pintarLeds(){

  if (dist_s1>0){
    Serial.println("1");
    // Verde
    digitalWrite(Rojo_s1, LOW);
    digitalWrite(Verde_s1, HIGH);
    
    log("ReproduciendoVideo1, esperando " + String(duracion_video_1) + "seg");


    delay(duracion_video_1*1000);

  }else{
    // Rojo
    digitalWrite(Rojo_s1, HIGH);
    digitalWrite(Verde_s1, LOW);
  }
  
  if (dist_s2>0){
    Serial.println(2);
    // Verde
    digitalWrite(Rojo_s2, LOW);
    digitalWrite(Verde_s2, HIGH);
    log("ReproduciendoVideo2, esperando " +String(duracion_video_2) + "seg");
    
    delay(duracion_video_2*1000);
    
  }else{
    // Rojo
    digitalWrite(Rojo_s2, HIGH);
    digitalWrite(Verde_s2, LOW);
  }

  if (dist_s3>0){
    Serial.println(3);
    // Verde
    digitalWrite(Rojo_s3, LOW);
    digitalWrite(Verde_s3, HIGH);
    log("ReproduciendoVideo3, esperando " + String(duracion_video_3) + "seg");
    
    delay(duracion_video_3*1000);
    
  }else{
    // Rojo
    digitalWrite(Rojo_s3, HIGH);
    digitalWrite(Verde_s3, LOW);
    
  }


}

void log(String mensaje){
  if(activar_logs)
    Serial.println(mensaje);
}

/******************************************************************/
/*****             Función: rsHCSR04_Inicializa().            *****/
/******************************************************************/
/*****        Autor: Rolando Sánchez Ponce                    *****/
/*****        Fecha: Noviembre 2021                           *****/
/******************************************************************/
/******************************************************************/
/*****	Inicializa el sensor de distancia HC-SR04             *****/
/*****  Entradas:	pinT, pin conectado al pin TRIGGER        *****/
/*****              pinE, pin conectado al pin ECHO           *****/
/*****  Salida:     Ninguna                                   *****/
/******************************************************************/
int rsHCSR04_Inicializa(int pinT, int pinE){
  pinMode(pinT, OUTPUT);
  pinMode(pinE, INPUT);
}



/******************************************************************/
/*****           Función: rsHCSR04_CalcDistancia().           *****/
/******************************************************************/
/*****        Autor: Rolando Sánchez Ponce                    *****/
/*****        Fecha: Setiembre 2015                           *****/
/*****        Actualizado: Noviembre 2021                     *****/
/******************************************************************/
/******************************************************************/
/*****	Calcula la distancia en cm que entrega el sensor de   *****/
/*****  distancia HC-SR04.                                    *****/
/*****  Entradas:	pinT, pin conectado al pin TRIGGER        *****/
/*****              pinE, pin conectado al pin ECHO           *****/
/*****  Salida:     [5, 300] distancia entre 5cm y 300cm      *****/
/*****              0, distancia mayor a 3m, menor a 5cm o    *****/
/*****                 no hay objeto frente al sensor.        *****/
/******************************************************************/
int rsHCSR04_CalcDistancia(int pinT, int pinE){
  unsigned int dist_cm;
  digitalWrite(pinT, HIGH);
  delayMicroseconds(10);
  digitalWrite(pinT, LOW);
  dist_cm = pulseIn(pinE, HIGH);
  dist_cm = dist_cm/58.2;
  if((dist_cm<5)||(dist_cm>300)) dist_cm=0;
  return dist_cm;
}
