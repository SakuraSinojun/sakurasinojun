/////////////////////////////////////////////////////////////////////////////
// CChart view


typedef struct tagCHARTPOINT
{
	UINT y;
	tagCHARTPOINT *next;
	tagCHARTPOINT *prev;
}CHARTPOINT,*PCHARTPOINT;


class CChart : public CWnd
{
public:
	CChart();           // protected constructor used by dynamic creation
	virtual ~CChart();
	DECLARE_DYNCREATE(CChart)

// Attributes
public:

	int m_sWidth;


// Operations
public:
	void SetSquareWIdth(int width);
	void DrawCoordinates();
	CSize GetCanvasSize();
	void SetCanvasSize(CSize size);

	void AddData(char data);

private:
	
	CSize m_CanvasSize;
	

	CHARTPOINT * m_FirstPoint;
	CHARTPOINT * m_LastPoint;


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CChart)
	protected:
	//}}AFX_VIRTUAL

// Implementation
protected:
	

	// Generated message map functions
protected:
	//{{AFX_MSG(CChart)
	afx_msg void OnPaint();
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnCancelMode();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////
