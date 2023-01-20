*** Settings ***
Documentation    Resource file for Morse.robot
...              Author: Kasperi Kiviluoma
Library          MorseDecoderLibrary.py           ${SENDER_COM}    ${DECODER_COM}

*** Variables ***
${SENDER_COM} =     COM1
${DECODER_COM} =    COM2

*** Keywords ***
Text only
	[Arguments]        ${speed}            ${text}    ${expected_text}    
	Set speed          ${speed}
	Send text          ${text}
	Speed should be    ${speed}
	Text should be     ${expected_text}

Text and relaxed speed
	[Documentation]            To pass text must match and speed must be within +-10% of expected speed
	[Arguments]                ${speed}             ${text}    ${expected_speed}    ${expected_text}    
	Set speed                  ${speed}
	Send text                  ${text}
	Speed should be relaxed    ${expected_speed}
	Text should be             ${expected_text}

Text and strict speed
	[Arguments]        ${speed}             ${text}    ${expected_speed}    ${expected_text}    
	Set speed          ${speed}
	Send text          ${text}
	Speed should be    ${expected_speed}
	Text should be     ${expected_text}



