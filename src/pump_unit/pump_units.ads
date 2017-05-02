with Shared_Types;
with Pumps; use Pumps;
with Reserves; use Reserves;
with Tank;
use all type Shared_Types.Fuel_Type;

package Pump_Units with SPARK_Mode => On is
   type Pump_Unit_Type is tagged private;

   function Make_Pump_Unit return Pump_Unit_Type;

   procedure Fill_Tank(this : in out Pump_Unit_Type; tank_to_fill : in out Tank.Tank_Type; successful : out Boolean);
   procedure Fill_Tank_To(this : Pump_Unit_Type; tank_to_fill : Tank.Tank_Type; amount : Shared_Types.Millilitre_Type);

private

   type Pump_Array_Type is array(Shared_Types.Fuel_Type) of aliased Pumps.Pump_Type;
   type Reserve_Array_Type is array(Shared_Types.Fuel_Type) of aliased Reserves.Reserve_Type;

   type Pump_Unit_Type is tagged record
      pumps : Pump_Array_Type := (Make_Pump, Make_Pump, Make_Pump);
      reserves : Reserve_Array_Type := (Make_Reserve(1000 * 10, Petrol95, 1000 * 10),
                                        Make_Reserve(1000 * 10, Petrol98, 1000 * 10),
                                        Make_Reserve(1000 * 10, Diesel, 1000 * 10));
   end record;

end Pump_Units;
