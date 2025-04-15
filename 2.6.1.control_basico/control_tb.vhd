--- **********************************************************************
-- LIBRERIAS
-- **********************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;



-- **********************************************************************
-- ENTIDAD     (entradas/salidas, el fichero de simulación no tiene)
-- **********************************************************************
ENTITY test_control IS
END    test_control;



-- **********************************************************************
-- ARQUITECTURA   (descripción de los estímulos)
-- **********************************************************************
ARCHITECTURE test_control_arq OF test_control IS
    --Declaración de componentes
    COMPONENT control
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
    END COMPONENT;

    SIGNAL CLK,ARRIBA,ABAJO,IZQUIERDA,DERECHA,RESET: std_logic;                -- ,INI_PARPADEO,FIN_PARPADEO
    SIGNAL ENABLE_CONTADOR,CONTADOR_ACTIVO : std_logic_vector(3 downto 0);


constant ciclo: time := 10 ns;  -- hay que dejar un espacio entre 1 y ms

BEGIN
    -- ///////////////////////////////////////////////////////////////////////////////
    -- Se crea el componente U1 y se conecta a las señales internas de la arquitectura
    -- ///////////////////////////////////////////////////////////////////////////////
    U1: control PORT MAP(
           clk       => CLK,
           reset     => RESET,
           arriba    =>  ARRIBA,
           abajo     =>  ABAJO,
           izquierda =>  IZQUIERDA,
           derecha   =>  DERECHA,
       --    ini_parpadeo    =>  INI_PARPADEO,
       --    fin_parpadeo    =>  FIN_PARPADEO,
           enable_contador => ENABLE_CONTADOR,   -- un pulso de 1 ciclo de reloj para que cuente solo 1
           contador_activo  => CONTADOR_ACTIVO); 
                             

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
        RESET<= '1';     wait for 9*ciclo/4;     
        RESET<= '0';     wait;
    end process GenReset;

    -- ======================================================================
    -- Proceso para el resto de entradas; ENABLE_test
    -- ======================================================================
    tb: PROCESS
    BEGIN
        ARRIBA   <= '0';
        ABAJO    <= '0';
        DERECHA  <= '0';
        IZQUIERDA<= '0';
--        FIN_PARPADEO <= '0';
        wait for 13*ciclo/4;    
 
         -- Rellenar estímulos aquí
 
        wait;                  
    end process tb;

END test_control_arq;





































