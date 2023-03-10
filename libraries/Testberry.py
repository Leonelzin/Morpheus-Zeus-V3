# Python built-in modules
import http
import json
import time

# Python third-party modules
import requests
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

from environment import DUT_ENV


class Testberry:
    def __init__(self, dut=None):
        if dut:
            self.DUT = BuiltIn().get_variable_value("${DUT}")

    @keyword('Through Testberry "${testberry}" Check That DUT Does Not Reply To Intelbras Discovery')
    def intelbras_discovery_should_not_be_replied(self, testberry: dict) -> None:
        print(f'Testberry: {testberry}\n')
        tberry_mgmt_ipv4 = testberry['management']['ipv4_address']

        try:
            tberry_resp = requests.get(
                f'http://{tberry_mgmt_ipv4}/discovery/intelbras?payload=intelbras')
            resp_json = tberry_resp.json()
            print(f'Testberry Response (JSON): {resp_json}')

            for discovery_reply in resp_json['devices']:
                if discovery_reply['mac_address'] == self.DUT['env']['network']['lan']['mac_address']:
                    # TODO: create domain specific exception
                    raise Exception(
                        'DUT replied to discovery multicast (INTELBRAS) but should not have replied.')

        except requests.exceptions.ConnectionError:
            print("Request connection error occurred. "
                  "Tip: Check that Testberry IPv4 address is correct and reachable.")
            raise
        except requests.exceptions.Timeout:
            print("Request timeout occurred.")
            raise
        except json.JSONDecodeError:
            print("JSON decode error occurred. "
                  "Tip: check if Testberry response (JSON content) was correct.")
            raise

    @keyword('Through Testberry "${testberry}" Check That DUT Replies To Intelbras Discovery')
    def intelbras_discovery_should_be_replied(self, testberry: dict) -> None:
        print(f'Testberry: {testberry}\n')
        tberry_mgmt_ipv4 = testberry['management']['ipv4_address']

        try:
            tberry_resp = requests.get(
                f'http://{tberry_mgmt_ipv4}/discovery/intelbras?payload=intelbras')
            resp_json = tberry_resp.json()
            print(f'Testberry Response (JSON): {resp_json}')

            dut_replied = False

            for discovery_reply in resp_json['devices']:
                if discovery_reply['mac_address'] == self.DUT['env']['network']['lan']['mac_address']:
                    dut_replied = True

            if not dut_replied:
                # TODO: create domain specific exception
                raise Exception(
                    'DUT did not reply to discovery multicast (INTELBRAS) but should have replied.')
        except requests.exceptions.ConnectionError:
            print("Request connection error occurred. "
                  "Tip: check that Testberry IPv4 address is correct and reachable.")
            raise
        except requests.exceptions.Timeout:
            print("Request timeout occurred.")
            raise
        except json.JSONDecodeError:
            print("JSON decode error occurred. "
                  "Tip: check if Testberry response (JSON content) was correct.")
            raise

    @keyword('Connect Testberry "${testberry}" To Open SSID "${ssid}"')
    def connect_testberry_to_open_ssid(self, testberry: dict, ssid: str) -> None:
        print(f'Testberry: {testberry}\n')
        tberry_mgmt_ipv4 = testberry['management']['ipv4_address']
        tberry_wifi_iface = testberry['wireless']['interface']

        try:
            tberry_resp = requests.get(
                f'http://{tberry_mgmt_ipv4}/wireless/connect?interface={tberry_wifi_iface}&ssid={ssid}&auth=open')
            resp_json = tberry_resp.json()
            print(f'Testberry Response (JSON): {resp_json}')

            if resp_json['wifi_connection_established'] == True:
                print(f'Testberry successfully connected to open SSID {ssid}.')
            else:
                # TODO: create domain specific exception
                raise Exception(
                    f'Testberry could not connect to open SSID {ssid}.')

        except requests.exceptions.ConnectionError:
            print("Request connection error occurred. "
                  "Tip: Check that Testberry IPv4 address is correct and reachable.")
            raise
        except requests.exceptions.Timeout:
            print("Request timeout occurred.")
            raise
        except json.JSONDecodeError:
            print("JSON decode error occurred. "
                  "Tip: check if Testberry response (JSON content) was correct.")
            raise

    @keyword('Connect Testberry "${testberry}" To Protect SSID "${ssid}" With WPA-PSK and Password "${passw}"')
    def connect_testberry_to_protect_ssid(self, testberry: dict, ssid: str, passw: str) -> None:
        print(f'Testberry: {testberry}\n')
        tberry_mgmt_ipv4 = testberry['management']['ipv4_address']
        tberry_wifi_iface = testberry['wireless']['interface']

        try:
            tberry_resp = requests.get(
                f'http://{tberry_mgmt_ipv4}/wireless/connect?interface={tberry_wifi_iface}&ssid={ssid}&auth=wpa-personal&password={passw}')
            resp_json = tberry_resp.json()
            print(f'Testberry Response (JSON): {resp_json}')

            if resp_json['wifi_connection_established'] == True:
                print(f'Testberry successfully connected to protect SSID {ssid} with wpa-psk and password {passw}.')
            else:
                # TODO: create domain specific exception
                raise Exception(
                    f'Testberry could not connect to protect SSID {ssid}.')

        except requests.exceptions.ConnectionError:
            print("Request connection error occurred. "
                  "Tip: Check that Testberry IPv4 address is correct and reachable.")
            raise
        except requests.exceptions.Timeout:
            print("Request timeout occurred.")
            raise
        except json.JSONDecodeError:
            print("JSON decode error occurred. "
                  "Tip: check if Testberry response (JSON content) was correct.")
            raise


    @keyword('Get Wi-Fi Connection Interface Information Testberry "${testberry}"')
    def get_testberry_wifi_information(self, testberry: dict) -> None:
        print(f'Testberry: {testberry}\n')
        tberry_mgmt_ipv4 = testberry['management']['ipv4_address']
        tberry_wifi_iface = testberry['wireless']['interface']

        try:
            tberry_resp = requests.get(
                f'http://{tberry_mgmt_ipv4}/wireless/info?interface={tberry_wifi_iface}')
            resp_json = tberry_resp.json()
            print(f'Testberry Response (JSON): {resp_json}')

            if resp_json['wifi_connection_established'] == True:
                print(f'Testberry Wi-Fi Connection Information.')
                return resp_json
            else:
                # TODO: create domain specific exception
                raise Exception(
                    f'Testberry with no wifi established connection.')

        except requests.exceptions.ConnectionError:
            print("Request connection error occurred. "
                  "Tip: Check that Testberry IPv4 address is correct and reachable.")
            raise
        except requests.exceptions.Timeout:
            print("Request timeout occurred.")
            raise
        except json.JSONDecodeError:
            print("JSON decode error occurred. "
                  "Tip: check if Testberry response (JSON content) was correct.")
            raise

    @keyword('Start Iperf3 Server On Testberry "${testberry}" Port "${port}"')
    def start_iperf3_server_on_testberry_port(self, testberry: dict, port: str) -> None:
        print(f'Testberry: {testberry}\n')
        tberry_mgmt_ipv4 = testberry['management']['ipv4_address']

        try:
            tberry_resp = requests.get(
                f'http://{tberry_mgmt_ipv4}/iperf3/server?action=start&port={port}')
            resp_json = tberry_resp.json()
            print(f'Testberry Response (JSON): {resp_json}')

            if resp_json['iperf3_server_listening'] == True:
                print(
                    f'Testberry successfully started iperf3 server on port {port}.')
            else:
                # TODO: create domain specific exception
                raise Exception(
                    f'Testberry could not start iperf3 server on port {port}.')

        except requests.exceptions.ConnectionError:
            print("Request connection error occurred. "
                  "Tip: Check that Testberry IPv4 address is correct and reachable.")
            raise
        except requests.exceptions.Timeout:
            print("Request timeout occurred.")
            raise
        except json.JSONDecodeError:
            print("JSON decode error occurred. "
                  "Tip: check if Testberry response (JSON content) was correct.")
            raise

    @keyword('Start Iperf3 TCP Client From Testberry "${testberry_client}" To Testberry "${testberry_server}" Interface "${interface}" On Port "${port}" For "${duration}" seconds')
    def start_iperf3_tcp_client_from_one_testberry_to_another_testberry(self, testberry_client: dict, testberry_server: dict, interface: str, port: str, duration: str):
        print(f'Testberry Client: {testberry_client}\n')
        print(f'Testberry Server: {testberry_server}\n')
        tberry_client_mgmt_ipv4 = testberry_client['management']['ipv4_address']
        tberry_server_mgmt_ipv4 = testberry_server['management']['ipv4_address']

        tberry_server_resp = requests.get(
            f'http://{tberry_server_mgmt_ipv4}/testberry/network/interfaces/{interface}')

        tberry_server_ipv4 = tberry_server_resp.json()[
            'ipv4_addresses'][0]['address']

        try:
            tberry_resp = requests.get(
                f'http://{tberry_client_mgmt_ipv4}/iperf3/client?host={tberry_server_ipv4}&port={port}&protocol=tcp&duration={duration}&report=simple')
            resp_json = tberry_resp.json()
            print(f'Testberry Response (JSON): {resp_json}')

            if resp_json['process']['return_code'] == 0:
                print(f'Testberry {tberry_client_mgmt_ipv4} (management IPv4) '
                      'successfully performed iperf3 TCP client to '
                      f'{tberry_server_mgmt_ipv4} (management IPv4) on port {port}.')
                return resp_json['iperf3_report']['bits_per_second']
            else:
                # TODO: create domain specific exception
                raise Exception(
                    f'Testberry {tberry_client_mgmt_ipv4} could not perform iperf3 TCP client to {tberry_server_ipv4} on port {port}.')

        except requests.exceptions.ConnectionError:
            print("Request connection error occurred. "
                  "Tip: Check that Testberry IPv4 address is correct and reachable.")
            raise
        except requests.exceptions.Timeout:
            print("Request timeout occurred.")
            raise
        except json.JSONDecodeError:
            print("JSON decode error occurred. "
                  "Tip: check if Testberry response (JSON content) was correct.")
            raise

    @keyword('Wait Until Testberry "${testberry}" Interface "${interface}" Gets An IPv4 Address Or Timeout After "${timeout}" Seconds')
    def wait_until_testberry_interface_gets_ipv4_address_or_timeout(self, testberry: dict, interface: str, timeout: int) -> None:
        tberry_mgmt_ipv4 = testberry['management']['ipv4_address']
        ipv4_acquired = False
        start_time = time.time()

        while not ipv4_acquired:
            tberry_resp = requests.get(
                f'http://{tberry_mgmt_ipv4}/testberry/network/interfaces/{interface}')
            resp_json = tberry_resp.json()
            ipv4_acquired = len(resp_json['ipv4_addresses']) > 0
            if time.time() - start_time > int(timeout):
                raise Exception(
                    f'Timeout while waiting for Testberry interface {interface} to get an IPv4 address.')
            time.sleep(0.2)

    @keyword('Check Flood Protection Using Testberry "${testberry}" Via "${interface}" With "${packets}" packets To "${protocol}" procotol')
    def check_flood_protection_using_testberry(self, testberry: dict, interface: str, packets: str, protocol: str) -> None:
        tberry_mgmt_ipv4 = testberry['management']['ipv4_address']
        dut_mgmt_ipv4 = DUT_ENV['management']['ipv4_address']

        tberry_resp = requests.get(
            f'http://{tberry_mgmt_ipv4}/hping3?interface={interface}&packets={packets}&dut_address={dut_mgmt_ipv4}&protocol={protocol}')

        try:
            tberry_resp = requests.get(
                f'http://{tberry_mgmt_ipv4}/hping3?interface={interface}&packets={packets}&dut_address={dut_mgmt_ipv4}&protocol={protocol}')
            resp_json = tberry_resp.json()
            print(f'Testberry Response (JSON): {resp_json}')

            if resp_json['packet_loss_percentage'] == str(100):
                print(f'ICMP Flood Protection successfully performed')
                return resp_json['packet_loss_percentage']

            else:
                print(resp_json['packet_loss_percentage'])
                raise Exception(
                    f'Extected 100% of packets loss')

        except requests.exceptions.ConnectionError:
            print("Request connection error occurred. "
                  "Tip: Check that Testberry IPv4 address is correct and reachable.")
            raise
        except requests.exceptions.Timeout:
            print("Request timeout occurred.")
            raise
        except json.JSONDecodeError:
            print("JSON decode error occurred. "
                  "Tip: check if Testberry response (JSON content) was correct.")
            raise

    @keyword('Get Hping3 Result Using Testberry "${testberry}" Via "${interface}" With "${packets}" packets To "${protocol}" procotol')
    def get_hping3_result_using_testberry(self, testberry: dict, interface: str, packets: str, protocol: str) -> dict:
        tberry_mgmt_ipv4 = testberry['management']['ipv4_address']
        dut_mgmt_ipv4 = DUT_ENV['management']['ipv4_address']

        hping3_tberry_resp = requests.get(
            f'http://{tberry_mgmt_ipv4}/hping3?interface={interface}&packets={packets}&dut_address={dut_mgmt_ipv4}&protocol={protocol}')

        return hping3_tberry_resp.json()

