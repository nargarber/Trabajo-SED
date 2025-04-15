--- **********************************************************************
-- LIBRERIAS
-- **********************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;

-- **********************************************************************
-- ENTIDAD     (entradas/salidas, el fichero de simulación no tiene)
-- **********************************************************************
ENTITY test_proyecto IS
END    test_proyecto;

-- **********************************************************************
-- ARQUITECTURA   (descripción de los estímulos)
-- **********************************************************************
ARCHITECTURE test_proyecto_arq OF test_proyecto IS
    --Declaración de componentes
    COMPONENT proyecto
      generic(
         N21 : integer :=  21;    -- para simular: 2  (para rebotes)
         N20 : integer :=  20;    -- para simular: 2  (rotacion displays)
         N10 : integer :=  10;    -- para simular: 3  (tiempo de parpadeo)
         NP  : integer :=   4     -- para simular: 2
       );  
       Port ( 
           clk        : in  STD_LOGIC;
           reset      : in  STD_LOGIC;
           btn_up     : in  STD_LOGIC;
           btn_down   : in  STD_LOGIC;
           btn_left   : in  STD_LOGIC;
           btn_right  : in  STD_LOGIC;
           segments        : out STD_LOGIC_VECTOR (6 downto 0);
           digit_rota_n    : out STD_LOGIC_VECTOR (3 downto 0);
           contador_activo : out STD_LOGIC_VECTOR (3 downto 0);
           led0            : out STD_LOGIC
       );
    END COMPONENT;

    SIGNAL CLK,RESET,BTN_UP, BTN_DOWN,BTN_LEFT, BTN_RIGHT,LED0 : std_logic;
    SIGNAL DIGIT_ROTA_N,CONTADOR_ACTIVO : std_logic_vector(3 downto 0);
    SIGNAL SEGMENTS : std_logic_vector(6 downto 0);


constant ciclo: time := 10 ns;  -- hay que dejar un espacio entre 10 y ns

BEGIN
    -- ///////////////////////////////////////////////////////////////////////////////
    -- Se crea el componente U1 y se conecta a las señales internas de la arquitectura
    -- ///////////////////////////////////////////////////////////////////////////////
    U1: proyecto generic MAP(
         N21 => 2,    -- para simular: 2  (rebotes)
         N20 => 2,    -- para simular: 2  (rotacion)
         N10 => 3,    -- para simular: 3  (parpadeo)
         NP  => 2     -- para simular: 2
       )   
       PORT    MAP(
            clk        =>  CLK,
            reset      =>  RESET,
            btn_up     =>  BTN_UP,
            btn_down   =>  BTN_DOWN,
            btn_left   =>  BTN_LEFT,
            btn_right  =>  BTN_RIGHT,
            segments   =>  SEGMENTS,
            digit_rota_n    =>  DIGIT_ROTA_N,
            contador_activo =>  CONTADOR_ACTIVO,
            led0            =>  LED0 );

    -- ======================================================================
    -- Proceso de la entrada de reloj. Se ejecuta indefinidamente ya que no tiene "WAIT;"
    -- ======================================================================
    PROCESS
    BEGIN
        CLK <='0';    wait for ciclo/2;
        CLK <='1';    wait for ciclo/2;
    END PROCESS;

    GenReset: process
    begin
        RESET<= '1';     wait for 9*ciclo/4;     -- Nos situamos en el flanco de bajada del reloj
        RESET<= '0';     wait;
    end process GenReset;

    -- ======================================================================
    -- Proceso para el resto de entradas; ENABLE_test
    -- ======================================================================
    tb: PROCESS
    BEGIN
        BTN_UP    <= '0';
        BTN_DOWN  <= '0';
        BTN_LEFT  <= '0';
        BTN_RIGHT <= '0';
        wait for 9*ciclo/4;    -- deshabilitada la cuenta durante 2.5 ciclos
        
        wait for  20*ciclo;    -- deshabilitada la cuenta durante 2.5 ciclos
        BTN_UP    <= '1';
        wait for 10*ciclo;    -- deshabilitada la cuenta durante 2.5 ciclos
        BTN_UP    <= '0';

        wait for  30*ciclo;    -- deshabilitada la cuenta durante 2.5 ciclos
        BTN_LEFT    <= '1';
        wait for 10*ciclo;    -- deshabilitada la cuenta durante 2.5 ciclos
        BTN_LEFT    <= '0';

        wait for  30*ciclo;    -- deshabilitada la cuenta durante 2.5 ciclos
        BTN_UP    <= '1';
        wait for 10*ciclo;    -- deshabilitada la cuenta durante 2.5 ciclos
        BTN_UP    <= '0';

        wait;                  -- Espera indefinida con ENABLE_test='1'
    end process tb;

END test_proyecto_arq;





































