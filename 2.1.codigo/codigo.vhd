library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity codigo is
    Port ( 
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           resultado : out STD_LOGIC);
end codigo;

architecture codigo_arq of codigo is
begin
--Resultado sólo será 1 si se cumple que los dígitos sean lo que queramos
resultado <= '1' when (digit3 = "0100" and -- digit3 = 4
                       digit2 = "0011" and -- digit2 = 3
                       digit1 = "0010" and -- digit1 = 2
                       digit0 = "0001") -- digit0 = 1
                       else '0';
end codigo_arq;





