#pragma once

class CQQMsg
{
public:
	CQQMsg(void);
	CQQMsg(wchar_t *);

	~CQQMsg(void);

	wchar_t * GetLastMessage();
	wchar_t * GetSender();
	wchar_t * GetMessage();

private:
	
	inline bool IsNum(wchar_t * ch);
	bool IsTime(wchar_t *data);

	wchar_t * m_QQMsg;
	wchar_t * m_LastMessage;
	wchar_t * m_Sender;
	wchar_t * m_Message;


};
