library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rotacion is
        GENERIC (
            N20: INTEGER := 20;   -- 20 bits para el contador de rotación
            N10: INTEGER := 10;   -- 10 bits para el contador de parpadeo
            NP: INTEGER := 2   -- Constante para el cálculo de parpadeos
        );     
    Port ( clk,reset       : in  STD_LOGIC;
           contador_activo: in std_logic_vector(3 downto 0);
           ini_parpadeo: in std_logic;
           fin_parpadeo: out std_logic;
           digit_rota      : out STD_LOGIC_VECTOR (3 downto 0)
         );
end rotacion;

architecture rotacion_arq of rotacion is
    signal contador_rotacion : unsigned(N20-1 downto 0) := (others => '1');  -- unsigned(19 downto 0)
    signal contador_parpadeo : unsigned(N10-1 downto 0) := (others => '1');  -- unsigned(9 downto 0)
    SIGNAL rotacion_selecc : UNSIGNED(1 DOWNTO 0);
    signal fin_rotacion : std_logic;

begin
	
   -- proceso para darle valores (asignar) la señal 'contador_rotacion' 
   --Tambien se gestiona aquí el reset asíncrono
   process(clk, reset, ini_parpadeo, fin_rotacion)
   begin
   	--Para evitar latches
   	contador_rotacion <= contador_rotacion;
   	contador_parpadeo <= contador_parpadeo;
   	
   	if(reset = '1') then
   		contador_rotacion <= (others => '0');
   		contador_parpadeo <= (others => '0');
   		fin_rotacion <= '0';
   		fin_parpadeo <= '0';
   		
        elsif (rising_edge(clk)) then
        	
        	contador_rotacion <= contador_rotacion + 1;
        	
		--Esto hay que ver si se puede poner de una forma más mona realmente estamos viendo si en el siguiente ya desborda       
        	if((contador_rotacion + 1) = 0) then 
        		fin_rotacion <= '1';	
        	else
   			fin_rotacion <= '0';     	
        	end if;
        	
        	if(contador_parpadeo(N10-1) = '0') then
   			fin_parpadeo <= '0';
   			
   			if(fin_rotacion = '1'  AND ini_parpadeo = '1') then
   				contador_parpadeo <= contador_parpadeo + 1;
   			end if;
   		else
   			fin_parpadeo <= '1';
   		end if;		
        end if;
   end process;

   
   -- señal auxiliar con los dos bits más significativos del contador
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







