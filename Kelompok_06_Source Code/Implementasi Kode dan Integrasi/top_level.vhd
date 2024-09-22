library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--    use work.all; 

entity top_level is 
    port(
        clk, rst : in std_logic; 
        in_sel : in std_logic_vector (2 downto 0); -- mode
        inputSC : in std_logic_vector (18 downto 0); 
        inputT : in std_logic_vector (8 downto 0); 
        inputAS : in std_logic_vector  (26 downto 0);
        inputAC : in std_logic_vector (26 downto 0);
        resultS : buffer std_logic_vector (33 downto 0); 
        resultC : buffer std_logic_vector (33 downto 0); 
        resultT : out std_logic_vector (26 downto 0); 
        resultAS : out std_logic_vector (26 downto 0);
        resultAC : out std_logic_vector (26 downto 0);
        signedResult : buffer std_logic
    ); 
end top_level; 

architecture top_level_arc of top_level is

component kuadrandetect is 
    port(
    degree   : in std_logic_vector (18 downto 0);
    kuadran  : out std_logic_vector (1 downto 0);
    newdegree: out std_logic_vector (16 downto 0)
);
end component;

component sinus is
    Port (
        clock   : in STD_LOGIC;  				         -- Clock input
        reset : in STD_LOGIC;        					 -- Reset input
        in_angle : in STD_LOGIC_VECTOR(16 downto 0);     -- Input sudut
        sin_result : out STD_LOGIC_VECTOR(33 downto 0);  -- hasil perhitungan sin yang sudah di slice  
        iter : out std_logic_vector (3 downto 0) 		 -- untuk iterasi
    );
end component;

component cosinus is
    Port (
        clock   : in STD_LOGIC;  				         -- Clock input
        reset : in STD_LOGIC;        					 -- Reset input
        in_angle : in STD_LOGIC_VECTOR(16 downto 0);     -- Input sudut  
        cos_result : out STD_LOGIC_VECTOR(33 downto 0);  -- hasil perhitungan cos yang sudah di slice
        iter : out std_logic_vector (3 downto 0) 		 -- untuk iterasi
    );
end component;

component arcsin is										-- komponen arcsin
	port ( clk : in std_logic;
		   rst : in std_logic;
		   y_in : in std_logic_vector (26 downto 0);
		   sudut : out std_logic_vector (26 downto 0));   
end component;

component arccos is
	port ( clk : in std_logic; -- clock
		   rst : in std_logic; -- reset
		   x_in : in std_logic_vector (26 downto 0); -- input nilai, arcsin(x_in)
		   sudut : out std_logic_vector (26 downto 0)); -- output sudut, arcsin(x_in) = sudut
end component;
		

component tan is                                         --komponen operasi tangen
    port (
		clock : std_logic; 
		reset : std_logic;
        sudut : in std_logic_vector(8 downto 0);
        output : out std_logic_vector(26 downto 0)
    );
end component;

signal in_degree      : std_logic_vector (16 downto 0);  -- input sin cos
signal in_degreeT     : std_logic_vector (8 downto 0); -- input tan
signal r_tangen       : std_logic_vector (26 downto 0);
signal kuadran_signal : std_logic_vector (1 downto 0);
signal r_sinus        : std_logic_vector (33 downto 0); 
signal r_cosinus      : std_logic_vector (33 downto 0);
signal r_arcsinus     : std_logic_vector (26 downto 0); -- output arcsinus
signal r_arccos       : std_logic_vector (26 downto 0);

begin
    -- Alur data 
    kuadran_Detect : kuadrandetect port map (
        degree => inputSC, 
        kuadran => kuadran_signal, 
        newdegree => in_degree 
    ); 

    x_sinus : sinus port map (
        in_angle => in_degree, 
        sin_result => r_sinus,  
        clock => clk, 
        reset => rst
    ); 
    
    x_cosinus : cosinus port map (
        in_angle => in_degree, 
        cos_result => r_cosinus,  
        clock => clk, 
        reset => rst
    ); 

    x_tan : tan port map (
		clock => clk, 
		reset => rst,
        sudut => inputT, 
        output => r_tangen
    ); 
    
    x_arcsin : arcsin port map (
		clk => clk,
		rst => rst,
		y_in => inputAS,
		sudut => r_arcsinus
	);
	
	x_arccos : arccos port map (
		clk => clk,
		rst => rst,
		x_in => inputAC,
		sudut => r_arccos
	);

    process (in_sel, r_sinus, r_cosinus, r_tangen)
    begin
        if in_sel = "000" then -- sinus 
            if kuadran_signal = "10" or kuadran_signal  = "11" then 
                signedResult <= '1'; 
                resultS <= r_sinus; 
            else
                resultS <= r_sinus;
                signedResult <= '0';
            end if;
        elsif in_sel = "001" then -- cosinus
            if kuadran_signal = "01" or kuadran_signal = "10" then
                signedResult <= '1'; 
                resultC <= r_cosinus;
            else
                resultC <= r_cosinus;
                signedResult <= '0';
            end if; 
        elsif in_sel= "010" then -- tan
            resultT <= r_tangen;
        elsif in_sel= "011" then
            resultAS <= r_arcsinus;	
        elsif in_sel = "100" then 
			resultAC <= r_arccos; 
        else
            resultS <= (others => '0');
            resultC <= (others => '0');
            resultT <= (others => '0');
            --resultASAC <= (others => '0');
        end if;
    end process;
end top_level_arc;