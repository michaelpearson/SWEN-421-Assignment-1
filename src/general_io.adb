with Ada.Text_IO;

package body General_IO is

   procedure Print_Success(operation_name : String; success : Boolean) is begin
      Ada.Text_IO.Put("""");
      Ada.Text_IO.Put(operation_name);
      Ada.Text_IO.Put(""" was a ");
      Ada.Text_IO.Put_Line(if success then "success" else "failure");
   end Print_Success;

   procedure Print_Pumping is begin
      Ada.Text_IO.Put_Line("Pumping 1ml");
   end Print_Pumping;

   procedure Print_Fuel_Amount(fuel : Fuel_Type; amount : Shared_Types.Millilitre_Type) is begin
      Ada.Text_IO.Put(amount'Image);
      Ada.Text_IO.Put("mL of ");
      Ada.Text_IO.Put(fuel'Image);
      Ada.Text_IO.Put_Line(" remaning");
   end Print_Fuel_Amount;

end General_IO;
