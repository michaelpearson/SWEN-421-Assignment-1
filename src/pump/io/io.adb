with Pumps;

with Ada.Text_IO;
use Ada;

package body IO is
   procedure Print_Transition(from : in Pumps.Pump_States; to : in Pumps.Pump_States) is begin
      Text_IO.Put("Trnasition from: ");
      Text_IO.Put(from'Image);
      Text_IO.Put(", To: ");
      Text_IO.Put_Line(to'Image);
   end Print_Transition;

end IO;
