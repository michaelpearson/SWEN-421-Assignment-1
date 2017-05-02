with Pumps;
with Shared_Types;

package Reserves with SPARK_Mode => On is
   type Reserve_Type is tagged private;

   function Make_Reserve(size : Shared_Types.Millilitre_Type; fuel : Shared_Types.Fuel_Type; current_fill : Shared_Types.Millilitre_Type) return Reserve_Type;

   function Get_Fuel_Type(this : in Reserve_Type) return Shared_Types.Fuel_Type;
   function Get_Reserve_Size(this : in Reserve_Type) return Shared_Types.Millilitre_Type;

   procedure Take_Fuel(this : in out Reserve_Type; amount_to_take : in Shared_Types.Millilitre_Type; amount_taken : out Shared_Types.Millilitre_Type; sensor_state : out Pumps.Reserve_Sensor_States);
private
   type Reserve_Type is tagged record
      Fuel : Shared_Types.Fuel_Type;
      Size : Shared_Types.Millilitre_Type;
      Current_Fill : Shared_Types.Millilitre_Type;
   end record;

   function Get_Fuel_Type(this : Reserve_Type) return Shared_Types.Fuel_Type is (this.Fuel);
   function Get_Reserve_Size(this : Reserve_Type) return Shared_Types.Millilitre_Type is (this.Size);

end Reserves;
