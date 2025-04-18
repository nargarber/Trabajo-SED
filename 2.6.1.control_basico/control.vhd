library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control is
    Port ( 
        clk       : in STD_LOGIC;
        reset     : in STD_LOGIC;
        arriba    : in STD_LOGIC;
        abajo     : in STD_LOGIC;
        izquierda : in STD_LOGIC;
        derecha   : in STD_LOGIC;
     --   fin_parpadeo    : in  STD_LOGIC;
     --   ini_parpadeo    : out  STD_LOGIC;
        enable_contador : out STD_LOGIC_VECTOR (3 downto 0);                     -- un pulso de 1 ciclo de reloj para que cuente solo 1
        contador_activo : out STD_LOGIC_VECTOR (3 downto 0)
    );
end control;

architecture control_arq of control is
    signal regDesplazaContadorActivo : std_logic_vector(3 downto 0);
    TYPE ESTADOS IS (reposo, izquierda_derecha_enable,espera_boton_pulsado, arriba_abajo_enable);  -- , parpadeando);
    SIGNAL estado_s, estado_c : ESTADOS;
    
begin
    contador_activo <= regDesplazaContadorActivo;

    PROCESS (clk,reset)
    BEGIN
        IF (reset='1') THEN                 -- Reset activo a nviel alto
            estado_s  <=reposo;
            regDesplazaContadorActivo <= "1000";
            enable_contador <= (others => '0');
            
        ELSIF (rising_edge(clk)) THEN  
            estado_s  <= estado_c;	
            enable_contador <= (others => '0');
            
            -- actualiza regDesplazaContadorActivo para que rote a derecha o izquierda
            IF (estado_s = izquierda_derecha_enable) THEN
		if(izquierda = '1') then
			regDesplazaContadorActivo <= regDesplazaContadorActivo(2 downto 0) & regDesplazaContadorActivo(3);
		elsif(derecha = '1') then
			regDesplazaContadorActivo <= regDesplazaContadorActivo(0) & regDesplazaContadorActivo(3 downto 1);
		end if;
            END IF;
            
            if ( estado_s = arriba_abajo_enable) then
            	enable_contador <= regDesplazaContadorActivo;
            end if;       
                   
        END IF;
    END PROCESS;
    
    
    
    PROCESS (estado_s,arriba,abajo,derecha,izquierda) --,fin_parpadeo)
    BEGIN
        -- ----------------------------------
        -- Valores por defecto
        -- ----------------------------------
        estado_c        <= estado_s;
        enable_contador <= "0000";  -- Se activará en un estado transitorio de un ciclo de reloj
      --  ini_parpadeo    <= '0';   -- no se usa en la versi n basica
        -- ----------------------------------

        CASE estado_s IS
            WHEN reposo =>
                   if(derecha = '1' OR izquierda = '1') then
                   	estado_c <= izquierda_derecha_enable;
                   elsif(arriba = '1' OR abajo = '1') then
                   	estado_c <= arriba_abajo_enable;
                   else
                   	estado_c <= reposo;
                   end if;
                   
            WHEN izquierda_derecha_enable =>
            
		estado_c <= espera_boton_pulsado;
		
            WHEN espera_boton_pulsado =>
                 if (arriba = '1' OR abajo = '1' OR arriba = '1' OR abajo = '1') then
                 	estado_c <= espera_boton_pulsado;
                 else
                 	estado_c <= reposo;
                 end if;
                                          
            WHEN arriba_abajo_enable =>
            
                  estado_c <= espera_boton_pulsado;
                  
            WHEN OTHERS =>
            	estado_c <= estado_c;

        END CASE;
   END PROCESS;
    
end control_arq;








