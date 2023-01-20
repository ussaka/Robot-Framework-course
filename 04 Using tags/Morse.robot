*** Settings ***
Documentation    Example of morse transmitter test
...              Test Cases Author: Kasperi Kiviluoma
...              Disclaimer:
...              Not sure what was meant by WPM output and immediate printing
...
Resource          Morse.resource

*** Test Cases ***                          Speed    Text                                                Expected speed    Expected text
Test text only
    [Template]    Text only
    [Tags]        text_only                             
                                            200      hello world                                                           HELLO WORLD
                                            200      HELLO WORLD                                                           HELLO WORLD
                                            200      abcdefghijklmnopqrstuvwxyz                                            ABCDEFGHIJKLMNOPQRSTUVWXYZ
                                            200      ABCDEFGHIJKLMNOPQRSTUVWXYZ                                            ABCDEFGHIJKLMNOPQRSTUVWXYZ
                                            200      0123456789                                                            0123456789
Test text and relaxed speed
    [Template]    Text and relaxed speed
    [Tags]        relaxed                             
                                            10       hello                                               11                HELLO
                                            10       hello                                               10                HELLO
                                            80       hElLo                                               92                HELLO
                                            166      helLO                                               155               HELLO
                                            470      Hello                                               500               HELLO
                                            332      HeLLo                                               351               HELLO
Test strict
    [Template]    Text and strict speed
    [Tags]        strict
                                            200      äöå^~¨'-_.,:;<>|=?""@£$€{{[]}}                      200               XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                            250      Hello, What is your name and where are you from?    250               HELLOX WHAT IS YOUR NAME AND WHERE ARE YOU FROMX
                                            100      "Hello, World!”                                     100               XHELLOX WORLDXXXX