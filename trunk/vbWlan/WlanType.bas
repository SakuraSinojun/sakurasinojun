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



'typedef struct _WLAN_AVAILABLE_NETWORK {
'  WCHAR                  strProfileName[256];
'  DOT11_SSID             dot11Ssid;
'  DOT11_BSS_TYPE         dot11BssType;
'  ULONG                  uNumberOfBssids;
'  BOOL                   bNetworkConnectable;
'  WLAN_REASON_CODE       wlanNotConnectableReason;
'  ULONG                  uNumberOfPhyTypes;
'  DOT11_PHY_TYPE         dot11PhyTypes[WLAN_MAX_PHY_TYPE_NUMBER];
'  BOOL                   bMorePhyTypes;
'  WLAN_SIGNAL_QUALITY    wlanSignalQuality;
'  BOOL                   bSecurityEnabled;
'  DOT11_AUTH_ALGORITHM   dot11DefaultAuthAlgorithm;
'  DOT11_CIPHER_ALGORITHM dot11DefaultCipherAlgorithm;
'  DWORD                  dwFlags;
'  DWORD                  dwReserved;
'} WLAN_AVAILABLE_NETWORK, *PWLAN_AVAILABLE_NETWORK;

Public Type WLAN_AVALIABLE_NETWORK
    strProfileName(511) As Byte
    dot11Ssid As DOT11_SSID
    dot11BssType As DOT11_BSS_TYPE
    uNumberOfBssids As Long
    bNetworkConnectable As Long
    wlanNotConnectableReason As Long
    uNumberOfPhyTypes As Long
    dot11PhyTypes(7) As Long
    bMorePhyTypes As Long           ' bMorePhyTypes is set to TRUE if the PHY types for the network
                                    ' exceeds WLAN_MAX_PHY_TYPE_NUMBER.
                                    ' In this case, uNumerOfPhyTypes is WLAN_MAX_PHY_TYPE_NUMBER and the
                                    ' first WLAN_MAX_PHY_TYPE_NUMBER PHY types are returned.
    wlanSignalQuality As Long
    bSecurityEnabled As Long
    dot11DefaultAuthAlgorithm As Long
    dot11DefaultCipherAlgorithm As Long
    dwFlags As Long
    dwReserved As Long
End Type
'628 bytes total



'typedef struct _WLAN_AVAILABLE_NETWORK_LIST {
'  DWORD                  dwNumberOfItems;
'  DWORD                  dwIndex;
'  WLAN_AVAILABLE_NETWORK Network[1];
'} WLAN_AVAILABLE_NETWORK_LIST, *PWLAN_AVAILABLE_NETWORK_LIST;


Public Type WLAN_AVAILABLE_NETWORK_LIST
    dwNumberOfItems As Long
    dwIndex As Long
    Network As WLAN_AVALIABLE_NETWORK
End Type



























