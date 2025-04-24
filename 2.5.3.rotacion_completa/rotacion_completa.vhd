library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rotacion is
    GENERIC (
        N20: INTEGER := 20;   -- 20 bits para el contador de rotación
        N10: INTEGER := 10;   -- 10 bits para el contador de parpadeo
        NP: INTEGER := 2      -- Constante para el cálculo de parpadeos
    );     
    Port ( 
        clk, reset           : in  STD_LOGIC;
        contador_activo      : in std_logic_vector(3 downto 0);
        ini_parpadeo         : in std_logic;
        fin_parpadeo         : out std_logic;
        digit_rota           : out STD_LOGIC_VECTOR (3 downto 0)
    );
end rotacion;

architecture rotacion_arq of rotacion is
    signal contador_rotacion     : unsigned(N20-1 downto 0) := (others => '1');  -- unsigned(19 downto 0)
    signal contador_parpadeo     : unsigned(N10-1 downto 0) := (others => '1');  -- unsigned(9 downto 0)
    signal rotacion_selecc       : UNSIGNED(1 DOWNTO 0);
    signal fin_rotacion          : std_logic;
    signal bit_parpadeo_prev     : std_logic := '0';
begin
	
    process(clk, reset)
    begin
        if reset = '1' then
            contador_rotacion   <= (others => '0');
            contador_parpadeo   <= (others => '0');
            fin_rotacion        <= '0';
            fin_parpadeo        <= '0';
            bit_parpadeo_prev   <= '0';

        elsif rising_edge(clk) then
            contador_rotacion <= contador_rotacion + 1;

            if (contador_rotacion + 1 = 0) then 
                fin_rotacion <= '1';	
            else
                fin_rotacion <= '0';     	
            end if;

            -- Pulso de un solo ciclo para fin_parpadeo
            if contador_parpadeo(N10-1) = '1' and bit_parpadeo_prev = '0' then
                fin_parpadeo <= '1';
            else
                fin_parpadeo <= '0';
            end if;

            -- Guardamos el valor anterior del bit más significativo
            bit_parpadeo_prev <= contador_parpadeo(N10-1);

            if contador_parpadeo(N10-1) = '0' then
                if fin_rotacion = '1' and ini_parpadeo = '1' then
                    contador_parpadeo <= contador_parpadeo + 1;
                end if;
            end if;
        end if;
    end process;

    -- señal auxiliar con los dos bits más significativos del contador
    rotacion_selecc <= contador_rotacion(N20-1 downto N20-2);   

    -- Proceso para asignar la salida 'digit_rota[]'
    process(rotacion_selecc)  
    begin
        case rotacion_selecc is
            when "00" =>  
                digit_rota <= "0001";
                if contador_activo = "0001" and ini_parpadeo = '1' and contador_parpadeo(contador_parpadeo'high-NP) = '0' and contador_parpadeo(N10-1) = '0' then
                    digit_rota <= (others => '0');
                end if;
            when "01" =>  
                digit_rota <= "0010";
                if contador_activo = "0010" and ini_parpadeo = '1' and contador_parpadeo(contador_parpadeo'high-NP) = '0' and contador_parpadeo(N10-1) = '0' then
                    digit_rota <= (others => '0');
                end if;            	
            when "10" =>  
                digit_rota <= "0100";
                if contador_activo = "0100" and ini_parpadeo = '1' and contador_parpadeo(contador_parpadeo'high-NP) = '0' and contador_parpadeo(N10-1) = '0' then
                    digit_rota <= (others => '0');
                end if;            	
            when "11" =>  
                digit_rota <= "1000";
                if contador_activo = "1000" and ini_parpadeo = '1' and contador_parpadeo(contador_parpadeo'high-NP) = '0' and contador_parpadeo(N10-1) = '0' then
                    digit_rota <= (others => '0');
                end if;           	
            when others =>  
                digit_rota <= "1111";             
        end case;
    end process;
	
end rotacion_arq;






