Attribute VB_Name = "WlanEnum"
Option Explicit

Public Enum WLAN_INTERFACE_STATE
    wlan_interface_state_not_ready = 0
    wlan_interface_state_connected = 1
    wlan_interface_state_ad_hoc_network_formed = 2
    wlan_interface_state_disconnecting = 3
    wlan_interface_state_disconnected = 4
    wlan_interface_state_associating = 5
    wlan_interface_state_discovering = 6
    wlan_interface_state_authenticating = 7
End Enum

Public Enum WLAN_INTF_OPCODE
    wlan_intf_opcode_autoconf_start = &H0
    wlan_intf_opcode_autoconf_enabled
    wlan_intf_opcode_background_scan_enabled
    wlan_intf_opcode_media_streaming_mode
    wlan_intf_opcode_radio_state
    wlan_intf_opcode_bss_type
    wlan_intf_opcode_interface_state
    wlan_intf_opcode_current_connection
    wlan_intf_opcode_channel_number
    wlan_intf_opcode_supported_infrastructure_auth_cipher_pairs
    wlan_intf_opcode_supported_adhoc_auth_cipher_pairs
    wlan_intf_opcode_supported_country_or_region_string_list
    wlan_intf_opcode_current_operation_mode
    wlan_intf_opcode_supported_safe_mode
    wlan_intf_opcode_certified_safe_mode
    wlan_intf_opcode_autoconf_end = &HFFFFFFF
    wlan_intf_opcode_msm_start
    wlan_intf_opcode_statistics
    wlan_intf_opcode_rssi = &H10000100
    wlan_intf_opcode_msm_end = &H1FFFFFFF
    wlan_intf_opcode_security_start = &H20010000
    wlan_intf_opcode_security_end = &H2FFFFFFF
    wlan_intf_opcode_ihv_start = &H30000000
    wlan_intf_opcode_ihv_end = &H3FFFFFFF

End Enum

Public Enum WLAN_OPCODE_VALUE_TYPE
    wlan_opcode_value_type_query_only
    wlan_opcode_value_type_set_by_group_policy
    wlan_opcode_value_type_set_by_user
    wlan_opcode_value_type_invalid
End Enum


Public Enum DOT11_BSS_TYPE
        dot11_BSS_type_infrastructure = 1
        dot11_BSS_type_independent = 2
        dot11_BSS_type_any = 3
End Enum


Public Enum WLAN_CONNECTION_MODE
    wlan_connection_mode_profile
    wlan_connection_mode_temporary_profile
    wlan_connection_mode_discovery_secure
    wlan_connection_mode_discovery_unsecure
    wlan_connection_mode_auto
    wlan_connection_mode_invalid
End Enum
