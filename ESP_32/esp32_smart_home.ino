#include <WiFi.h>
#include <Firebase_ESP_Client.h>
//Provide the token generation process info.
#include "addons/TokenHelper.h"
//Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"
#include <ESP32Servo.h>


#define WIFI_SSID "YOUR_WIFI_NAME"
#define WIFI_PASSWORD "YOUR_WIFI_PASSWORD"

// Insert Firebase project API Key
#define API_KEY "YOUR_FIREBASE_API"

// Insert RTDB URLefine the RTDB URL */
#define DATABASE_URL "YOUR_DATABASE_URL" 

#define LED1_PIN 12
#define LED2_PIN 14
#define FAN1_PIN 13

#define PMWChannel 0
#define PWMChannel1 1



const int freq = 5000;
const int freq1 = 5000;
const int resolution = 8;
const int resolution1 = 8;

FirebaseData fbdo, fbdo_s1, fbdo_s2, fbdo_s3, fbdo_s4;

FirebaseAuth auth;
FirebaseConfig config;




unsigned long sendDataPrevMillis = 0;
bool signupOK = false;

int pmwValue= 0;
int PWMValue1= 0;
bool ledStatus= false;
bool fanStatus=true;

Servo myServo;
int servoPin= 18;
bool servoStatus=false;



void setup() {
  pinMode(LED2_PIN, OUTPUT);
  pinMode(FAN1_PIN, OUTPUT);
  ledcSetup(PMWChannel, freq, resolution);
  ledcAttachPin(LED1_PIN, PMWChannel);
  // ledcSetup(PWMChannel1, freq1, resolution1);
  // ledcAttachPin(FAN1_PIN,PWMChannel1);

  myServo.attach(servoPin);
 

  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

    config.api_key = API_KEY;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Sign up */
  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println("ok");
    signupOK = true;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

 if(!Firebase.RTDB.beginStream(&fbdo_s1, "/LED/analog")){
  Serial.printf("stream | begin error, %s\n\n", fbdo_s1.errorReason().c_str());
 }
 
 if(!Firebase.RTDB.beginStream(&fbdo_s2, "/LED/digital")){
  Serial.printf("stream | begin error, %s\n\n", fbdo_s1.errorReason().c_str());
 }
 if(!Firebase.RTDB.beginStream(&fbdo_s3, "/FAN/digital")){
  Serial.printf("stream | begin error, %s\n\n", fbdo_s3.errorReason().c_str());
 }
 if(!Firebase.RTDB.beginStream(&fbdo_s4, "/door/digital")){
  Serial.printf("stream | begin error, %s\n\n", fbdo_s4.errorReason().c_str());
 }
}

void loop() {


 if(Firebase.ready() && signupOK){ 
 if(!Firebase.RTDB.readStream(&fbdo_s1))
  Serial.printf("stream 1 begin error, %s\n\n", fbdo_s1.errorReason().c_str());
  if(fbdo_s1.streamAvailable()){
      if(fbdo_s1.dataType() == "int"){
        pmwValue = fbdo_s1.intData();
        Serial.println("Successful led 1 read pmwValue");
        ledcWrite(PMWChannel, pmwValue);
      }
    }

 if(!Firebase.RTDB.readStream(&fbdo_s2))
  Serial.printf("stream 2 begin error, %s\n\n", fbdo_s2.errorReason().c_str());
     if(fbdo_s2.streamAvailable()){
      if(fbdo_s2.dataType() == "boolean"){
        ledStatus = fbdo_s2.boolData();
        Serial.println("Successful read ledStatus");
        Serial.println(LED2_PIN,ledStatus);
        digitalWrite(LED2_PIN, ledStatus);
      }
    }

     if(!Firebase.RTDB.readStream(&fbdo_s3))
  Serial.printf("stream 2 begin error, %s\n\n", fbdo_s3.errorReason().c_str());
     if(fbdo_s3.streamAvailable()){
      if(fbdo_s3.dataType() == "boolean"){
        fanStatus = fbdo_s3.boolData();
        Serial.println("Successful read fabStatus");
        Serial.println(FAN1_PIN,fanStatus);
        digitalWrite(FAN1_PIN, fanStatus);
      }
    }

     if(!Firebase.RTDB.readStream(&fbdo_s4))
       Serial.printf("stream 2 begin error, %s\n\n", fbdo_s4.errorReason().c_str());
     if(fbdo_s4.streamAvailable()){
      if(fbdo_s4.dataType() == "boolean"){
        servoStatus = fbdo_s4.boolData();
        Serial.println("Successful read servoStatus");
      
        if(servoStatus){
           myServo.write(90);
        }else{
           myServo.write(0);
        }
      
      }
    }

    


  }
  
}
