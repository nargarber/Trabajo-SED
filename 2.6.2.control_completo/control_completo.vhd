
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
        fin_parpadeo    : in  STD_LOGIC;
        ini_parpadeo    : out  STD_LOGIC;
        enable_contador : out STD_LOGIC_VECTOR (3 downto 0); 
        contador_activo : out STD_LOGIC_VECTOR (3 downto 0)
    );
end control;

architecture control_arq of control is
    signal regDesplazaContadorActivo : std_logic_vector(3 downto 0);
    TYPE ESTADOS IS (reposo, izquierda_derecha_enable, espera_boton_pulsado, arriba_abajo_enable, parpadeando);
    SIGNAL estado_s, estado_c : ESTADOS;
begin
    -- Solo esta asignación externa, que conecta la señal interna a la salida
    contador_activo <= regDesplazaContadorActivo;

    PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            estado_s <= reposo;
            regDesplazaContadorActivo <= "1000";
        
        ELSIF (rising_edge(clk)) THEN
            estado_s <= estado_c;

            IF (estado_s = izquierda_derecha_enable) THEN
                IF (izquierda = '1') THEN
                    regDesplazaContadorActivo <= regDesplazaContadorActivo(2 downto 0) & regDesplazaContadorActivo(3);
                ELSIF (derecha = '1') THEN
                    regDesplazaContadorActivo <= regDesplazaContadorActivo(0) & regDesplazaContadorActivo(3 downto 1);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    PROCESS (estado_s, arriba, abajo, derecha, izquierda, fin_parpadeo)
    BEGIN
        -- Valores por defecto
        estado_c        <= estado_s;
        enable_contador <= "0000";
        ini_parpadeo    <= '0';

        CASE estado_s IS
            WHEN reposo =>
                IF (derecha = '1' OR izquierda = '1') THEN
                    estado_c <= izquierda_derecha_enable;
                ELSIF (arriba = '1' OR abajo = '1') THEN
                    estado_c <= arriba_abajo_enable;
                END IF;

            WHEN izquierda_derecha_enable =>
                estado_c <= espera_boton_pulsado;

            WHEN espera_boton_pulsado =>
                IF (arriba = '1' OR abajo = '1' OR izquierda = '1' OR derecha = '1') THEN
                    estado_c <= espera_boton_pulsado;
                ELSE
                    estado_c <= parpadeando;
                END IF;

            WHEN arriba_abajo_enable =>
                enable_contador  <= regDesplazaContadorActivo;
                estado_c <= espera_boton_pulsado;

            WHEN parpadeando =>
                ini_parpadeo <= '1';

                IF (izquierda = '1' OR derecha = '1') THEN
                    estado_c <= izquierda_derecha_enable;
                ELSIF (arriba = '1' OR abajo = '1') THEN
                    estado_c <= arriba_abajo_enable;
                ELSIF (fin_parpadeo = '1') THEN
                    ini_parpadeo <= '0';
                    estado_c <= reposo;
                END IF;

            WHEN OTHERS =>
                estado_c <= reposo;
        END CASE;
    END PROCESS;

end control_arq;

