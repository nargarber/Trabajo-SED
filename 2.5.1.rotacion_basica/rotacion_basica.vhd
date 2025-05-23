library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rotacion is
        GENERIC (
            N20: INTEGER := 20   -- contador que fija el tiempo de iluminaci�n de cada display
        );     
    Port ( clk,reset       : in  STD_LOGIC;
           digit_rota      : out STD_LOGIC_VECTOR (3 downto 0)
         );
end rotacion;

architecture rotacion_arq of rotacion is
    signal contador_rotacion : unsigned(N20-1 downto 0) := (others => '1');  -- unsigned(19 downto 0)
    SIGNAL rotacion_selecc : UNSIGNED(1 DOWNTO 0);
    signal fin_rotacion : std_logic;

begin
	
   -- proceso para darle valores (asignar) la se�al 'contador_rotacion' 
   --Tambien se gestiona aqu� el reset as�ncrono
   process(clk, reset)
   begin
   	--Para evitar latches
   	contador_rotacion <= contador_rotacion;
   	
   	if(reset = '1') then
   		contador_rotacion <= (others => '0');
   		fin_rotacion <= '0';
   		
        elsif (rising_edge(clk)) then
        	
        	contador_rotacion <= contador_rotacion + 1;
        	
		--Esto hay que ver si se puede poner de una forma m�s mona realmente estamos viendo si en el siguiente ya desborda       
        	if((contador_rotacion + 1) = 0) then 
        		fin_rotacion <= '1';	
        	else
   			fin_rotacion <= '0';     	
        	end if;	
        end if;
   end process;
  
   
   -- se�al auxiliar con los dos bits m�s significativos del contador
   rotacion_selecc(1 DOWNTO 0) <=  contador_rotacion( (N20-1) downto (N20-2) );   

   -- Proceso para asignar la salida 'digit_rota[]'
   PROCESS (rotacion_selecc)  
   BEGIN
	
        case rotacion_selecc is
            when "00" =>  digit_rota <= "0001";
            when "01" =>  digit_rota <= "0010";
            when "10" =>  digit_rota <= "0100";
            when "11" =>  digit_rota <= "1000";
            when others =>  digit_rota <= "1111";             
        end case;

    END PROCESS;
	
end rotacion_arq;





