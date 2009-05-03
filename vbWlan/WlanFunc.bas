Attribute VB_Name = "WlanFunc"
Option Explicit





Public Declare Function WlanOpenHandle Lib "Wlanapi.dll" ( _
    ByVal dwClientVersion As Long, _
    ByVal pReserved As Long, _
    ByRef pdwNegotiatedVersion As Long, _
    ByRef phClientHandle As Long _
    ) As Long
  '__in          DWORD dwClientVersion,
  'PVOID pReserved,
 ' __out         PDWORD pdwNegotiatedVersion,
 ' __out         PHANDLE phClientHandle


Public Declare Function WlanCloseHandle Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByVal pReserved As Long) As Long

'DWORD WINAPI WlanCloseHandle(
'  __in        HANDLE hClientHandle,
'  __reserved  PVOID pReserved
');

Public Declare Sub WlanFreeMemory Lib "Wlanapi.dll" (ByRef pMemory As Any)


    
Public Declare Function WlanEnumInterfaces Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByVal pReserved As Long, _
    ByRef ppInterfaceList As Long _
    ) As Long

  '__in          HANDLE hClientHandle,
  '__in          PVOID pReserved,
  '__out         PWLAN_INTERFACE_INFO_LIST* ppInterfaceList


Public Declare Function WlanQueryInterface Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByRef pInterfaceGuid As Long, _
    ByVal OpCode As WLAN_INTF_OPCODE, _
    ByVal pReserved As Long, _
    ByRef pdwDataSize As Long, _
    ByRef ppData As Long, _
    ByRef pWlanOpcodeValueType As WLAN_OPCODE_VALUE_TYPE _
    ) As Long
    
 ' __in          HANDLE hClientHandle,
  '__in          const GUID* pInterfaceGuid,
 ' __in          WLAN_INTF_OPCODE OpCode,
 ' PVOID pReserved,
 ' __out         PDWORD pdwDataSize,
 ' __out         PVOID* ppData,
  '__out_opt     PWLAN_OPCODE_VALUE_TYPE pWlanOpcodeValueType



Public Declare Function WlanSetInterface Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByRef pInterfaceGuid As GUID, _
    ByVal OpCode As WLAN_INTF_OPCODE, _
    ByVal dwDataSize As Long, _
    ByRef pData As Any, _
    ByVal pReserved As Long _
    ) As Long
    
  '__in          HANDLE hClientHandle,
  '__in          const GUID* pInterfaceGuid,
  '__in          WLAN_INTF_OPCODE OpCode,
  '__in          DWORD dwDataSize,
  '__in          const PVOID pData,

Public Declare Function WlanScan Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByRef pInterfaceGuid As GUID, _
    ByRef pDot11Ssid As DOT11_SSID, _
    ByRef pIeData As WLAN_RAW_DATA, _
    ByVal pReserved As Long _
    ) As Long
    

  '__in          HANDLE hClientHandle,
  '__in          const GUID* pInterfaceGuid,
  '__in_opt      const PDOT11_SSID pDot11Ssid,
  '__in_opt      const PWLAN_RAW_DATA pIeData,
  'PVOID pReserved


Public Declare Function WlanGetAvailableNetworkList Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByRef pInterfaceGuid As GUID, _
    ByVal dwFlags As Long, _
    ByVal pReserved As Long, _
    ByRef ppAvailableNetworkList As Long _
    ) As Long


 ' __in          HANDLE hClientHandle,
  '__in          const GUID* pInterfaceGuid,
  '__in          DWORD dwFlags,
  'PVOID pReserved,
 ' __out         PWLAN_AVAILABLE_NETWORK_LIST* ppAvailableNetworkList


Public Declare Function WlanConnect Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByRef pInterfaceGuid As GUID, _
    ByRef pConnectionParameters As WLAN_CONNECTION_PARAMETERS, _
    ByVal pReserved As Long _
    ) As Long
 ' __in          HANDLE hClientHandle,
 ' __in          const GUID* pInterfaceGuid,
 ' __in          const PWLAN_CONNECTION_PARAMETERS pConnectionParameters,
 ' PVOID pReserved

Public Declare Function WlanDisconnect Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByRef pInterfaceGuid As GUID, _
    ByVal pReserved As Long _
    ) As Long
    
    
    
 ' __in          HANDLE hClientHandle,
'  __in          const GUID* pInterfaceGuid,
 ' PVOID pReserved


Public Declare Function WlanGetProfile Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByRef pInterfaceGuid As GUID, _
    ByRef strProfileName As Long, _
    ByVal pReserved As Long, _
    ByRef pstrProfileXml As Long, _
    ByRef pdwFlags As Long, _
    ByRef pdwGrantedAccess As Long _
    ) As Long
 


  '__in          HANDLE hClientHandle,
  '__in          const GUID* pInterfaceGuid,
  '__in          LPCWSTR strProfileName,
  '__in          PVOID pReserved,
  '__out         LPWSTR* pstrProfileXml,
  '__out_opt     DWORD* pdwFlags,
  '__out_opt     PDWORD pdwGrantedAccess
  
Public Declare Function WlanSetProfile Lib "Wlanapi.dll" ( _
    ByVal hClientHandle As Long, _
    ByRef pInterfaceGuid As GUID, _
    ByVal dwFlags As Long, _
    ByRef strProfileXml As Long, _
    ByRef strAllUserProfileSecurity As Long, _
    ByVal bOverwrite As Boolean, _
    ByVal pReserved As Long, _
    ByRef pdwReasonCode As Long _
    ) As Long
    


  '__in          HANDLE hClientHandle,
  '__in          const GUID* pInterfaceGuid,
  '__in          DWORD dwFlags,
  '__in          LPCWSTR strProfileXml,
  '__in_opt      LPCWSTR strAllUserProfileSecurity,
  '__in          BOOL bOverwrite,
  '__in          PVOID pReserved,
  '__out         DWORD* pdwReasonCode





























