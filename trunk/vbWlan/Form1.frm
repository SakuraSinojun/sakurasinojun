VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3120
   ClientLeft      =   60
   ClientTop       =   420
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3120
   ScaleWidth      =   4680
   StartUpPosition =   3  '´°¿ÚÈ±Ê¡
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Enum WLAN_INTERFACE_STATE
    wlan_interface_state_not_ready = 0
    wlan_interface_state_connected = 1
    wlan_interface_state_ad_hoc_network_formed = 2
    wlan_interface_state_disconnecting = 3
    wlan_interface_state_disconnected = 4
    wlan_interface_state_associating = 5
    wlan_interface_state_discovering = 6
    wlan_interface_state_authenticating = 7
End Enum

Private Type GUID
    data1 As Long
    data2(1) As Byte
    data3(1) As Byte
    data4(7) As Byte
End Type
'16 Bytes total


Private Type WLAN_INTERFACE_INFO
    InterfaceGuid As GUID
    strInterfaceDescription(511) As Byte
    isState As WLAN_INTERFACE_STATE
End Type
' WLAN_INTERFACE_INFO, *PWLAN_INTERFACE_INFO;
'16+512+4=532 bytes total


Private Type WLAN_INTERFACE_INFO_LIST
    dwNumberOfItems As Long
    dwIndex As Long
    InterfaceInfo(1) As WLAN_INTERFACE_INFO
End Type
'WLAN_INTERFACE_INFO_LIST, *PWLAN_INTERFACE_INFO_LIST;
'4+4+532=540 bytes total


Private Declare Function WlanOpenHandle Lib "Wlanapi.dll" ( _
    ByVal dwClientVersion As Long, _
    ByVal pReserved As Long, _
    ByRef pdwNegotiatedVersion As Long, _
    ByRef phClientHandle As Long _
    ) As Long
    
    
Private Declare Function WlanEnumInterfaces Lib "Wlanapi.dll" (ByVal hClientHandle As Long, ByVal pReserved As Long, ByRef ppInterfaceList As Long) As Long

'out       PWLAN_INTERFACE_INFO_LIST *ppInterfaceList
Private Enum WLAN_CONNECTION_MODE
    wlan_connection_mode_profile
    wlan_connection_mode_temporary_profile
    wlan_connection_mode_discovery_secure
    wlan_connection_mode_discovery_unsecure
    wlan_connection_mode_auto
    wlan_connection_mode_invalid
End Enum




Private Type DOT11_SSID
    uSSIDLength As Long
    ucSSID(31) As Byte
End Type


Private Type NDIS_OBJECT_HEADER
    Type As Byte
    Revision As Byte
    Size As Integer
End Type



Private Type DOT11_BSSID_LIST
    Header As NDIS_OBJECT_HEADER
    uNumOfEntries As Long
    uTotalNumOfEntries As Long
    BSSIDs(5) As Byte                   'DOT11_MAC_ADDRESS  BSSIDs[1];
                                        'The DOT11_MAC_ADDRESS types are used to define an IEEE media access control (MAC) address.
                                    
                                        'typedef UCHAR DOT11_MAC_ADDRESS[6];
                                    
                                        'typedef DOT11_MAC_ADDRESS* PDOT11_MAC_ADDRESS;
End Type




Private Enum DOT11_BSS_TYPE
        dot11_BSS_type_infrastructure = 1
        dot11_BSS_type_independent = 2
        dot11_BSS_type_any = 3
End Enum


Private Type WLAN_CONNECTION_PARAMETERS
    wlanConnectionMode As WLAN_CONNECTION_MODE
    strProfile As Long
    pDot11Ssid As Long                      'pointer to DOT11_SSID
    pDesiredBssidList As Long               'pointer to DOT11_BSSID_LIST
    dot11BssType As DOT11_BSS_TYPE
    dwFlags As Long
End Type
    
         'WlanConnect
Private Declare Function WlanConnect Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByRef pInterfaceGuid As GUID, _
    ByRef pConnectionParameters As WLAN_CONNECTION_PARAMETERS, _
    ByVal pReserved As Long _
    ) As Long

Private Declare Function WlanDisconnect Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByRef pInterfaceGuid As GUID, _
    ByVal pReserved As Long _
    ) As Long
    
    
    

Private Sub Form_Load()

End Sub
