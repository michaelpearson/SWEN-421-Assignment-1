with Pump_Units;
with Tank;
with Shared_Types;
with General_IO;
use all type Shared_Types.Fuel_Type;

procedure Main with SPARK_Mode => On is
   pump_unit : Pump_Units.Pump_Unit_Type := Pump_Units.Make_Pump_Unit;
   my_tank : Tank.Tank_Type := Tank.Make_Tank(10, Petrol95, 0);
   my_tank1 : Tank.Tank_Type := Tank.Make_Tank(100, Petrol95, 0);
   success : Boolean;
begin

   pump_unit.Fill_Tank(my_tank, success);

   General_IO.Print_Success("Filling tank 1", success);

   pump_unit.Fill_Tank(my_tank1, success);

   General_IO.Print_Success("Filling tank 2", success);

   pump_unit.Fill_Tank(my_tank1, success);

   General_IO.Print_Success("Filling tank 2", success);

end Main;
