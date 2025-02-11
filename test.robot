*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}             http://automationexercise.com
${BROWSER}         Chrome
${SEARCH_TERM}     blue
${EMAIL}           prim@gmail.com
${PASSWORD}        12345678

*** Test Cases ***
Search Products and Verify Cart After Login
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    Click Products Button
    Verify All Products Page
    Search Product
    Verify Searched Products
    Click On First Product
    Add Products To Cart
    Verify Products In Cart
    Login And Verify Cart
    Close Browser

*** Keywords ***
Click Products Button
    Click Element    xpath=//a[@href='/products']
    Wait Until Page Contains    All Products    timeout=10s   # รอให้หน้าโหลด

Verify All Products Page
    ${page_text}=    Get Text    xpath=//h2
    Log    Found text: ${page_text}
    Should Contain    ${page_text}    All Products

Search Product
    Wait Until Element Is Visible    xpath=//*[@id="search_product"]
    Input Text    xpath=//*[@id="search_product"]    ${SEARCH_TERM}
    Click Button    xpath=//*[@id="submit_search"]

Verify Searched Products
    Wait Until Page Contains    Searched Products    timeout=10s
    Page Should Contain    SEARCHED PRODUCTS

Click On First Product
    Wait Until Element Is Visible    xpath=/html/body/section[2]/div/div/div[2]/div/div[3]/div/div[1]/div[2]/div/a
    Click Element    xpath=/html/body/section[2]/div/div/div[2]/div/div[3]/div/div[1]/div[2]/div/a

Add Products To Cart
    Wait Until Element Is Visible    xpath=//button[contains(text(),'Add to cart')]
    Click Button    xpath=//button[contains(text(),'Add to cart')]
    Wait Until Element Is Visible    xpath=//button[contains(text(),'Continue Shopping')]
    Click Button    xpath=//button[contains(text(),'Continue Shopping')]

Verify Products In Cart
    Click Element    xpath=//a[@href='/view_cart']
    Wait Until Element Is Visible    xpath=//table[@id='cart_info_table']
    Page Should Contain    ${SEARCH_TERM}

Login And Verify Cart
    Click Element    xpath=//a[@href='/login']
    Input Text    xpath=//input[@name='email']    ${EMAIL}
    Input Text    xpath=//input[@name='password']    ${PASSWORD}
    Click Button    xpath=//button[contains(text(),'Login')]

    Click Element    xpath=//a[@href='/view_cart']
    Wait Until Element Is Visible    xpath=//table[@id='cart_info_table']
    Page Should Contain    ${SEARCH_TERM}
