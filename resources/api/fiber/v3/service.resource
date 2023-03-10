*** Settings ***
Documentation     Fiber API (v3) Service Resource File
Library           Collections
Library           RequestsLibrary
Resource          api/fiber/v3/system.resource

*** Variables ***
${FIBERV3_ENDPOINT_SERVICE_CRONOS}      /cgi-bin/api/v3/service/cronos

*** Keywords ***
# Regarding 'Create Session' keywords: 'disable_warnings' is currently set to
# 'true' due to https://intelbras.atlassian.net/browse/PZ-7484
# FiberV3 is replying to requests with both "Transfer-Encoding" and
# "Content-Length" HTTP headers and this is not complying with RFC7230.
# https://datatracker.ietf.org/doc/html/rfc7230#section-3.3.2.
FiberV3 Get Cronos Version
    ${token}    FiberV3 Get API Authorization Token
    &{headers}    Create Dictionary    Authorization=Token ${token}
    Create Session    alias=http_session    url=${DUT_URL}    disable_warnings=${TRUE}    headers=${headers}
    ${response}    GET On Session    http_session    ${FIBERV3_ENDPOINT_SERVICE_CRONOS}
    ${response}    Set Variable    ${response.json()}[data]
    ${dict_has_key}    Run Keyword And Return Status    Dictionary Should Contain Key    dictionary=${response}    key=version    msg=Key "version" not found in "/cgi-bin/api/v3/service/cronos" response (JSON).
    IF    ${dict_has_key} == ${TRUE}
        Return From Keyword    ${response}[version]
    ELSE
        Return From Keyword    ${NONE}
    END
    [Teardown]    Delete All Sessions
