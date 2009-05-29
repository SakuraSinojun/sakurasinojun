// Chart.cpp : implementation file
//

#include "stdafx.h"
#include "Chart.h"


/////////////////////////////////////////////////////////////////////////////
// CChart



IMPLEMENT_DYNCREATE(CChart, CWnd)

CChart::CChart()
{
	m_CanvasSize=CSize(120,255);
	m_sWidth=5;
	m_FirstPoint=NULL;
	m_LastPoint=NULL;

}

CChart::~CChart()
{
	CHARTPOINT * tmpPoint=m_FirstPoint;
	while(tmpPoint!=NULL)
	{
		m_FirstPoint=tmpPoint->next ;
		delete tmpPoint;
		tmpPoint=m_FirstPoint;
	}

}


BEGIN_MESSAGE_MAP(CChart, CWnd)
	//{{AFX_MSG_MAP(CChart)
	ON_WM_PAINT()
	ON_WM_SIZE()
	ON_WM_CANCELMODE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CChart drawing

/////////////////////////////////////////////////////////////////////////////
// CChart diagnostics


/////////////////////////////////////////////////////////////////////////////
// CChart message handlers
void CChart::AddData(char data)
{
	
	//数据存放到一个链表中。链表最大长度125。
	


	//链表实现
	CHARTPOINT * tmpPoint =new CHARTPOINT;
//	CHARTPOINT * tmp;

	memset(&(tmpPoint->y),0,sizeof(int));
	memcpy(&(tmpPoint->y),&data,1);
	tmpPoint->prev =NULL;
	tmpPoint->next =NULL;

	if(m_LastPoint==NULL)
	{
		m_FirstPoint=tmpPoint;
		m_LastPoint=tmpPoint;
	}else{
		m_LastPoint->next =tmpPoint;
		tmpPoint->prev =m_LastPoint;
		m_LastPoint=tmpPoint;
	}

	int count=0;
	tmpPoint=m_FirstPoint;
	while(tmpPoint!=NULL)
	{
		count++;
		tmpPoint=tmpPoint->next ;
	}

	//最大长度
	if(count>125)
	{
		tmpPoint=m_FirstPoint;
		for(int i=1;i<=count-125;i++)
		{
			m_FirstPoint=tmpPoint->next;
			delete tmpPoint;
			tmpPoint=m_FirstPoint;
		}

	}


	//绘图
	this->Invalidate (TRUE);

}




void CChart::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
	
	// TODO: Add your message handler code here
	
	// Do not call CWnd::OnPaint() for painting messages


	CRect rect;
	CRect xaxis;
	CRect yaxis;
	int i;
	char temp[100];

	this->GetClientRect (rect);

	CPen *cPen;
	CBrush *brush;


	
	xaxis.left =20;
	xaxis.right =20;
	xaxis.top =20;
	xaxis.bottom =rect.bottom -20;

	yaxis.left =20;
	yaxis.top =rect.bottom -20;
	yaxis.bottom=rect.bottom -20;
	yaxis.right =rect.right -20;


	cPen=CPen::FromHandle (::CreatePen (PS_SOLID,1,RGB(0,255,0)));
	brush =CBrush::FromHandle (::CreateSolidBrush (RGB(0,255,0)));

	//画刷，画笔。
	dc.SelectObject (cPen);
	dc.SelectObject (brush);




	//绘制坐标轴
	dc.MoveTo (xaxis.left -3,xaxis.top +10);
	dc.LineTo (xaxis.left,xaxis.top);
	dc.MoveTo (xaxis.left +3,xaxis.top +10);
	dc.LineTo (xaxis.left ,xaxis.top);
	dc.LineTo (xaxis.right ,xaxis.bottom);
	dc.LineTo (yaxis.right ,yaxis.bottom);
	dc.LineTo (yaxis.right -10,yaxis.bottom -3);
	dc.MoveTo (yaxis.right ,yaxis.bottom);
	dc.LineTo (yaxis.right -10,yaxis.bottom +3);

	dc.SetBkColor (0);
	dc.SetTextColor (RGB(0,255,0));
	wsprintf(temp,"%d",this->m_CanvasSize.cy );
	dc.DrawText (temp,lstrlen(temp),CRect(0,5,40,21),DT_LEFT | DT_TOP |DT_VCENTER | DT_WORDBREAK);
	wsprintf(temp,"%d",this->m_CanvasSize.cx);
	dc.DrawText (temp,lstrlen(temp),CRect(yaxis.right -20,yaxis.bottom +3,yaxis.right +20,yaxis.bottom +19),DT_LEFT | DT_TOP |DT_VCENTER | DT_WORDBREAK);
	
	int cw=(yaxis.Width ()-10)*this->m_sWidth/(this->m_CanvasSize.cx);
	for(i=0;i<=yaxis.Width ()-10;i+=cw)
	{
		dc.MoveTo (yaxis.left +i,yaxis.top);
		dc.LineTo (yaxis.left +i,yaxis.top -3);
	}

	if(this->m_CanvasSize .cy =255)
	{
		cw=(xaxis.Height ()-10)/((this->m_CanvasSize.cy+1)/16);
	}else{
		cw=(xaxis.Height ()-10)/((this->m_CanvasSize.cy+1)/4096);
	}

	for(i=0;i<=xaxis.Height ()-10;i+=cw)
	{
		dc.MoveTo (20,xaxis.bottom -i);
		dc.LineTo (23,xaxis.bottom -i);
	}


	//绘制曲线
	//this->m_CanvasSize.cx 横向点数..
	CHARTPOINT * tmpFirstPoint=NULL;
	CHARTPOINT * tmpPoint=m_LastPoint;
	i=this->m_CanvasSize.cx;
	
	while(tmpPoint!=NULL && i>0)
	{
		tmpFirstPoint=tmpPoint;
		tmpPoint=tmpPoint->prev;
		i--;
	}
	//tmpFirstPoint=tmpPoint;
	tmpPoint=tmpFirstPoint;

	float ii=0;
	int y;
	float cww=(float)((yaxis.Width ()-10))/(float)((this->m_CanvasSize.cx));

	if(tmpPoint!=NULL)
	{
		y=xaxis.bottom -((xaxis.Height ()-10)*tmpPoint->y)/this->m_CanvasSize.cy;
		ii=ii+cww;
		dc.MoveTo (20+(int)ii,y);
		//dc.LineTo (20+(int)ii,y);
		tmpPoint=tmpPoint->next ;
	}


	while(tmpPoint!=NULL)
	{
		y=xaxis.bottom -((xaxis.Height ()-10)*tmpPoint->y)/this->m_CanvasSize.cy;
		ii=ii+cww;
		dc.LineTo (20 +(int)ii, y);
		tmpPoint=tmpPoint->next ;
	}


	cPen->DeleteObject ();
	brush->DeleteObject ();

	
}

void CChart::SetCanvasSize(CSize size)
{

	m_CanvasSize=size;
	this->Invalidate (TRUE);

}

CSize CChart::GetCanvasSize()
{
	return this->m_CanvasSize;
}

void CChart::DrawCoordinates()
{


}

void CChart::SetSquareWIdth(int width)
{
	this->m_sWidth =width;
}

void CChart::OnSize(UINT nType, int cx, int cy) 
{
	CWnd::OnSize(nType, cx, cy);
	
	// TODO: Add your message handler code here
		this->Invalidate ();
}

void CChart::OnCancelMode() 
{
	CWnd::OnCancelMode();
	
	// TODO: Add your message handler code here

}
