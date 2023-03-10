import os


DUT_PROFILE = {
    'general': {
        'model_name': 'WOM 5A MiMo CFTV IP',
        'login_page_title': 'Entrar',
        'web_management_page_title': 'wom5amimocftvip',
        'max_reset_time': '300',
    },
    'login': {
        'factory_default': {
            'production_firmware': {
                'username': 'admin',
                'password': 'admin'
            },
            'development_firmware': {
                'username': 'admin',
                'password': os.environ['ITB_DEV_FW_PASSWORD']
            },
        }
    },
    'status':  {
        'connected_clients': {
            'is_supported': True,
            'factory_default': {
                'filters': {
                    'interface': 'any',
                    'ssid': 'any',
                    'addressing_type': 'any',
                },
                'auto_update_enabled': False
            }
        },
        'throughput': {
            'is_supported': True,
            'factory_default': {
                '2ghz_ssid_filter': None,
                '5ghz_ssid_filter': 'all'
            }
        },
        'processing_pps': {
            'is_supported': True,
            'factory_default': {
                '2ghz_ssid_filter': None,
                '5ghz_ssid_filter': 'all'
            }
        },
        'signal': {
            'is_supported': True,
        }
    },
    'ethernet': {
        'interface_1': {
            'is_supported': True,
            'html_id': 'eth0',
            'factory_default': {
                'auto_negotiation': {
                    'enabled': True,
                    'advertisement': {
                        '10_half': True,
                        '10_full': True,
                        '100_half': True,
                        '100_full': True,
                        '1000_full': None,
                    }
                },
                'manual': {
                    'port_speed': 100,
                    'duplex_mode': 'full'
                }
            }
        },
        'interface_2': {
            'is_supported': False,
            'html_id': None,
            'factory_default': {
                'auto_negotiation': {
                    'enabled': None,
                    'advertisement': {
                        '10_half': None,
                        '10_full': None,
                        '100_half': None,
                        '100_full': None,
                        '1000_full': None,
                    }
                },
                'manual': {
                    'port_speed': 100,
                    'duplex_mode': 'full'
                }
            }
        }
    },
    'network': {
        'wan': {
            'min_mtu': 68,
            'max_mtu': 9000
        },
        'factory_default': {
            'hostname': 'wom5amimocftvip',
            'operation_mode': 'brigde',
            'wan': {
                'ipv4_addressing_type': 'dhcp_client',
                'mac_address_clone': '',
                'vlan_enabled': False,
                'vlan_id': 1,
                'mtu': 1500,
                'ipv6_addressing_type': 'automatic'
            },
            'lan': {
                'ipv4_dynamic_addressing_enabled': True,
                'ipv4_address': '10.0.0.1',
                'ipv4_subnet_mask': '255.255.0.0',
                'ipv4_default_gateway': '10.0.255.254',
                'ipv6_addressing_type': 'automatic',
                'spanning_tree_enabled': False
            },
            'dhcp_server': {
                'ipv4': {
                    'enabled': False,
                    'address_pool_start': '10.0.0.10',
                    'address_pool_end': '10.0.4.9',
                    'lease_time': 1800,
                    'dns_rebind_attack_protection_enabled': True,
                },
                'ipv6': {
                    'mode': 'automatic_stateless',
                }
            },
            'dns': {
                'ipv4': {
                    'mode': 'automatic',
                    'server_1': '8.8.8.8',
                    'server_2': '8.8.4.4',
                },
                'ipv6': {
                    'mode': 'automatic',
                    'server_1': '2001:4860:4860::8888',
                    'server_2': '2001:4860:4860::8844',
                }
            },
            'static_routes': {
                'ipv4': {
                    'description': '',
                    'destination_ip': '',
                    'destination_netmask': '',
                    'gateway': '',
                    'interface': 'wan',
                }
            }
        },
    },
    'firewall': {
        'factory_default': {
            'enabled': True,
            'upnp_enabled': True,
            'wan_ping_enabled': False,
            'icmp_flood_protection_enabled': True,
            'tcp_syn_flood_protection_enabled': True,
            'udp_flood_protection_enabled': True,
            'tcp_invalid_flags_and_port_scan_protection_enabled': True,
            'ip_spoofing_protection_enabled': True,
            'invalid_packets_protection_enabled': True,
        }
    },
    'wireless': {
        'is_outdoor': True,
        'ssid': {
            'factory_default': {
                'band': 'dual_band',
                'auth': 'open',
                'broadcast_off': False,
                'ssid_isolation': False,
                'clients_isolation': False,
                'internet_only': False,
                'max_client_assoc': 127,
                'min_client_signal': -90,
                'vlan': False,
                'vlan_id': 1
            }
        },
        '2ghz': {
            'is_supported': False,
            'interface_id': None,
            'antenna_gain': None,
            'max_tx_power': None,
            'factory_default': {
                'operation_mode': None,
                'ssids_isolation_enabled': None,
                'ieee_mode': None,
                'country': None,
                'bandwidth': None,
                'channel': None,
                'tx_power': None,
                'noise_floor_control_enabled': None,
            }
        },
        '5ghz': {
            'is_supported': True,
            'interface_id': 'radio0',
            'antenna_gain': 16,
            'factory_default': {
                'operation_mode': 'access_point',
                'ssids_isolation_enabled': False,
                'ieee_mode': 'a/n',
                'country': 'brasil',
                'bandwidth': '20/40 MHz',
                'channel': 'automatic',
                'max_tx_power': 20,
                'tx_power': 20,
                'noise_floor_control_enabled': True
            }
        },
        'assisted_roaming': {
            'is_supported': True,
            'factory_default': {
                'enabled': True,
            }
        },
        'fast_roaming': {
            'is_supported': True,
            'factory_default': {
                'enabled': False
            }
        },
        'qca_smart_handover': {
            'is_supported': True,
            'factory_default': {
                'enabled': False,
                'is_main_ap': False
            }
        },
        'band_steering': {
            'is_supported': True,
            'factory_default': {
                'enabled': True,
                'method': 'load_balance'
            }
        },
        'mu_mimo': {
            'is_supported': True,
            'factory_default': {
                'enabled': True
            }
        },
        'beamforming': {
            'is_supported': True,
            'factory_default': {
                'enabled': True
            }
        }
    },
    'tools': {
        'site_survey': {
            'is_supported': True,
            'factory_default': {
                'frequency_band': '5ghz'
            }
        }
    },
    'features': {
        'led': {
            'status_led': {
                'is_supported': False,
                'factory_default': {
                    'mode': None,
                }
            },
            'locate_device': {
                'is_supported': False,
            },
            'color_settings': {
                'is_supported': False,
                'factory_default': {
                    'color': None,
                }
            },
        },
        'discovery': {
            'brute_force_protection': {
                'is_supported': True,
                'factory_default': {
                    'enabled': True
                }
            },
            'lldp': {
                'is_supported': True,
                'factory_default': {
                    'enabled': True,
                    'wan_access_enabled': False
                }
            },
            'cdp': {
                'is_supported': True,
                'factory_default': {
                    'enabled': True,
                    'wan_access_enabled': False
                }
            },
            'intelbras': {
                'is_supported': True,
                'factory_default': {
                    'enabled': True,
                    'wan_access_enabled': False
                }
            },
        },
        'ddns': {
            'is_supported': True,
            'factory_default': {
                'enabled': False,
                'service': 'dyndns',
                'domain': 'mypersonaldomain.dyndns.org',
                'username': 'myusername',
                'password': 'mypassword',
            },
        },
        'log': {
            'is_supported': True,
            'factory_default': {
                'enabled': True,
                'level': 'error',
                'send_log_to_remote_server': False,
                'remote_server_ip': '',
                'port': '514'
            },
        },
        'ntp_client': {
            'is_supported': True,
            'factory_default': {
                'enabled': True,
                'server_1': 'a.ntp.br',
                'server_2': 'b.ntp.br',
                'timezone': '(GMT-03:00) São Paulo',
                'daylight_saving_time': False
            },
        },
        'snmp': {
            'is_supported': True,
            'factory_default': {
                'enabled': False,
                'wan_access_enabled': False,
                'community': 'public',
                'port': 161,
                'location': 'Intelbras - SC - Brasil',
                'contact': 'admin@meu_dominio.com.br',
                'name': 'WOM 5A MiMo CFTV IP',
            }
        },
        'watchdog': {
            'is_supported': True,
            'factory_default': {
                'enabled': False,
                'ip_addr_1': '192.168.1.1',
                'ip_addr_2': '',
                'check_interval': '30',
            }
        },
        'auto_configuration': {
            'is_supported': True,
            'factory_default': {
                'enabled': True,
                'auto_authorization_enabled': False,
            },
        }
    },
    'system': {
        'management': {
            'session_timeout': {
                'min_value': 60,
                'max_value': 86400,
                'factory_default': {
                    'production_firmware': {
                        'timeout': 300,
                    },
                    'development_firmware': {
                        'timeout': 3600,
                    },
                }
            },
            'http': {
                'is_supported': True,
                'factory_default': {
                    'enabled': True,
                    'brute_force_protection': True,
                    'wan_access_enabled': False,
                    'port': 80
                }
            },
            'https': {
                'is_supported': True,
                'factory_default': {
                    'brute_force_protection': True,
                    'wan_access_enabled': False,
                    'port': 443,
                }
            },
            'ssh': {
                'is_supported': True,
                'factory_default': {
                    'production_firmware': {
                        'enabled': False,
                    },
                    'development_firmware': {
                        'enabled': True,
                    },
                    'brute_force_protection': True,
                    'wan_access_enabled': False,
                    'port': 22
                }
            },
            'vlan': {
                'is_supported': True,
                'factory_default': {
                    'enabled': False,
                    'interface': '',
                    'id': 1
                }
            }
        }
    },
    'qos': {
        'is_supported': True,
        'factory_default': {
            'enabled': False,
            'type': 'limit_and_guarantee_per_ssid',
            'internet_link': {
                'upload_mbps': 1000,
                'download_mbps': 1000
            },
            'ssid_band_limit': {
                'enabled': False,
            },
            'ssid_band_guarantee': {
                'enabled': False,
            }
        }
    },
}
