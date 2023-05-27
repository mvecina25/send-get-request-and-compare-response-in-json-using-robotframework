*** Settings ***
Documentation     API Test - GET Request
Resource          ../resources/variables.robot
Resource          ../keywords/api_keywords.robot

*** Test Cases ***
Validate GET Request
    Send GET Request    ${API_URL}
    Validate Status Code Is 200
    Save Response As JSON
    Compare Response With Expected Outcome
