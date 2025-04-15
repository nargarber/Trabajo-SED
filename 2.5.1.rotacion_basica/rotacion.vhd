library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rotacion is
        GENERIC (
            N20: INTEGER := 20   -- contador que fija el tiempo de iluminación de cada display
        );     
    Port ( clk,reset       : in  STD_LOGIC;
           digit_rota      : out STD_LOGIC_VECTOR (3 downto 0)
         );
end rotacion;

architecture rotacion_arq of rotacion is
    signal contador_rotacion : unsigned(N20-1 downto 0) := (others => '1');  -- unsigned(19 downto 0)
    signal fin_rotacion      : std_logic;
    SIGNAL rotacion_selecc : UNSIGNED(1 DOWNTO 0);


begin

   -- proceso para darle valores (asignar) la señal 'contador_rotacion' 
   process(clk)
   begin
        if (rising_edge(clk)) then

        end if;
   end process;
   
   -- señal auxiliar con los dos bits más significativos del contador
   rotacion_selecc(1 DOWNTO 0) <=  contador_rotacion(contador_rotacion'high downto contador_rotacion'high-1);   

   -- Proceso para asignar la salida 'digit_rota[]'
   PROCESS (rotacion_selecc)  
   BEGIN
        case rotacion_selecc is
            when "00" =>               -- selecciona el d
               
               -- rellenar código aquí (similar a los apuntes)
                
        end case;
    END PROCESS;
	
end rotacion_arq;




