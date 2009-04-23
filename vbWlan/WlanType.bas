Attribute VB_Name = "WlanType"
Option Explicit

Public Type GUID
    data1 As Long
    data2  As Integer
    data3 As Integer
    data4(7) As Byte
End Type
'16 Bytes total


Public Type WLAN_INTERFACE_INFO
    InterfaceGuid As GUID
    strInterfaceDescription(511) As Byte
    isState As WLAN_INTERFACE_STATE
End Type
' WLAN_INTERFACE_INFO, *PWLAN_INTERFACE_INFO;
'16+512+4=532 bytes total


Public Type WLAN_INTERFACE_INFO_LIST
    dwNumberOfItems As Long
    dwIndex As Long
    InterfaceInfo(1) As WLAN_INTERFACE_INFO
End Type
'WLAN_INTERFACE_INFO_LIST, *PWLAN_INTERFACE_INFO_LIST;
'4+4+532=540 bytes total

Public Type DOT11_SSID
    uSSIDLength As Long
    ucSSID(31) As Byte
End Type

Public Type WLAN_RAW_DATA
    dwDataSize As Long
    DataBlob(3) As Byte
End Type

Public Type WLAN_CONNECTION_PARAMETERS
    wlanConnectionMode As WLAN_CONNECTION_MODE
    strProfile As Long
    pDot11Ssid As Long                      'pointer to DOT11_SSID
    pDesiredBssidList As Long               'pointer to DOT11_BSSID_LIST
    dot11BssType As DOT11_BSS_TYPE
    dwFlags As Long
End Type
