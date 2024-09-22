-- library
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic;
use ieee.std_logic_arith.all;

-- entity
entity ContohUART is
	port(
		clk 			: in std_logic;
		rst_n 			: in std_logic;
		
-- paralel part
		button 			: in std_logic;
		Seven_Segment	: out std_logic_vector(7 downto 0) ;
		Digit_SS		: out std_logic_vector(3 downto 0) ;
		
-- serial part
		rs232_rx 		: in std_logic;
		rs232_tx 		: out std_logic
	
	);
End ContohUART;

Architecture RTL of ContohUART is

	Component my_uart_top is
	port(
			clk 			: in std_logic;
			rst_n 			: in std_logic;
			send 			: in std_logic;
			send_data		: in std_logic_vector(7 downto 0) ;
			receive 		: out std_logic;
			receive_data	: out std_logic_vector(7 downto 0) ;
			rs232_rx 		: in std_logic;
			rs232_tx 		: out std_logic
	);
	end Component;
	
	Component ASCII_to_BCD is
	port(
			input_ascii		: in std_logic_vector(7 downto 0);
			output_bcd		: out std_logic_vector(3 downto 0)
	);
	end Component;
	
	Component BCD_to_ASCII is
	port(
			input_bcd		: in std_logic_vector(3 downto 0);
			output_ascii	: out std_logic_vector(7 downto 0)
	);
	end Component;

	signal send_data,receive_data	: std_logic_vector(7 downto 0);
	signal receive		: std_logic;
	signal receive_c	: std_logic;
	signal regis_huruf1	: std_logic_vector(7 downto 0);			-- huruf S, C, A, atau T
	signal regis_huruf2	: std_logic_vector(7 downto 0);			-- huruf S, C, (untuk Arc sin dan Arc cos)
	signal regis_angka1	: std_logic_vector(7 downto 0);			-- angka digit 1
	signal regis_angka2	: std_logic_vector(7 downto 0);		    -- angka digit 2
	signal regis_angka3	: std_logic_vector(7 downto 0);         -- angka digit 3
	signal untukconvert : std_logic_vector(7 downto 0); 	    -- untuk dikonversi dari ascii ke bcd
	signal hasilconvert : std_logic_vector(7 downto 0);         -- untuk hasil konversi bcd ke ascii
	signal convasciibcd : std_logic_vector(3 downto 0);
	signal convbcdascii : std_logic_vector(3 downto 0);
	
begin

	UART: my_uart_top 
	port map (
			clk 			=> clk,
			rst_n 			=> rst_n,
			send 			=> button,
			send_data		=> send_data,
			receive 		=> receive,
			receive_data	=> receive_data,
			rs232_rx 		=> rs232_rx,
			rs232_tx 		=> rs232_tx
	);
	
	konversi : ASCII_to_BCD
	port map (
			input_ascii		=> untukconvert,
			output_bcd		=> convasciibcd
	);
	
	converted : BCD_to_ASCII
	port map (
			input_ascii		=> hasilconvert,
			output_bcd		=> convbcdascii
	);
	
	send_data <= "01010101";
	

	
	Process(clk)
	variable count : std_logic_vector (3 downto 0);
	begin
		if ((clk = '1') and clk'event) then
			receive_c <= receive;
			if ((receive = '0') and (receive_c = '1'))then
				if count = 1 then
					regis_huruf1 <= recieve_data;					-- untuk huruf pertama
				elsif count = 2 then
					regis_huruf2 <= recieve_data;					-- untuk huruf kedua 
				elsif count = 3 then
					regis_angka1 <= recieve_data;					-- untuk angka digit pertama
				elsif count = 4 then
					regis_angka2 <= recieve_data; 					-- untuk angka digit kedua
				elsif count = 5 then
					regis_angka3 <= recieve_data;					-- untuk angka digit ketiga
				end if;
				count := count + 1;
				
				untukconvert <= regis_huruf1;
				untukconvert <= regis_huruf2;
				untukconvert <= regis_angka1;
				untukconvert <= regis_angka2;
				untukconvert <= regis_angka3;
			end if;
			if (receive = '1') then
				seven_segment <= receive_data;
			end if;
		end if;
	end process;

Process(clk)				           -- process mengirim data
 variable count2 : std_logic_vector (3 downto 0);
 begin
  if ((clk = '1') and clk'event) then
    if count2 = 1 then
        send_data <= hasil_tanda ;     -- untuk tanda
    elsif count2 = 2 then
        send_data <= hasil_angka1;     -- untuk angka digit pertama 
    elsif count2 = 3 then
        send_data <= hasil_angka2;     -- untuk angka digit kedua
    elsif count2 = 4 then
        send_data <= hasil_angka3;     -- untuk angka digit ketiga
    elsif count2 = 5 then
        send_data <= separatordesimal;     -- untuk separator desimal "."
    elsif count2 = 6 then
        send_data <= hasil_desimal1;     -- untuk angka desimal pertama
    elsif count2 = 7 then
        send_data <= hasil_desimal2;     -- untuk angka digit kedua
    elsif count2 = 7 then
        send_data <= hasil_desimal3;     -- untuk angka digit ketiga
    end if;
    count2 := count2 + 1;
     
   end if;
    seven_segment <= receive_data;
   end if;
  end if;
 end process;
	Digit_SS <= "0101";
	
end architecture;