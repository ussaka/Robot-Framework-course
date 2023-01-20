*** Settings ***
Documentation       Author: Kasperi Kiviluoma

Library             FakerLibrary    locale=fi_FI
Library             Dialogs
Library             Collections
Library             OperatingSystem
Library             String


*** Variables ***
${FILENAME} =       test.txt


*** Test Cases ***
Remove an existing file
    Create File    ${CURDIR}//${FILENAME}    Testi Testilainen\nTestilaakso 1\n02210 Testila
    Remove Existing Address File    ${FILENAME}

Remove nonexistent file
    Remove Existing Address File    ${FILENAME}

Create a new address file
    Create an address file

File contains three lines
    Count lines


*** Keywords ***
Get Random Names
    [Arguments]    ${number_of_names}
    ${names} =    Create List
    FOR    ${index}    IN RANGE    ${number_of_names}
        ${name} =    FakerLibrary.Name
        Append To List    ${names}    ${name}
    END
    RETURN    ${names}

Remove Existing Address File
    [Arguments]    ${filename}
    ${path} =    Format String    {}//{}    ${CURDIR}    ${filename}
    ${passed} =    Run Keyword And Return Status    Get File    ${path}
    IF    ${passed}
        ${file} =    Get File    ${path}
        ${name} =    Get Line    ${file}    0
        Log    ${name}
        Remove File    ${path}
    END

Five names selection Dialog
    ${names} =    Get Random Names    5
    ${name1} =    Get From List    ${names}    0
    ${name2} =    Get From List    ${names}    1
    ${name3} =    Get From List    ${names}    2
    ${name4} =    Get From List    ${names}    3
    ${name5} =    Get From List    ${names}    4
    ${name} =    Get Selection From User    Select name    ${name1}    ${name2}    ${name3}    ${name4}    ${name5}
    RETURN    ${name}

Create an address file
    ${name} =    Five names selection Dialog
    ${address} =    FakerLibrary.Street Address
    ${postcode} =    FakerLibrary.Postcode
    ${city} =    FakerLibrary.city
    ${city_postcode} =    Format String    {} {}    ${postcode}    ${city}
    Create File    ${CURDIR}//${FILENAME}    ${name}\n
    Append To File    ${CURDIR}//${FILENAME}    ${address}\n
    Append To File    ${CURDIR}//${FILENAME}    ${city_postcode}\n

Count lines
    ${str} =    Get File    ${CURDIR}//${FILENAME}
    ${count} =    Get Line Count    ${str}
    Run Keyword Unless    ${count} == 3    Fail    Counted more than three lines
