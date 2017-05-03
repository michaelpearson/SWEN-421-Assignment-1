with Pumps;
with General_IO;
use all type Pumps.Reserve_Sensor_States;

package body Reserves with SPARK_Mode => On is

   function Make_Reserve(size : Shared_Types.Millilitre_Type; fuel : Shared_Types.Fuel_Type; current_fill : Shared_Types.Millilitre_Type) return Reserve_Type is
   begin
      return Reserve_Type'(Fuel         => fuel,
                           Size         => size,
                           Current_Fill => current_fill);
   end Make_Reserve;

   procedure Take_Fuel(this : in out Reserve_Type) is begin
      pragma Assert(this.Current_Fill > 0);
      if this.Current_Fill > 0 then
         this.Current_Fill := this.Current_Fill - 1;
      end if;
      General_IO.Print_Fuel_Amount(this.Fuel, this.Current_Fill);
   end Take_Fuel;

end Reserves;
