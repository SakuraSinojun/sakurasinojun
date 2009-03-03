#include "StdAfx.h"
#include "QQMsg.h"

CQQMsg::CQQMsg(void)
{
	m_QQMsg=new wchar_t[1];
	memset(m_QQMsg,0,1);
}

CQQMsg::~CQQMsg(void)
{
	delete m_QQMsg;
	delete this->m_LastMessage ;
	delete this->m_Sender ;
	delete this->m_Message ;

}
CQQMsg::CQQMsg(wchar_t * data)
{
	CString tmp=CString(data);
	int l=tmp.GetLength ();
	tmp.Empty ();

	m_QQMsg=new wchar_t[l+1];
	memset(m_QQMsg,0,(l+1)*sizeof(wchar_t));
	memcpy(m_QQMsg,data,l*sizeof(wchar_t));

	
	wchar_t * temp;
	wchar_t * temp_time=new wchar_t[9];

	int i;
	int j;
	
	wchar_t * CR=(wchar_t *)_T("\n");


	if(l<10)
	{
		delete temp_time;
		return ;
	}

	temp=new wchar_t[l+1];
	memset(temp,0,(l+1)*sizeof(wchar_t));
	memcpy(temp,m_QQMsg,l*sizeof(wchar_t));

	for(i=l-8;i>=0;i--)
	{
		memset(temp_time,0,9*sizeof(wchar_t));
		memcpy(temp_time,(temp+i),8*sizeof(wchar_t));
		if(IsTime(temp_time))
		{
			//if(*(temp+i-1)==(wchar_t)" ")
			//{
				for(j=i;j>=0;j--)
				{
					if(*(temp+j)==*CR)
					{
						m_Sender=new wchar_t[i-j];
						memset(m_Sender,0,(i-j)*sizeof(wchar_t));
						memcpy(m_Sender,temp+j+1,(i-j-1)*sizeof(wchar_t));

						m_Message=new wchar_t[l-(i+9)];
						memset(m_Message,0,(l-i-9)*sizeof(wchar_t));
						memcpy(m_Message,temp+i+10,(l-i-10)*sizeof(wchar_t));

						this->m_LastMessage =new wchar_t [l-j+1];
						memset(m_LastMessage,0,(l-j+1)*sizeof(wchar_t));
						memcpy(m_LastMessage,temp+j+1,(l-j)*sizeof(wchar_t));
						
						delete temp;
						delete temp_time;
						return ;
					}
				}
			//}
		}
	}
	delete temp;
	delete temp_time;
	return ;

}


wchar_t * CQQMsg::GetLastMessage()
{

	return this->m_LastMessage ;
}

wchar_t * CQQMsg::GetSender()
{
	return this->m_Sender ;
}

wchar_t * CQQMsg::GetMessage()
{
	return this->m_Message ;
}


inline bool CQQMsg::IsNum(wchar_t * ch) 
{
	wchar_t * num=(wchar_t *)_T("0123456789");
	int i;
	
	for(i=0;i<=9;i++)
	{
		if(*ch==*(num+i))
		{
			return true;
		}
	}
	return false;
}

bool CQQMsg::IsTime (wchar_t *data)
{
	CString tmp=CString(data);
	if(tmp.GetLength() !=8) 
	{
		tmp.Empty ();
		return false;
	}
	tmp.Empty ();

	wchar_t * t=(wchar_t *)_T(":");

	if(*t==*(data+2) && *t==*(data+5))
	{
		if(IsNum((data)) && IsNum((data+1)) && IsNum((data+3)) && IsNum((data+4)) && IsNum((data+6)) && IsNum((data+7)))
		{
			return true;
		}
	}
	
	return false;

}
