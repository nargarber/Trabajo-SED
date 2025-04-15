library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity proyecto is
     generic(
         N21 : integer :=  21;    -- para simular: 2  (para rebotes)
         N20 : integer :=  20;    -- para simular: 2  (rotacion displays)
         N10 : integer :=  10;    -- para simular: 3  (tiempo parpadeo)
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
end proyecto;




architecture proyecto_arq of proyecto is

    component rebotes is
        GENERIC (
            N21: INTEGER := 21
        );     
        Port ( clk : in STD_LOGIC;
               i   : in STD_LOGIC;
               o   : out STD_LOGIC);
    end component;

    signal UP_SIN_REBOTES    : std_logic := '0';
    signal DOWN_SIN_REBOTES  : std_logic := '0';
    signal LEFT_SIN_REBOTES  : std_logic := '0';
    signal RIGHT_SIN_REBOTES : std_logic := '0';


    component control is
        Port ( 
           clk,reset : in STD_LOGIC;
           arriba    : in STD_LOGIC;
           abajo     : in STD_LOGIC;
           izquierda : in STD_LOGIC;
           derecha   : in STD_LOGIC;
           fin_parpadeo    : in  STD_LOGIC;
           ini_parpadeo    : out  STD_LOGIC;
           enable_contador : out STD_LOGIC_VECTOR (3 downto 0);                     -- un pulso de 1 ciclo de reloj para que cuente solo 1
           contador_activo : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component rotacion is
        GENERIC (
            N20: integer := 20;
            N10: integer := 10;
            NP : integer := 3
        );     
    Port ( 
           clk,reset       : in  STD_LOGIC;
           contador_activo : in  STD_LOGIC_VECTOR (3 downto 0);
           ini_parpadeo    : in  STD_LOGIC;
           fin_parpadeo    : out STD_LOGIC;
           digit_rota      : out STD_LOGIC_VECTOR (3 downto 0)
         );
    end component;


    signal DIGIT_ROTA,ENABLE_CONTADOR, DISPLAY_ACTIVO : STD_LOGIC_VECTOR (3 downto 0) ;    
    signal FIN_PARPADEO, INI_PARPADEO : std_logic;

    component contador is
    Port ( clk     : in STD_LOGIC;
           reset   : in STD_LOGIC;
           enable  : in STD_LOGIC;
           up,down : in STD_LOGIC;
           cuenta  : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal digit0 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal digit1 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal digit2 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal digit3 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

    component codigo is
    Port ( 
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           resultado : out STD_LOGIC);
    end component;

    component siete_seg is
        Port (  
               segments   : out STD_LOGIC_VECTOR (6 downto 0);
               digit_rota : in STD_LOGIC_VECTOR (3 downto 0);
               digit0     : in STD_LOGIC_VECTOR (3 downto 0);
               digit1     : in STD_LOGIC_VECTOR (3 downto 0);
               digit2     : in STD_LOGIC_VECTOR (3 downto 0);
               digit3     : in STD_LOGIC_VECTOR (3 downto 0));
    end component;

begin
    -- salidas
    digit_rota_n(0) <= not DIGIT_ROTA(0);
    digit_rota_n(1) <= not DIGIT_ROTA(1);
    digit_rota_n(2) <= not DIGIT_ROTA(2);
    digit_rota_n(3) <= not DIGIT_ROTA(3);
    
    contador_activo <= DISPLAY_ACTIVO;

i_rebotes_down:  rebotes GENERIC MAP (N21 => N21) port map ( clk => clk,  i => btn_down,  o => DOWN_SIN_REBOTES);
i_rebotes_up:    rebotes GENERIC MAP (N21 => N21) port map ( clk => clk,  i => btn_up,    o => UP_SIN_REBOTES);
i_rebotes_left:  rebotes GENERIC MAP (N21 => N21) port map ( clk => clk,  i => btn_left,  o => LEFT_SIN_REBOTES);
i_rebotes_right: rebotes GENERIC MAP (N21 => N21) port map ( clk => clk,  i => btn_right, o => RIGHT_SIN_REBOTES);




    

i_control: control Port map ( 
    clk => clk,
    reset => reset,
    arriba    => UP_SIN_REBOTES,
    abajo     => DOWN_SIN_REBOTES,
    derecha   => RIGHT_SIN_REBOTES,
    izquierda => LEFT_SIN_REBOTES,
    contador_activo => DISPLAY_ACTIVO,
    enable_contador => ENABLE_CONTADOR,       -- 4 contadores
    fin_parpadeo    => FIN_PARPADEO,
    ini_parpadeo    => INI_PARPADEO
    );         -- siete_seg

i_rotacion: rotacion GENERIC MAP (N20 => N20, N10 => N10, NP => NP)Port map ( 
    clk => clk,
    reset => reset,
    fin_parpadeo    => FIN_PARPADEO,
    ini_parpadeo    => INI_PARPADEO,
    contador_activo => DISPLAY_ACTIVO,
    digit_rota      => DIGIT_ROTA);         -- siete_seg


i_contador0: contador port map (
    clk     => clk,
    reset   => reset,
    enable  => ENABLE_CONTADOR(0),
    up      => UP_SIN_REBOTES,
    down    => DOWN_SIN_REBOTES,
    cuenta  => digit0);

i_contador1: contador port map (
    clk     => clk,
    reset   => reset,
    enable  => ENABLE_CONTADOR(1),
    up      => UP_SIN_REBOTES,
    down    => DOWN_SIN_REBOTES,
    cuenta  => digit1);

i_contador2: contador port map (
    clk     => clk,
    reset   => reset,
    enable  => ENABLE_CONTADOR(2),
    up      => UP_SIN_REBOTES,
    down    => DOWN_SIN_REBOTES,
    cuenta  => digit2);

i_contador3: contador port map (
    clk     => clk,
    reset   => reset,
    enable  => ENABLE_CONTADOR(3),
    up      => UP_SIN_REBOTES,
    down    => DOWN_SIN_REBOTES,
    cuenta  => digit3);

i_codigo: codigo Port map ( 
    digit0 => digit0,
    digit1 => digit1,
    digit2 => digit2,
    digit3 => digit3,
    resultado => led0);

i_siete_seg: siete_seg Port map ( 
        digit0     => digit0,
        digit1     => digit1,
        digit2     => digit2,
        digit3     => digit3,
        segments   => segments,
        digit_rota => DIGIT_ROTA);

end proyecto_arq;






