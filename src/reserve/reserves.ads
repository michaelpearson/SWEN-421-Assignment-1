with Pumps;
with Shared_Types;
use all type Pumps.Reserve_Sensor_States;

package Reserves with SPARK_Mode => On is
   type Reserve_Type is tagged private;

   function Make_Reserve(size : Shared_Types.Millilitre_Type; fuel : Shared_Types.Fuel_Type; current_fill : Shared_Types.Millilitre_Type) return Reserve_Type with
     Pre'Class => size >= current_fill,
     Post'Class => Make_Reserve'Result.Get_Current_Fill <= Make_Reserve'Result.Get_Reserve_Size;

   function Get_Fuel_Type(this : in Reserve_Type) return Shared_Types.Fuel_Type;

   function Get_Reserve_Size(this : in Reserve_Type) return Shared_Types.Millilitre_Type with Ghost;
   function Get_Current_Fill(this : Reserve_Type) return Shared_Types.Millilitre_Type with Ghost;

   -- Pump 1ml of fuel
   procedure Take_Fuel(this : in out Reserve_Type) with
     Pre'Class => this.Get_Current_Fill > 0,
     Post'Class => this.Get_Current_Fill < this'Old.Get_Current_Fill;

   function Get_Sensor_State(this : in Reserve_Type) return Pumps.Reserve_Sensor_States with
     Post'Class => (Get_Sensor_State'Result = Empty and this.Get_Current_Fill = 0) or (this.Get_Sensor_State = NotEmpty and this.Get_Current_Fill /= 0);

private
   type Reserve_Type is tagged record
      Fuel : Shared_Types.Fuel_Type;
      Size : Shared_Types.Millilitre_Type;
      Current_Fill : Shared_Types.Millilitre_Type;
   end record;

   function Get_Fuel_Type(this : Reserve_Type) return Shared_Types.Fuel_Type is (this.Fuel);
   function Get_Reserve_Size(this : Reserve_Type) return Shared_Types.Millilitre_Type is (this.Size);
   function Get_Current_Fill(this : Reserve_Type) return Shared_Types.Millilitre_Type is (this.Current_Fill);

   function Get_Sensor_State(this : in Reserve_Type) return Pumps.Reserve_Sensor_States is (if this.Current_Fill = 0 then Empty else NotEmpty);

end Reserves;
