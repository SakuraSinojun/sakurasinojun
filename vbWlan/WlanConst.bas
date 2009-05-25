Attribute VB_Name = "WlanConst"
Option Explicit




'flags that control the list returned by WlanGetAvailableNetworkList
'include all ad hoc network profiles in the available network list, regardless they are visible or not
'#define WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_ADHOC_PROFILES           0x00000001
Public Const WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_ADHOC_PROFILES = &H1&

'include all hidden network profiles in the available network list, regardless they are visible or not
'define WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_MANUAL_HIDDEN_PROFILES   0x00000002
Public Const WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_MANUAL_HIDDEN_PROFILES = &H2&





Public Const ERROR_SUCCESS = 0
