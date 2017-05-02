with Pump_Units;
with Tank;
with Shared_Types;
use all type Shared_Types.Fuel_Type;

procedure Main with SPARK_Mode => On is
   pump_unit : Pump_Units.Pump_Unit_Type := Pump_Units.Make_Pump_Unit;
   my_tank : Tank.Tank_Type := Tank.Make_Tank(1000, Petrol95, 0);
   success : Boolean;
begin

   pump_unit.Fill_Tank(my_tank, success);



end Main;
