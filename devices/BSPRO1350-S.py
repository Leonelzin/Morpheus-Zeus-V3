import os


DUT_PROFILE = {
    'general': {
        'model_name': 'BSPRO1350-S',
        'login_page_title': 'Entrar',
        'web_management_page_title': 'BSPRO1350-S',
        'max_reset_time': '200',
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
                '2ghz_ssid_filter': 'all',
                '5ghz_ssid_filter': 'all'
            }
        },
        'processing_pps': {
            'is_supported': True,
            'factory_default': {
                '2ghz_ssid_filter': 'all',
                '5ghz_ssid_filter': 'all'
            }
        },
        'signal': {
            'is_supported': True,
        }
    },
    'wizard': {
        'default_preset': 'facebook',
        'router': {
            'wireless': {
                'factory_default': {
                    'ssid': {
                        'band': 'dual_band',
                        'auth': 'open',
                        'hide': False,
                    }
                }
            },
            'lan': {
                'factory_default': {
                    'ipv4': {
                        'address': '10.0.0.1',
                        'netmask': '255.255.0.0',
                        'dns_mode': 'manual',
                        'dns_server_1': '8.8.8.8'
                    }
                }
            }
        },
        'access_point': {
            'wireless': {
                'factory_default': {
                    'ssid': {
                        'band': 'dual_band',
                        'auth': 'open',
                        'hide': False,
                        'vlan_enabled': False,
                        'vlan_id': 1
                    }
                }
            },
            'auto_configuration': {
                'factory_default': {
                    'auto_authorization_enabled': False,
                }
            },
            'lan': {
                'factory_default': {
                    'ipv4': {
                        'dhcp_client_enabled': True,
                        'address': '10.0.0.1',
                        'netmask': '255.255.0.0',
                        'default_gateway': '10.0.255.254',
                        'dns_mode': 'automatic',
                        'dns_server_1': '8.8.8.8'
                    }
                }
            }
        },
        'repeater': {
            'wireless': {
                'client': {
                    'factory_default': {
                        'interface': '5ghz',
                        'ssid': {
                            'name': '',
                            'auth': 'open',
                            'hide': False,
                            'bssid': ''
                        }
                    }
                },
                'ap': {
                    'factory_default': {
                        'ssid': {
                            'auth': 'open',
                            'hide': False,
                        }
                    }
                }
            },
            'lan': {
                'factory_default': {
                    'ipv4': {
                        'dhcp_client_enabled': True,
                        'address': '10.0.0.1',
                        'netmask': '255.255.0.0',
                        'default_gateway': '10.0.255.254',
                        'dns_mode': 'automatic',
                        'dns_server_1': '8.8.8.8'
                    }
                }
            }
        },
        'splash_page': {
            'wireless': {
                'factory_default': {
                    'ssid': {
                        'band': 'dual_band',
                        'auth': 'open',
                        'hide': False,
                    }
                }
            },
            'lan': {
                'factory_default': {
                    'ipv4': {
                        'address': '10.0.0.1',
                        'netmask': '255.255.0.0',
                        'dns_mode': 'manual',
                        'dns_server_1': '8.8.8.8'
                    }
                }
            }
        }
    },
    'ethernet': {
        'interface_1': {
            'is_supported': True,
            'html_id': 'eth1/PoE',
            'factory_default': {
                'auto_negotiation': {
                    'enabled': False,
                    'advertisement': {
                        '10_half': True,
                        '10_full': True,
                        '100_half': True,
                        '100_full': True,
                        '1000_full': True,
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
                    'port_speed': None,
                    'duplex_mode': None
                }
            }
        }
    },
    'wizard': {
        'facebook': {
            'wireless': {
                'is_supported': True,
                'factory_default': {
                    'ssid_name': 'any',
                    'ssid_frequency': 'Dual band',
                    'authentication_type': 'Open System',
                    'ssid_hide': False,
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
            'hostname': 'bspro1350-s',
            'operation_mode': 'router',
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
    'wifi_marketing': {
        'splash_page': {
            'is_supported': True,
        },
        'captive_portal': {
            'is_supported': True,
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
        },
        'ip_control': {
            'factory_default': {
                'control_type': 'ip',
                'protocol': 'tcp/udp',
                'action': 'allow',
                'description': '',
                'ip': '',
                'network': '',
                'range_ip_start': '',
                'range_ip_end': '',

            }
        },
        'mac_control': {
            'factory_default': {
                'action': 'allow',
                'description': '',
                'mac': ''
            }
        },
        'advanced': {
            'factory_default': {
                'description': '',
                'source_ip': '',
                'source_port': '',
                'destination_ip': '',
                'destination_port': '',
                'protocol': 'tcp',
                'action': 'allow',
            }
        },
        'port_forwarding': {
            'host_dmz': {
                'is_supported': True,
                'factory_default': {
                    'host_description': '',
                    'redirect_ip': ''
                }
            },
            'simple': {
                'is_supported': True,
                'factory_default': {
                    'simple_description': '',
                    'port_range_start': '',
                    'port_range_end': '',
                    'protocol': 'tcp/udp',
                    'redirect_ip': ''
                }
            },
            'advanced': {
                'is_supported': True,
                'factory_default': {
                    'advanced_description': '',
                    'ip_source_network': '0.0.0.0',
                    'outport_port': '',
                    'internal_ip': '',
                    'internal_port': '',
                    'protocol': 'tcp/udp'
                }
            }
        }
    },
    'wireless': {
        'is_outdoor': False,
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
            'is_supported': True,
            'interface_id': 'wifi0',
            'antenna_gain': 4,
            'max_tx_power': 26,
            'factory_default': {
                'operation_mode': 'access_point',
                'ssids_isolation_enabled': False,
                'ieee_mode': 'b/g/n',
                'country': 'brasil',
                'bandwidth': '20/40 MHz',
                'channel': 'automatic',
                'tx_power': 28,
                'noise_floor_control_enabled': True,
            },
        },
        '5ghz': {
            'is_supported': True,
            'interface_id': 'wifi1',
            'antenna_gain': 5,
            'max_tx_power': 29,
            'factory_default': {
                'operation_mode': 'access_point',
                'ssids_isolation_enabled': False,
                'ieee_mode': 'a/n/ac',
                'country': 'brasil',
                'bandwidth': '20/40/80 MHz',
                'channel': 'automatic',
                'tx_power': 29,
                'noise_floor_control_enabled': True,
            }
        },
        'qca_smart_handover': {
            'is_supported': True,
            'factory_default': {
                'enabled': False,
                'is_main_ap': False
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
        }
    },
    'wifi_marketing': {
        'splash_page': {
            'is_supported': True,
            'factory_default': {
                'media_type': 'video',
                'media_link': 'https://',
                'advertising_timeout': '30',
                'session_timeout': '30 min',
                'legal_information': ''
            }
        },
        'captive_portal': {
            'is_supported': True,
            'factory_default': {
                'network_2ghz': False,
                'network_5ghz': False,
                'address': '',
                'session_time': '30 minutes',
                'inactivity_limit': '15 minutes',
                'authentication_method': 'None'
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
                'name': 'BSPRO1350-S',
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
            }
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
