with Pumps;
use all type Pumps.Reserve_Sensor_States;


procedure Main with SPARK_Mode => On is
   pump : Pumps.Pump_Type;
   empty_state : Pumps.Reserve_Sensor_States := Pumps.Reserve_Sensor_States'First;
begin
   pump.Lift_Nozzle;

   if pump.Reserve_State /= Empty then
      pump.Start_Pumping;
   end if;


end Main;
