#pragma once

class CQuestion
{
public:
	CQuestion(void);
	CQuestion(wchar_t *);
	virtual ~CQuestion(void);

	int GetQuestionLength();
	long GetQuestion(wchar_t *);

	static struct Answer
	{
		bool A;
		bool B;
		bool C;
		bool D;
	};

	Answer * GetAnswer();

	void SetAnswer(bool A,bool B,bool C,bool D);
	bool Check();


private:
	wchar_t * szCaption;
	Answer m_Answer;

	Answer m_CorrectAnswer;


};
