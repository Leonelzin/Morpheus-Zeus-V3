# Python built-in modules
import http
import json
import time

# Python third-party modules
import requests
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn


class FiberV3:
    def __init__(self, dut=None):
        if dut:
            self.DUT = BuiltIn().get_variable_value('${DUT}')

    @keyword('Get API Authentication Token')
    def get_api_auth_token(self) -> str:
        """Returns a Fiber V3 API authorization token if username and password are correct."""

        auth_json = {
            'data':
            {
                'username': self.DUT['env']['management']['login']['username'],
                'password': self.DUT['env']['management']['login']['password']
            }
        }
        
        urn = 'cgi-bin/api/v3/system/login'

        if self.DUT['env']['management']['http']['secure'] == True:
            web_protocol = 'https'
        else:
            web_protocol = 'http'

        ipv4 = self.DUT['env']['management']['ipv4_address']
        port = self.DUT['env']['management']['http']['port']

        uri = f'{web_protocol}://{ipv4}:{port}/{urn}'

        api_token = None

        try:
            response = requests.post(
                uri, json=auth_json, verify=False, timeout=10)

            if response.status_code == http.HTTPStatus.OK:
                api_token = response.json()['data']['Token']

        except requests.exceptions.ConnectionError:
            print("Request connection error occurred. "
                  "Tip: check that DUT IPv4 address is correct and reachable.")
            raise
        except requests.exceptions.Timeout:
            print("Request timeout occurred.")
            raise
        except json.JSONDecodeError:
            print("JSON decode error occurred. "
                  "Tip: check if DUT response (JSON content) was correct.")
            raise

        if not api_token:
            # TODO: create domain specific exception
            raise Exception('Could not get API authentication token.')

        return api_token

    @keyword('Wait Until DUT System Is Ready Or Timeout After "${timeout}" Seconds')
    def wait_until_dut_system_is_ready_or_timeout(self, timeout: int) -> None:
        # There is an open issue that could enhance this implementation
        # https://intelbras.atlassian.net/browse/PZ-7268

        api_token = self.get_api_auth_token()
        headers = {'Authorization': 'token ' + api_token}

        urn = 'cgi-bin/api/v3/system/device/status'
        
        if self.DUT['env']['management']['http']['secure'] == True:
            web_protocol = 'https'
        else:
            web_protocol = 'http'

        ipv4 = self.DUT['env']['management']['ipv4_address']
        port = self.DUT['env']['management']['http']['port']

        http_method = 'GET'
        uri = f'{web_protocol}://{ipv4}:{port}/{urn}'

        system_ready = True
        internal_timeout = 15
        start_time = time.time()

        # Wait for first transition to "false" or timeout
        while (time.time() - start_time) < internal_timeout and system_ready:
            response = self._dispatch_api_request(http_method, uri, headers)
            resp_json = json.loads(response['response_content'])
            system_ready = resp_json['data']['status']['ready']
            time.sleep(0.5)

        start_time = time.time()
        # Wait for transition from "false" to "true" or timeout
        while not system_ready:
            response = self._dispatch_api_request(http_method, uri, headers)
            resp_json = json.loads(response['response_content'])
            system_ready = resp_json['data']['status']['ready']
            if time.time() - start_time > int(timeout):
                raise Exception(
                    f'Timeout Error: DUT system was not ready after {timeout} seconds.')

            time.sleep(0.5)

    def _dispatch_api_request(self, http_method: str, uri: str, headers: dict, body_data: dict = None) -> dict:
        # TODO: body data
        http_method = http_method.upper()
        session = requests.Session()
        request = requests.Request(http_method, uri, headers=headers)
        prepared_request = request.prepare()

        data = {
            'http_status_code': None,
            'response_content': None,
            'error': None
        }

        try:
            response = session.send(prepared_request, verify=False)
            data['http_status_code'] = response.status_code
            data['response_content'] = response.content.decode('utf-8')
        except requests.exceptions.ConnectionError:
            data['error'] = 'request connection error occurred'
        except requests.exceptions.Timeout:
            data['error'] = 'request timeout occurred'

        return data

    @keyword('Check If DUT Is In Factory Default State')
    def check_if_dut_is_in_factory_default_state(self) -> bool:
        api_token = self.get_api_auth_token()
        headers = {'Authorization': 'token ' + api_token}

        urn = 'cgi-bin/api/v3/system/device/status'

        if self.DUT['env']['management']['http']['secure'] == True:
            web_protocol = 'https'
        else:
            web_protocol = 'http'

        ipv4 = self.DUT['env']['management']['ipv4_address']
        port = self.DUT['env']['management']['http']['port']

        http_method = 'GET'
        uri = f'{web_protocol}://{ipv4}:{port}/{urn}'

        response = self._dispatch_api_request(http_method, uri, headers)
        resp_json = json.loads(response['response_content'])
        settings_hash = resp_json['data']['config_hash']

        return True if settings_hash == 'default' else False
