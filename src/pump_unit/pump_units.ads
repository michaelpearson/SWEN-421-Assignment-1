with Shared_Types; use Shared_Types;
with Pumps; use Pumps;
with Reserves; use Reserves;
with Tank;
use all type Shared_Types.Fuel_Type;

package Pump_Units with SPARK_Mode => On is
   type Pump_Unit_Type is tagged private;

   type Pump_Array_Type is array(Shared_Types.Fuel_Type) of Pumps.Pump_Type;
   type Reserve_Array_Type is array(Shared_Types.Fuel_Type) of Reserves.Reserve_Type;

   function Make_Pump_Unit return Pump_Unit_Type with
     Post'Class => (for all p of Make_Pump_Unit'Result.Get_Pumps => p.Reserve_State = NotEmpty);

   procedure Fill_Tank(this : in out Pump_Unit_Type; tank_to_fill : in out Tank.Tank_Type; successful : out Boolean) with
     Post'Class => successful = false Or (successful And (tank_to_fill.Is_Tank_Full Or this.Get_Reserve(tank_to_fill.Get_Fuel_Type).Get_Sensor_State = Empty));



   function Get_Pumps(this : Pump_Unit_Type) return Pump_Array_Type;
   function Get_Reserve(this : Pump_Unit_Type; fuel : Fuel_Type) return Reserve_Type;
private

   type Pump_Unit_Type is tagged record
      pumps : Pump_Array_Type := (Make_Pump, Make_Pump, Make_Pump);
      reserves : Reserve_Array_Type := (Make_Reserve(30, Petrol95, 15),
                                        Make_Reserve(30, Petrol98, 15),
                                        Make_Reserve(30, Diesel, 15));
   end record;

   function Get_Pumps(this : Pump_Unit_Type) return Pump_Array_Type is (this.pumps);

   function Get_Reserve(this : Pump_Unit_Type; fuel : Fuel_Type) return Reserve_Type is (this.reserves(fuel));

end Pump_Units;
