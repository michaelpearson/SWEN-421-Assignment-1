with Pumps;
use all type Pumps.Reserve_Sensor_States;

package body Reserves with SPARK_Mode => On is

   function Make_Reserve(size : Shared_Types.Millilitre_Type; fuel : Shared_Types.Fuel_Type; current_fill : Shared_Types.Millilitre_Type) return Reserve_Type is
   begin
      return Reserve_Type'(Fuel         => fuel,
                           Size         => size,
                           Current_Fill => current_fill);
   end Make_Reserve;

   procedure Take_Fuel(this : in out Reserve_Type; amount_to_take : in Shared_Types.Millilitre_Type; amount_taken : out Shared_Types.Millilitre_Type; sensor_state : out Pumps.Reserve_Sensor_States) is

   begin
      if this.Current_Fill < amount_to_take then
         amount_taken := this.Current_Fill;
         sensor_state := Empty;
      else
         amount_taken := amount_to_take;
         sensor_state := NotEmpty;
      end if;
      this.Current_Fill := this.Current_Fill - amount_taken;
   end Take_Fuel;


end Reserves;
