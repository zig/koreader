
function get_battery_level()
   local batt
   if not pcall(
      function()
	 -- kindle touch
	 --[[
	 TODO different model might use a different path, several solutions :
	    - find the path through kdb (eg. kdb get system/daemon/powerd/sys_battery_capacity)
	    - communicate with powerd via dbus to directly ask for battery level
         --]]
         batt = io.lines("/sys/devices/system/yoshi_battery/yoshi_battery0/battery_capacity")()
      end) and not pcall(
      function() 
	 -- standard linux
	 local now = tonumber(io.lines("/sys/class/power_supply/BAT0/energy_now")())
	 local full = tonumber(io.lines("/sys/class/power_supply/BAT0/energy_full")())
	 batt = string.format("%d%%", now * 100 / full)
      end) then
      batt = "nobat"
   end

   return batt
end
