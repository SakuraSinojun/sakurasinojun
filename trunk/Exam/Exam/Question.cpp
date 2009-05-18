#include "StdAfx.h"
#include "Question.h"

CQuestion::CQuestion(void)
{
}

CQuestion::~CQuestion(void)
{
	delete this->szCaption ;
}



CQuestion::CQuestion(wchar_t * file)
{
	wchar_t * temp=new wchar_t [40960];
	char * temp_ansi=new char[40960];

	memset(temp,0,40960*sizeof(wchar_t));
	memset(temp_ansi,0,40960*sizeof(char));

	CString path;
	CString tmp;
	CString cap;
	CString Ans;
	CString pnt;
	
	int i,j,k,l;
	
	path=CString(_T("Quest\\")) + CString(file);
	CFile QFile;
	if(QFile.Open (path,CFile::modeRead )==0) return;
	
	QFile.Read (temp_ansi,QFile.GetLength ());
	QFile.Close ();
	
	l=::MultiByteToWideChar (CP_ACP,0,temp_ansi,-1,NULL,0);
	::MultiByteToWideChar (CP_ACP,0,temp_ansi,-1,temp,l+1);

	tmp=CString(temp);

	i=tmp.Find (_T("{Question}"));
	if(i==-1)return;
	j=tmp.Find (_T("{Answer}"));
	if(j==-1)return;
	k=tmp.Find (_T("{Points}"));
	if(k==-1)return;
	
	if(i<j)
	{
		cap=tmp.Mid(i+11,j-i-12);
		Ans=tmp.Mid (j+8,k-j-9);
		pnt=tmp.Mid(k+8);
		m_CorrectAnswer.ipnt= _wtoi(pnt);
	}else{
		Ans=tmp.Mid(i+11,j-i-12);
		cap=tmp.Mid (j+8);

	}
	


	while((i=cap.Find (_T('\t')))>=0)
	{
		cap=cap.Left(i)+CString(_T("        ")) + cap.Mid(i+1); 
	}

	l=cap.GetLength ();
	this->szCaption =new wchar_t[l+1];
	memset(szCaption,0,(l+1)*sizeof(wchar_t));
	memcpy(szCaption,cap.GetBuffer (l+1),(l+1)*sizeof(wchar_t));


	this->m_Answer .A =false;
	this->m_Answer .B =false;
	this->m_Answer .C =false;
	this->m_Answer .D =false;
	this->m_CorrectAnswer .A =false;
	this->m_CorrectAnswer .B =false;
	this->m_CorrectAnswer .C =false;
	this->m_CorrectAnswer .D =false;

	if(Ans.Find (_T("A"))>=0)
	{
		m_CorrectAnswer.A=true;
	}
	if(Ans.Find (_T("B"))>=0)
	{
		m_CorrectAnswer.B=true;
	}
	if(Ans.Find (_T("C"))>=0)
	{
		m_CorrectAnswer.C=true;
	}
	if(Ans.Find (_T("D"))>=0)
	{
		m_CorrectAnswer.D=true;
	}

	delete temp;
	delete temp_ansi;

}


int CQuestion::GetQuestionLength()
{
	return lstrlen(this->szCaption );
}


long CQuestion::GetQuestion(wchar_t * msg)
{
	memcpy(msg,szCaption,lstrlen(szCaption)*sizeof(wchar_t));
	return lstrlen(this->szCaption );
}


CQuestion::Answer * CQuestion::GetAnswer()
{
	return &m_Answer;
}

void CQuestion::SetAnswer (bool A,bool B,bool C,bool D)
{
	this->m_Answer .A =A;
	this->m_Answer .B =B;
	this->m_Answer .C =C;
	this->m_Answer .D =D;

}

int CQuestion::Check() 
{
	if(m_Answer.A==m_CorrectAnswer.A &&
		m_Answer.B==m_CorrectAnswer.B && 
		m_Answer.C==m_CorrectAnswer.C && 
		m_Answer.D==m_CorrectAnswer.D)
		return m_CorrectAnswer.ipnt;
	else
	return 0;

}
