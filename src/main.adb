with Pumps;
use all type Pumps.Reserve_Sensor_States;
use all type Pumps.Pump_States;


procedure Main with SPARK_Mode => On is
   pump : Pumps.Pump_Type;
   empty_state : Pumps.Reserve_Sensor_States := Pumps.Reserve_Sensor_States'First;
begin
   pump.Lift_Nozzle;

   if pump.Reserve_State /= Empty then
      pump.Start_Pumping;
      pump.Set_Reserve_Sensor(Empty);

      if pump.State = Pumping then
         pump.Stop_Pumping;
      end if;

      pump.Replace_Nozzle;
      pump.Pay;
   end if;


end Main;
