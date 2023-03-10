# WEB browser that will be used by Selenium library
BROWSER = 'Chrome'
BROWSER_DOWNLOAD_DIRECTORY = '/path/to/user/browser/downloads/'

# If the desired webdriver is placed inside 'morpheus/webdrivers/'
# (which is recommended) then it is possible to reference it this way:
WEBDRIVER_PATH = 'webdrivers/chromedriver'


# Timeout that will be used in 'Wait...' like RF Selenium keywords.
SELENIUM_WAIT_TIMEOUT_SECONDS = '10'

# Adjust these values according to your Testberry specific settings and environment.
TESTBERRY_1 = {
    'is_active': False,
    'management': {
        'ipv4_address': '172.30.0.1'
    },
    'ethernet': {
        'interface': 'eth1',
        'mac_address': 'dc:a6:32:cb:4a:2b'
    },
    'wireless': {
        'interface': 'wlan0',
        'mac_address': 'dc:a6:32:cb:4a:2c'
    }
}

TESTBERRY_2 = {
    'is_active': False,
    'management': {
        'ipv4_address': '172.30.0.2'
    },
    'ethernet': {
        'interface': 'eth1',
        'mac_address': '00:e0:4c:53:44:58'
    },
    'wireless': {
        'interface': 'wlan0',
        'mac_address': 'dc:a6:32:cb:3a:e1'
    }
}

# Adjust these values according to your DUT specific settings and environment.
# DUT generic settings are automatically updated during runtime with values
# from DUT's own profile that is located at 'morpheus/devices/<DUT_NAME>'.
AP1250ACMAX = {
    'firmware': {
        'version': '2.99.19',
    },
    'management': {
        'ipv4_address': '192.168.0.10',
        'http': {
            'secure': False,
            'port': '80'
        },
        'login': {
            'username': 'admin',
            'password': 'lockzeus',
            'first_access_password': 'M0rpheus!'
        }
    },
    'network': {
        'lan': {
            'mac_address': '58:10:8C:23:9B:33',
            'ipv4': {
                'address': '192.168.0.9',
                'netmask': '255.255.255.0',
                'gateway': '192.168.0.1'
            },
            'ipv6': {
                'link_local': 'fe80::5a10:8cff:fe23:9b33/64',
                'addresses': ['2804:14c:3f89:90fb:5a10:8cff:fe23:9b33/64'],
                'gateway': 'fe80::2cb:51ff:fe5d:b25e'
            }
        },
        'wan': {
            'mac_address': '58:10:8C:23:9B:33',
            'mtu': '1500',
            'ipv4': {
                'type_config': 'dhcp_client',
                'address': '192.168.0.9',
                'netmask': '255.255.255.0',
                'gateway': '192.168.0.1',
            },
            'ipv6': {
                'link_local': 'fe80::5a10:8cff:fe23:9b33/64',
                'gateway': 'fe80::2cb:51ff:fe5d:b25e',
            }
        },
    },
    'ethernet': {
        'interface_1': {
            'link_status': 'Conectado',
            'speed': '1000 Mb/s',
            'duplex': 'Full'
        },
        'interface_2': {
            'link_status': 'Desconectado',
            'speed': '-',
            'duplex': '-'
        }
    },
    'wireless': {
        '2ghz': {
            'default_ssid': {
                'name': 'AP1250ACMax_9b33',
                'mac_address': '58:10:8C:23:9B:33'
            }
        },
        '5ghz': {
            'default_ssid': {
                'name': 'AP1250ACMax_9b33',
                'mac_address': '58:10:8C:23:9B:33'
            }
        }
    }
}

DUT_ENV = AP1250ACMAX

AP360_CASA = {
    'firmware': {
        'version': '2.99.19',
    },
    'management': {
        'ipv4_address': '192.168.0.10',
        'http': {
            'secure': False,
            'port': '80'
        },
        'login': {
            'username': 'admin',
            'password': 'lockzeus',
            'first_access_password': 'M0rpheus!'
        }
    },
    'network': {
        'lan': {
            'mac_address': '80:8F:E8:C1:22:C1',
            'ipv4': {
                'address': '192.168.0.10',
                'netmask': '255.255.255.0',
                'gateway': '192.168.0.1'
            },
            'ipv6': {
                'link_local': 'fe80::828f:e8ff:fec1:22c1/64',
                'addresses': ['2804:14c:3f89:90fb:828f:e8ff:fec1:22c1/64'],
                'gateway': 'fe80::2cb:51ff:fe5d:b25e'
            }
        }
    },
    'ethernet': {
        'interface_1': {
            'link_status': 'Conectado',
            'speed': '100 Mb/s',
            'duplex': 'Full'
        },
        'interface_2': {
            'link_status': 'Desconectado',
            'speed': '-',
            'duplex': '-'
        }
    },
    'wireless': {
        '2ghz': {
            'default_ssid': {
                'name': 'AP360_22c1',
                'mac_address': '80:8F:E8:C1:22:C1'
            }
        },
    }
}

DUT_ENV = AP360_CASA