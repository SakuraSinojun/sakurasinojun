// ExamView.cpp : CExamView 类的实现
//

#include "stdafx.h"
#include "Exam.h"

#include "ExamDoc.h"
#include "ExamView.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#endif




wchar_t * m_QList[4096];
int m_QSerial[4096];
CQuestion *m_cQuestList[4096];



// CExamView

IMPLEMENT_DYNCREATE(CExamView, CView)

BEGIN_MESSAGE_MAP(CExamView, CView)
	ON_WM_SIZE()
	ON_WM_WINDOWPOSCHANGED()
	ON_COMMAND(IDC_BUTTONSTARTEXAM,StartExam)
	ON_COMMAND(IDC_BUTTONSETUPEXAM,SetupExam)
	ON_COMMAND(IDC_BUTTONPREV,PrevQuestion)
	ON_COMMAND(IDC_BUTTONNEXT,NextQuestion)
	ON_COMMAND(IDC_CHECKA,OnCheck)
	ON_COMMAND(IDC_CHECKB,OnCheck)
	ON_COMMAND(IDC_CHECKC,OnCheck)
	ON_COMMAND(IDC_CHECKD,OnCheck)
	ON_COMMAND(IDC_BUTTONCALC,CalcResult)
	//	ON_WM_LBUTTONUP()
	//ON_WM_VSCROLL()
	ON_WM_VSCROLL()
	ON_WM_TIMER()
	ON_WM_MOUSEWHEEL()
END_MESSAGE_MAP()

// CExamView 构造/析构

CExamView::CExamView()
:m_ExamStatus(STATUS_ZERO),
m_iQuestionCount(0),
m_txtPosY(0)
{
	// TODO: 在此处添加构造代码

	m_szQCont=new wchar_t[10240];
	memset(m_szQCont,0,10240*sizeof(wchar_t));

}

CExamView::~CExamView()
{
}

BOOL CExamView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: 在此处通过修改
	//  CREATESTRUCT cs 来修改窗口类或样式

	return CView::PreCreateWindow(cs);
}

// CExamView 绘制

void CExamView::OnDraw(CDC* pDC)
{
	CExamDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;
	// TODO: 在此处为本机数据添加绘制代码
	
	CRect rcClient;

	wchar_t * temp=new wchar_t[1024];
	memset(temp,0,1024*sizeof(wchar_t));

	if(this->m_ExamStatus ==STATUS_ZERO)
	{
	}else if(this->m_ExamStatus ==STATUS_PREEXAM)
	{
	}else if(this->m_ExamStatus ==STATUS_SETUP)
	{
		::wsprintf (temp,_T("题库中现有题目总数:      %d."),this->m_iQuestionCount);
		pDC->TextOutW (100,100,temp,lstrlen(temp));
		pDC->TextOutW (100,150,_T("请输入试题数量:"));
		pDC->TextOutW (500,100,_T("登陆用户名"));
		pDC->TextOutW (500,150,_T("学号"));
		pDC->TextOutW (100,250,_T("考试用时"));
		pDC->TextOutW (250,250,_T("分钟"));
	}else if(m_ExamStatus==STATUS_STARTINGEXAM)
	{
		this->GetClientRect (rcClient);
		rcClient.left =rcClient.Width ()/2;
		rcClient.top =rcClient.Height ()/2;
		pDC->TextOutW (rcClient.left -80,rcClient.top -20,_T("正在准备试题，请稍候。"));

	}else if(this->m_ExamStatus ==STATUS_EXAMING)
	{
		//pDC->TextOutW (100,m_txtPosY,m_szQCont,lstrlen(m_szQCont));
		this->GetClientRect (rcClient);
		rcClient.left =50;
		rcClient.right-=50;
		rcClient.top =m_txtPosY;
		rcClient.bottom -=200;

		//HFONT  hFont=ShowFont(pDC->m_hDC ,_T("黑体"),16,12); 		
		//HFONT hOldFont=(HFONT)pDC->SelectObject (hFont);

		pDC->DrawTextW (m_szQCont,lstrlen(m_szQCont),rcClient,DT_WORDBREAK | DT_LEFT | DT_TOP);

		//pDC->SelectObject (hOldFont);

		pDC->MoveTo (0,rcClient.bottom );
		pDC->LineTo (rcClient.right +50,rcClient.bottom );
		::wsprintf (temp,_T("%d/%d"),this->m_iQuestIndex+1, this->m_iQuestionCount);
		pDC->TextOutW (rcClient.right ,rcClient.bottom ,temp,lstrlen(temp));
		
		
		
		
		CRect rect;
	
		this ->GetClientRect (rect);
	
		pDC->TextOutW (100,rect.bottom -100,L"剩余时间",4);
		::wsprintf(temp,_T("%d分%d秒"),(int)(this->m_LeftTime/60),this->m_LeftTime -60 * (int)(this->m_LeftTime /60));
		pDC->TextOutW (100,rect.bottom-70,temp,lstrlen(temp));

	}

	delete temp;
}


// CExamView 诊断

#ifdef _DEBUG
void CExamView::AssertValid() const
{
	CView::AssertValid();
}

void CExamView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CExamDoc* CExamView::GetDocument() const // 非调试版本是内联的
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CExamDoc)));
	return (CExamDoc*)m_pDocument;
}
#endif //_DEBUG


void CExamView::OnInitialUpdate ()
{
	CView::OnInitialUpdate ();

	m_ExamStatus=STATUS_PREEXAM;

	CRect rcClient;
	CRect rcSetup;
	CRect rcStart;
	CRect rcQCount;
	CRect rcName;
	CRect rcID;
	CRect rcCheck;
	CRect rcNext;
	CRect rcScroll;
	CRect rcTime;
	//CRect rcEditQuest;

	this->GetClientRect (rcClient);

	rcSetup.left =rcClient.Width() /2-100;
	rcSetup.right =rcSetup.left +200;
	rcSetup.top =rcClient.Height() /2-50;
	rcSetup.bottom =rcSetup.top +100;

	rcStart.left =rcSetup.left ;
	rcStart.top =400;
	rcStart.right =rcSetup.right ;
	rcStart.bottom =450;

	rcQCount.left =250;
	rcQCount.top =149;
	rcQCount.right =300;
	rcQCount.bottom =170;

	rcName=CRect(600,99,750,120);
	rcID=CRect(600,149,750,170);
	rcTime=CRect(175,250,225,270);

	rcCheck.left =100;
	rcCheck.top =rcClient.bottom -170;
	rcCheck.right =rcCheck.left +(rcClient.Width ()-350)/4;
	rcCheck.bottom =rcCheck.top +50;

	rcScroll=CRect(rcClient.Width ()+18,0,rcClient.right ,rcClient.bottom -200);

	//rcEditQuest=CRect(50,50,rcClient.right -50,rcClient.bottom -200);

	m_ButtonSetup=new CButton();
	m_ButtonStart=new CButton();
	m_EditQCount=new CNumEdit();
	m_EditName=new CEdit();
	m_EditID=new CEdit();
	m_CheckA=new CButton();
	m_CheckB=new CButton();
	m_CheckC=new CButton();
	m_CheckD=new CButton();
	m_ButtonNext=new CButton();
	m_ButtonPrev=new CButton();
	m_ButtonCalc=new CButton();
	//m_EditQuest=new CEdit();
	m_ScrollBar=new CScrollBar();
	m_EditExamTime=new CNumEdit();

	m_ButtonSetup->Create(_T("试题设置"),WS_VISIBLE | BS_PUSHBUTTON,rcSetup,this,IDC_BUTTONSETUPEXAM);
	m_ButtonStart->Create(_T("开始考试"), BS_PUSHBUTTON,rcStart,this,IDC_BUTTONSTARTEXAM);
	this->m_EditQCount ->Create(ES_CENTER | WS_EX_CLIENTEDGE | WS_CHILDWINDOW | WS_BORDER ,rcQCount,this,IDC_EDITQCOUNT);
	this->m_EditName ->Create(ES_CENTER | WS_EX_CLIENTEDGE |WS_CHILDWINDOW|WS_BORDER,rcName,this,IDC_EDITNAME);
	this->m_EditID ->Create(ES_CENTER | WS_EX_CLIENTEDGE |WS_CHILDWINDOW|WS_BORDER,rcID,this,IDC_EDITID);
	this->m_EditExamTime->Create(ES_CENTER | WS_EX_CLIENTEDGE | WS_CHILDWINDOW | WS_BORDER,rcTime,this,IDC_EDITEXAMTIME);
	
	this->m_CheckA ->Create(_T("选择答案A"),BS_AUTOCHECKBOX  | BS_PUSHLIKE ,rcCheck,this,IDC_CHECKA);
	
	rcCheck.left =rcCheck.right +50;
	rcCheck.right =rcCheck.left +(rcClient.Width ()-350)/4;
	rcNext.left =rcCheck.left;
	rcNext.right =rcCheck.right ;
	rcNext.top=rcCheck.bottom +20 ;
	rcNext.bottom=rcNext.top  +50;
	this->m_CheckB ->Create(_T("选择答案B"),BS_AUTOCHECKBOX  | BS_PUSHLIKE ,rcCheck,this,IDC_CHECKB);
	this->m_ButtonCalc->Create(_T("计算分数"), BP_PUSHBUTTON,rcNext,this,IDC_BUTTONCALC);

	rcCheck.left =rcCheck.right +50;
	rcCheck.right =rcCheck.left +(rcClient.Width ()-350)/4;
	rcNext.left =rcCheck.left;
	rcNext.right =rcCheck.right ;
	rcNext.top=rcCheck.bottom +20 ;
	rcNext.bottom=rcNext.top  +50;
	this->m_CheckC ->Create(_T("选择答案C"),BS_AUTOCHECKBOX  | BS_PUSHLIKE ,rcCheck,this,IDC_CHECKC);
	this->m_ButtonPrev->Create(_T("前一道题"), BP_PUSHBUTTON,rcNext,this,IDC_BUTTONPREV);

	rcCheck.left =rcCheck.right +50;
	rcCheck.right =rcCheck.left +(rcClient.Width ()-350)/4;
	rcNext.left =rcCheck.left;
	rcNext.right =rcCheck.right ;
	rcNext.top=rcCheck.bottom +20 ;
	rcNext.bottom=rcNext.top  +50;
	this->m_CheckD ->Create(_T("选择答案D"),BS_AUTOCHECKBOX  | BS_PUSHLIKE ,rcCheck,this,IDC_CHECKD);
	this->m_ButtonNext->Create(_T("后一道题"), BP_PUSHBUTTON,rcNext,this,IDC_BUTTONNEXT);

	this->m_ScrollBar ->Create(WS_VISIBLE| SBS_VERT ,rcScroll,this,IDC_SCROLLBAR);
	this->m_ScrollBar ->SetScrollRange (0,600,true);

	

	//this->m_EditQuest ->Create (WS_VISIBLE |WS_BORDER |ES_LEFT|ES_MULTILINE |ES_READONLY|ES_AUTOVSCROLL |WS_EX_RIGHTSCROLLBAR,rcEditQuest,this,IDC_EDITQUEST);

}


// CExamView 消息处理程序

void CExamView::OnSize(UINT nType, int cx, int cy)
{
	CView::OnSize(nType, cx, cy);

	// TODO: 在此处添加消息处理程序代码


}

void CExamView::OnWindowPosChanged(WINDOWPOS* lpwndpos)
{
	CView::OnWindowPosChanged(lpwndpos);

	// TODO: 在此处添加消息处理程序代码
	
	CRect rcClient;
	CRect rcSetup;
	CRect rcStart;
	CRect rcCheck;
	CRect rcNext;
	CRect rcScroll;


	this->GetClientRect (rcClient);

	rcSetup.left =rcClient.Width() /2-100;
	rcSetup.right =rcSetup.left +200;
	rcSetup.top =rcClient.Height() /2-50;
	rcSetup.bottom =rcSetup.top +100;

	rcStart.left =rcClient.Width ()/2-100;
	rcStart.right =rcStart.left +200;
	rcStart.top =400;
	rcStart.bottom =450;

	rcCheck.left =100;
	rcCheck.top =rcClient.bottom -170;
	rcCheck.right =rcCheck.left +(rcClient.Width ()-350)/4;
	rcCheck.bottom =rcCheck.top +50;

	rcScroll=CRect(rcClient.Width ()-18,0,rcClient.right ,rcClient.bottom -200);



	if(m_ExamStatus==STATUS_PREEXAM)
	{
		m_ButtonSetup->MoveWindow (rcSetup.left ,rcSetup.top ,rcSetup.Width (),rcSetup.Height (),true);
		m_ButtonStart->MoveWindow (rcStart,true);
	}else if(m_ExamStatus==STATUS_SETUP)
	{
		m_ButtonStart->MoveWindow (rcStart,true);
	}else if(m_ExamStatus==STATUS_EXAMING)
	{
		this->m_CheckA ->MoveWindow (rcCheck,true);

		rcCheck.left =rcCheck.right +50;
		rcCheck.right =rcCheck.left +(rcClient.Width ()-350)/4;
		rcNext.left =rcCheck.left;
		rcNext.right =rcCheck.right ;
		rcNext.top=rcCheck.bottom +20 ;
		rcNext.bottom=rcNext.top  +50;
		this->m_CheckB ->MoveWindow (rcCheck,true);
		this->m_ButtonCalc ->MoveWindow (rcNext,true);

		rcCheck.left =rcCheck.right +50;
		rcCheck.right =rcCheck.left +(rcClient.Width ()-350)/4;
		rcNext.left =rcCheck.left;
		rcNext.right =rcCheck.right ;
		rcNext.top=rcCheck.bottom +20 ;
		rcNext.bottom=rcNext.top  +50;
		this->m_CheckC ->MoveWindow (rcCheck,true);
		this->m_ButtonPrev ->MoveWindow (rcNext,true);

		rcCheck.left =rcCheck.right +50;
		rcCheck.right =rcCheck.left +(rcClient.Width ()-350)/4;
		rcNext.left =rcCheck.left;
		rcNext.right =rcCheck.right ;
		rcNext.top=rcCheck.bottom +20 ;
		rcNext.bottom=rcNext.top  +50;
		this->m_CheckD ->MoveWindow (rcCheck,true);
		this->m_ButtonNext ->MoveWindow (rcNext,true);


		this->m_ScrollBar->MoveWindow(rcScroll,true);	
	}


	

	this->Invalidate(true);

}

//void CExamView::OnLButtonUp(UINT nFlags, CPoint point)
//{
//	// TODO: 在此添加消息处理程序代码和/或调用默认值
//
//	CView::OnLButtonUp(nFlags, point);
//}



void CExamView::StartExam ()
{

	int l;
	wchar_t *temp;
	char * temp_ansi;

	if(m_EditName->GetWindowTextLengthW() ==0 || m_EditID->GetWindowTextLengthW ()==0)
	{
		AfxMessageBox(_T("请填写姓名与学号信息。"));
		return;
	}
	
	l=this->m_EditQCount ->GetWindowTextLengthW ();
	temp=new wchar_t[l+1];
	temp_ansi=new char[l+1];
	memset(temp,0,(l+1)*sizeof(wchar_t));
	this->m_EditQCount ->GetWindowTextW(temp,l+1);
	::WideCharToMultiByte (CP_ACP,0,temp,-1,temp_ansi,l+1,0,false);
	l=atoi(temp_ansi);
	
	delete temp;
	delete temp_ansi;

	if(l>this->m_iQuestionCount || l==0 )
	{
		AfxMessageBox(_T("题目数不符!"));
		return;
	}
	m_iQuestionCount=l;
	

	this->m_ButtonStart->ShowWindow (SW_HIDE);
	this->m_EditID ->ShowWindow (SW_HIDE);
	this->m_EditName ->ShowWindow (SW_HIDE);
	this->m_EditQCount ->ShowWindow (SW_HIDE);
	this->m_EditExamTime ->ShowWindow (SW_HIDE);

	m_ExamStatus=STATUS_STARTINGEXAM;

	this->Invalidate(true);

	StartingExam();

}
void CExamView::SetupExam ()
{
	GetQuestionList();
	
	wchar_t *temp=new wchar_t [10];
	memset(temp,0,20);
	
	::wsprintf(temp,_T("%d"),m_iQuestionCount);
	
	this->m_EditQCount->SetWindowTextW (temp);

	delete temp;

	this->m_EditID ->SetWindowTextW (_T("1234567890123"));
	this->m_EditName->SetWindowTextW(_T("NAME"));
	this->m_EditExamTime ->SetWindowTextW (_T("30"));

	this->m_ButtonSetup ->ShowWindow (SW_HIDE);
	this->m_ButtonStart ->ShowWindow (SW_SHOW);
	this->m_EditQCount ->ShowWindow (SW_SHOW);
	this->m_EditName ->ShowWindow (SW_SHOW);
	this->m_EditID ->ShowWindow (SW_SHOW);
	this->m_EditExamTime ->ShowWindow (SW_SHOW);
	this->m_ExamStatus =STATUS_SETUP;

	this->Invalidate (true);

}


int CExamView::GetQuestionList()
{
	try{
		wchar_t * fname=new wchar_t[1024];
		WIN32_FIND_DATA fd;
		int l;
		HANDLE hSearch;
		wchar_t * filePathName=(wchar_t *)_T("Quest\\*.txt");
		wchar_t * tmpPath=new wchar_t[256];
		char * temp_ansi;
		bool bSearchFinished = false;
	
		this->m_iQuestionCount =0;

		memset(fname,0, 1024 * sizeof(wchar_t));
		ZeroMemory(&fd, sizeof(WIN32_FIND_DATA));
		ZeroMemory(tmpPath, 256 * sizeof(wchar_t) );
	    
	    
		hSearch = FindFirstFile(filePathName, &fd);

		l=::WideCharToMultiByte (CP_ACP,0,fd.cFileName ,-1,NULL,0,0,false);
		temp_ansi=new char[l+2];
		::WideCharToMultiByte (CP_ACP,0,fd.cFileName ,-1,temp_ansi,l,0,false);

		if( (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) && strcmp(temp_ansi, ".") && strcmp(temp_ansi, "..") )       
		{
		}else if(strcmp(temp_ansi, ".") && strcmp(temp_ansi, ".."))
		{
			memset(fname,0,1024*sizeof(wchar_t));
			memcpy(fname,fd.cFileName ,lstrlen(fd.cFileName)*sizeof(wchar_t));
			//::wsprintf(fname,_T("%-50.50s"), fd.cFileName);
			l=lstrlen(fname);
			m_QList[this->m_iQuestionCount]  =new wchar_t[l+1];
			memcpy(m_QList[m_iQuestionCount],fname,(l+1)*sizeof(wchar_t));
			this->m_iQuestionCount ++;	
		}
		
		delete temp_ansi;

		while( !bSearchFinished )
		{
		   if( FindNextFile(hSearch, &fd) )
		   {
		   		l=::WideCharToMultiByte (CP_ACP,0,fd.cFileName ,-1,NULL,0,0,false);
				temp_ansi=new char[l+2];
				::WideCharToMultiByte (CP_ACP,0,fd.cFileName ,-1,temp_ansi,l,0,false);

				if( (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) && strcmp(temp_ansi, ".") && strcmp(temp_ansi, "..") ) 
				{

				}else if( strcmp(temp_ansi, ".") && strcmp(temp_ansi, "..") )
				{
					memset(fname,0,1024*sizeof(wchar_t));
					memcpy(fname,fd.cFileName ,lstrlen(fd.cFileName)*sizeof(wchar_t));
					l=lstrlen(fname);
					m_QList[this->m_iQuestionCount] =new wchar_t[l+1];
					memcpy(m_QList[m_iQuestionCount],fname,(l+1)*sizeof(wchar_t));

					this->m_iQuestionCount ++;
				}
				delete temp_ansi;
		   }else{
			   if( GetLastError() == ERROR_NO_MORE_FILES )
			   {
				  bSearchFinished = true;
			   }else{
				  bSearchFinished = true;
			   }
		   }  
		}
		FindClose(hSearch);
	}catch(...){
	}
	return 0;
}

void CExamView::StartingExam ()
{
	int i;
	int j;
	int r1;
	int r2;
	wchar_t * temp;

	for(i=0;i<4096;i++)
	{
		m_QSerial[i]=i;
	}


	srand((unsigned)time(NULL));

	for(j=1;j<=1000;j++)
	{	
		r1= (int)((this->m_iQuestionCount )/(float)RAND_MAX * rand());
		r2= (int)((this->m_iQuestionCount )/(float)RAND_MAX * rand());
		if(r1==r2)
		{
			j--;
			continue;
		}
		m_QSerial[r1]=m_QSerial[r1]+m_QSerial[r2];
		m_QSerial[r2]=m_QSerial[r1]-m_QSerial[r2];
		m_QSerial[r1]=m_QSerial[r1]-m_QSerial[r2];
	}



	for(j=0;j<m_iQuestionCount;j++)
	{
		m_cQuestList[j]=new CQuestion(m_QList[m_QSerial[j]]);
	}


	i=m_cQuestList[0]->GetQuestionLength ();
	temp=new wchar_t[i+1];
	memset(temp,0,(i+1)*sizeof(wchar_t));
	m_cQuestList[0]->GetQuestion (temp);
	memcpy(m_szQCont,temp,lstrlen(temp)*sizeof(wchar_t));
	this->m_iQuestIndex=0;

	CRect rcClient;
	CRect rcScroll;
	this->GetClientRect (rcClient);
	rcScroll=CRect(rcClient.Width ()-18,0,rcClient.right ,rcClient.bottom -200);
	this->m_ScrollBar ->MoveWindow (rcScroll,true);
	this->ShowWindow (SW_SHOW);


	CString tmp;
	int t;

	this->m_EditExamTime ->GetWindowTextW(tmp);
	t=_wtoi(tmp.GetBuffer(tmp.GetLength ()+1));
	this->m_LeftTime =(DWORD)t*60;
	this->SetTimer (1,1000,NULL);



	this->m_ExamStatus =STATUS_EXAMING;

	this->m_CheckA ->ShowWindow (SW_SHOW);
	this->m_CheckB ->ShowWindow (SW_SHOW);
	this->m_CheckC ->ShowWindow (SW_SHOW);
	this->m_CheckD ->ShowWindow (SW_SHOW);
	this->m_ButtonCalc ->ShowWindow (SW_SHOW);
	this->m_ButtonNext ->ShowWindow (SW_SHOW);
	this->m_ButtonPrev ->ShowWindow (SW_SHOW);
	
	this->Invalidate (true);

	delete temp;

	return ;
}


void CExamView::NextQuestion ()
{

	if(this->m_iQuestIndex ==this->m_iQuestionCount-1)
	{
		AfxMessageBox(_T("已经是最后一题了."));
		return;
	}


	m_iQuestIndex++;
	int l;
	wchar_t * temp;
	l=m_cQuestList[m_iQuestIndex]->GetQuestionLength ();

	temp=new wchar_t[l+1];
	memset(temp,0,(l+1)*sizeof(wchar_t));

	m_cQuestList[m_iQuestIndex]->GetQuestion (temp);
	//m_cQuestList[m_iQuestIndex]->m_CorrectAnswer.ipnt
	memcpy(this->m_szQCont ,temp,(l+1)*sizeof(wchar_t));

	delete temp;



	CQuestion::Answer * Ans;
	Ans=m_cQuestList[m_iQuestIndex]->GetAnswer ();

	m_CheckA->SetCheck (false);
	m_CheckB->SetCheck (false);
	m_CheckC->SetCheck (false);
	m_CheckD->SetCheck (false);

	if(Ans->A)
	{
		m_CheckA->SetCheck (true);
	}
	if(Ans->B)
	{
		m_CheckB->SetCheck (true);
	}
	if(Ans->C)
	{
		m_CheckC->SetCheck (true);
	}
	if(Ans->D)
	{
		m_CheckD->SetCheck (true);
	}


	this->Invalidate(true);

}

void CExamView::PrevQuestion ()
{

	if(this->m_iQuestIndex ==0)
	{
		AfxMessageBox(_T("已经是第一题了."));
		return;
	}


	m_iQuestIndex--;
	int l;
	wchar_t * temp;
	l=m_cQuestList[m_iQuestIndex]->GetQuestionLength ();

	temp=new wchar_t[l+1];
	memset(temp,0,(l+1)*sizeof(wchar_t));

	m_cQuestList[m_iQuestIndex]->GetQuestion (temp);

	memcpy(this->m_szQCont ,temp,(l+1)*sizeof(wchar_t));

	delete temp;

	CQuestion::Answer * Ans;

	Ans=m_cQuestList[m_iQuestIndex]->GetAnswer ();



	m_CheckA->SetCheck (false);
	m_CheckB->SetCheck (false);
	m_CheckC->SetCheck (false);
	m_CheckD->SetCheck (false);

	if(Ans->A)
	{
		m_CheckA->SetCheck (true);
	}
	if(Ans->B)
	{
		m_CheckB->SetCheck (true);
	}
	if(Ans->C)
	{
		m_CheckC->SetCheck (true);
	}
	if(Ans->D)
	{
		m_CheckD->SetCheck (true);
	}



	this->Invalidate(true);

}


void CExamView::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值
 
	CRect rcClient;
	
	SCROLLINFO si;

    ZeroMemory(&si, sizeof(SCROLLINFO));

    si.cbSize = sizeof(SCROLLINFO);
    si.fMask  = SIF_TRACKPOS;
    if (!pScrollBar->GetScrollInfo(&si, SIF_TRACKPOS))
        return;   

	pScrollBar->SetScrollPos(si.nTrackPos);

	this->m_txtPosY =0-si.nTrackPos ;
	

	this->GetClientRect (rcClient);
	rcClient.left =50;
	rcClient.right -=50;
	rcClient.bottom -=200;
	
	this->InvalidateRect(rcClient);

	CView::OnVScroll(nSBCode, nPos, pScrollBar);

}


void CExamView::OnCheck()
{
	BOOL a,b,c,d;
	a=(BOOL)m_CheckA->GetCheck ();
	b=(BOOL)m_CheckB->GetCheck ();
	c=(BOOL)m_CheckC->GetCheck ();
	d=(BOOL)m_CheckD->GetCheck ();

	m_cQuestList[m_iQuestIndex]->SetAnswer (a,b,c,d);

}



void CExamView::CalcResult()
{
	int i;
	int res;
	int ips;

	char *temp_ansi=new char[100];

	i=AfxMessageBox(_T("要计算分数么?"),MB_YESNO | MB_ICONINFORMATION);

	if(i==7) return;

	res=0;
	ips=0;
	for(i=0;i<this->m_iQuestionCount ;i++)
	{
		if(m_cQuestList[i]->Check ()!=0)
		{
			res++;
			ips=ips+m_cQuestList[i]->Check();
		}
	}
	
	memset(temp_ansi,0,100);

	sprintf (temp_ansi,("考试结束，所有题目共有 %d 个,得分 %d。其中，回答正确 %d 个，回答错误 %d 个。正确率 %f%% 。"),this->m_iQuestionCount ,ips,res,m_iQuestionCount-res,100*((float)res)/((float)m_iQuestionCount));
	::MessageBoxA ((HWND)NULL,temp_ansi,"考试结束",MB_OK | MB_ICONINFORMATION);

	delete temp_ansi;

}




HFONT CExamView::ShowFont(HDC pDC, LPCWSTR fontstyle, int fontheight,int fontweight) 
{ 
	//**************************** 
	//功能：设置字体 
	//参数：pDC------------显示设备 
	//      fontstyle-----字体样式 
	//      fontheight----字体高度 
	//      fontweight----字体重量 
	//返回值：新字体 
	//**************************** 
	LOGFONT lf; 
	lf.lfCharSet=GB2312_CHARSET; 
	lf.lfClipPrecision=CLIP_DEFAULT_PRECIS; 
	lf.lfEscapement=0; 
	memcpy(lf.lfFaceName,fontstyle,lstrlen(fontstyle)); //字体样式 
	lf.lfHeight=fontheight; //字体高度 
	lf.lfItalic=FALSE; 
	lf.lfOrientation=0; 
	lf.lfOutPrecision=OUT_DEFAULT_PRECIS; 
	lf.lfPitchAndFamily=FF_DONTCARE | DEFAULT_PITCH; 
	lf.lfQuality=DEFAULT_QUALITY; 
	lf.lfStrikeOut= FALSE; 
	lf.lfUnderline=FALSE; 
	lf.lfWeight=fontweight;//字体重量 
	lf.lfWidth=0; 

	HFONT hFont=::CreateFontIndirect(&lf); 
	return hFont; 
} 

void CExamView::OnTimer(UINT_PTR nIDEvent)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值

	CView::OnTimer(nIDEvent);
	
	int i;
	int res;
	int ips;
	char *temp_ansi=new char[100];

	if(nIDEvent==1)
	{
		this->m_LeftTime--;
		if(m_LeftTime<=0)
		{
			res=0;
			ips=0;
			for(i=0;i<this->m_iQuestionCount ;i++)
			{
				if(m_cQuestList[i]->Check ()!=0)
				{
					res++;
					ips=ips+m_cQuestList[i]->Check();
				}
			}
			
			memset(temp_ansi,0,100);

			sprintf (temp_ansi,("考试结束，所有题目共有 %d 个,得分 %d。其中，回答正确 %d 个，回答错误 %d 个。正确率 %f%% 。"),this->m_iQuestionCount ,ips,res,m_iQuestionCount-res,100*((float)res)/((float)m_iQuestionCount));
			::MessageBoxA ((HWND)NULL,temp_ansi,"考试结束",MB_OK | MB_ICONINFORMATION);
			
			m_LeftTime=0;

			delete temp_ansi;
			this->KillTimer (1);	
		}
	}
	
	CRect rect;
	CRect rc;
	this->GetClientRect (rc);

	
	rect.left =100;
	rect.right =250;
	rect.top =rc.bottom -100;
	rect.bottom =rect.top +50;
	
	this->InvalidateRect(rect,TRUE);
	//this->Invalidate ();
}

BOOL CExamView::OnMouseWheel(UINT nFlags, short zDelta, CPoint pt)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值

	SCROLLINFO si;
    ZeroMemory(&si, sizeof(SCROLLINFO));
    si.cbSize = sizeof(SCROLLINFO);
    si.fMask  = SIF_ALL;

	if (!m_ScrollBar->GetScrollInfo(&si, SIF_TRACKPOS))
        return false;   
	if(zDelta>0)
	{
		if(si.nTrackPos<=0)
			return false;
		m_ScrollBar->SetScrollPos(si.nTrackPos-10);
		this->m_txtPosY =0-si.nTrackPos+10 ;
		
	}else{
		if(si.nTrackPos>=600)
			return false;
		m_ScrollBar->SetScrollPos(si.nTrackPos+10);
		this->m_txtPosY =0-si.nTrackPos -10;
	}	

	this->Invalidate (true);
	//return CWnd::OnMouseWheel(nFlags, zDelta, pt);
	return TRUE;
	//Assert();
}
