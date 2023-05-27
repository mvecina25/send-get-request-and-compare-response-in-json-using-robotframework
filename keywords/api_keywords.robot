*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    JSONLibrary

Resource          ../resources/variables.robot

*** Keywords ***
Send GET Request
    [Arguments]    ${endpoint}
    ${response}=    GET    ${endpoint}
    Set Suite Variable    ${response}
    ${response_body}=    Evaluate    json.dumps(${response.json()})
    Set Suite Variable    ${response_body}

Validate Status Code Is 200
    ${status_code}=    Convert To Integer    ${response.status_code}
    Should Be Equal As Integers    ${status_code}    200

Save Response As JSON
    Create Directory    ${OUTPUT_DIR}
    ${file}    Create File    ${RESPONSE_JSON_FILE}
    ${response_body}=    Evaluate    json.dumps(${response.json()}, indent=4)
    Append To File    ${RESPONSE_JSON_FILE}    ${response_body}

Compare Response With Expected Outcome
    ${expected_body}=    Get File    ${EXPECTED_JSON_FILE}
    ${formatted_expected_body}=    Evaluate    """${expected_body.replace(" ", "").replace("\n", "").replace("\t", "")}"""
    ${formatted_actual_body}=    Evaluate    """${response_body.replace(" ", "").replace("\n", "").replace("\t", "")}"""
    Should Be Equal As Strings    ${formatted_actual_body}    ${formatted_expected_body}


