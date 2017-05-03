with Shared_Types;
use Shared_Types;

package General_IO with SPARK_Mode => On is

   procedure Print_Success(operation_name : String; success : Boolean);

   procedure Print_Pumping;

   procedure Print_Fuel_Amount(fuel : Fuel_Type; amount : Shared_Types.Millilitre_Type);

end General_IO;
