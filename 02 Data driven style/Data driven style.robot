*** Settings ***
Documentation    Example of morse transmitter test
...
...              Test Cases Author: Kasperi Kiviluoma
...
...              Change this example to use data driven style 
...              Test with different texts and speeds
Test Template    Send morse
Library          MorseDecoderLibrary.py

*** Test Cases ***             Speed    Text                                                Expected speed    Expected text
Hello world                    50       hello world                                         50                HELLO WORLD
						       100      HELLO WORLD                                         100               HELLO WORLD
A to z                         200      abcdefghijklmnopqrstuvwxyz                          200               ABCDEFGHIJKLMNOPQRSTUVWXYZ
                               200      ABCDEFGHIJKLMNOPQRSTUVWXYZ                          200               ABCDEFGHIJKLMNOPQRSTUVWXYZ
Numbers 0-9                    100      0123456789                                          100               0123456789
Random special characters      200      äöå^~¨'-_.,:;<>|=?""@£$€{{[]}}                      200               XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Multiple words                 250      Hello, What is your name and where are you from?    250               HELLOX WHAT IS YOUR NAME AND WHERE ARE YOU FROMX
Speed tests                    10       hello                                               10                HELLO
							   166      hello                                               166               HELLO
		                       500      hello                                               500               HELLO
Expected speed fail            100      Hello                                               101               HELLO
#Expected text fail            100      "Hello, World!”                                     100               XHELLOX WORLDX

*** Keywords ***
Send morse
	[Arguments]        ${speed}             ${text}    ${expected_speed}    ${expected_text}    
	Set speed          ${speed}
	Send text          ${text}
	Speed should be    ${expected_speed}
	Text should be     ${expected_text}