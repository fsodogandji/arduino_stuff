float adcValue = 0;
float voltage = 0;
float percentRH = 0;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  adcValue = analogRead(0); // Read voltage coming from sensor (adcValue will be between 0-1023)
  voltage = (adcValue/1023.0)*5.0; // Translate ADC value into a voltage value
  
  Serial.println(adcValue);
  // Sensor 808H5V5
  //http://www.cooking-hacks.com/skin/frontend/default/cooking/pdf/Humedad-808H5V5.pdf
  //Based as the power supplied by 5.0V DC, at 25℃ environment 
  // 1.73V= 30%RH 2.08V=40%RH 2.41V=50%RH 2.72V=60%RH 3.01V=70%RH 3.30V=80%RH 
  // which gives a slope of (3.3 - 1.73) /(80-30)
  // From the chart 
  // 1.73v = (0.0314 * 30rh) + x
  // where x = 0.788
  // RH = (voltage - x) / slope
  // not temperature regulated

  percentRH = (voltage - 0.788) / 0.0314; // Translate voltage into percent relative humidity
  
  // Print value
  Serial.print("%RH = ");
  Serial.println(percentRH,DEC); 
  
  // Delay for one second
  delay(1000);
}
