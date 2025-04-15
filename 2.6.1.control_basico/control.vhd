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
            
        ELSIF (rising_edge(clk)) THEN  
            estado_s  <= estado_c;

           
            -- actualiza regDesplazaContadorActivo para que rote a derecha o izquierda
            IF xxx THEN

            END IF;
                   
                   
        END IF;
    END PROCESS;
    
    
    
    PROCESS (estado_s,arriba,abajo,derecha,izquierda,fin_parpadeo)
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
                   
            WHEN izquierda_derecha_enable =>

            WHEN espera_boton_pulsado =>
                                          
            WHEN arriba_abajo_enable =>
                  
            WHEN OTHERS =>

        END CASE;
   END PROCESS;
    
end control_arq;







