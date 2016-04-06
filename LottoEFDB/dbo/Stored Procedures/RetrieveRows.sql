


CREATE PROCEDURE [dbo].[RetrieveRows](@db int, @op CHAR(2), @targetdrawno int) AS


	IF (@db = 0) 
		BEGIN
			IF @op = '='
				SELECT * FROM Lottery WHERE Lottery.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM Lottery WHERE Lottery.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM Lottery WHERE Lottery.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM Lottery WHERE Lottery.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM Lottery WHERE Lottery.DrawNumber>@targetdrawno;
		END
			
	ELSE IF @db = 1      -- LottoMax
		BEGIN
			IF @op = '='
				SELECT * FROM LottoMax WHERE LottoMax.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM LottoMax WHERE LottoMax.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM LottoMax WHERE LottoMax.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM LottoMax WHERE LottoMax.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM LottoMax WHERE LottoMax.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 2)  -- BC49 
		BEGIN
			IF @op = '='
				SELECT * FROM BC49 WHERE BC49.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM BC49 WHERE BC49.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM BC49 WHERE BC49.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM BC49 WHERE BC49.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM BC49 WHERE BC49.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 3)  -- FloridaLotto 
		BEGIN
			IF @op = '='
				SELECT * FROM FloridaLotto WHERE FloridaLotto.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM FloridaLotto WHERE FloridaLotto.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM FloridaLotto WHERE FloridaLotto.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM FloridaLotto WHERE FloridaLotto.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM FloridaLotto WHERE FloridaLotto.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 4)  -- MegoMillions 
		BEGIN
			IF @op = '='
				SELECT * FROM MegaMillions WHERE MegaMillions.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM MegaMillions WHERE MegaMillions.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM MegaMillions WHERE MegaMillions.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM MegaMillions WHERE MegaMillions.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM MegaMillions WHERE MegaMillions.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 5)  -- MegaMillions_MegaBall 
		BEGIN
			IF @op = '='
				SELECT * FROM MegaMillions_MegaBall WHERE MegaMillions_MegaBall.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM MegaMillions_MegaBall WHERE MegaMillions_MegaBall.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM MegaMillions_MegaBall WHERE MegaMillions_MegaBall.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM MegaMillions_MegaBall WHERE MegaMillions_MegaBall.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM MegaMillions_MegaBall WHERE MegaMillions_MegaBall.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 6)  -- PowerBall 
		BEGIN
			IF @op = '='
				SELECT * FROM PowerBall WHERE PowerBall.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM PowerBall WHERE PowerBall.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM PowerBall WHERE PowerBall.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM PowerBall WHERE PowerBall.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM PowerBall WHERE PowerBall.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 7)  -- PowerBall_PowerBall 
		BEGIN
			IF @op = '='
				SELECT * FROM PowerBall_PowerBall WHERE PowerBall_PowerBall.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM PowerBall_PowerBall WHERE PowerBall_PowerBall.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM PowerBall_PowerBall WHERE PowerBall_PowerBall.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM PowerBall_PowerBall WHERE PowerBall_PowerBall.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM PowerBall_PowerBall WHERE PowerBall_PowerBall.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 8)  -- NYLotto 
		BEGIN
			IF @op = '='
				SELECT * FROM NYLotto WHERE NYLotto.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM NYLotto WHERE NYLotto.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM NYLotto WHERE NYLotto.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM NYLotto WHERE NYLotto.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM NYLotto WHERE NYLotto.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 9)  -- EuroMillions 
		BEGIN
			IF @op = '='
				SELECT * FROM EuroMillions WHERE EuroMillions.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM EuroMillions WHERE EuroMillions.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM EuroMillions WHERE EuroMillions.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM EuroMillions WHERE EuroMillions.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM EuroMillions WHERE EuroMillions.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 10)  -- EuroMillions_LuckyStars 
		BEGIN
			IF @op = '='
				SELECT * FROM EuroMillions_LuckyStars WHERE EuroMillions_LuckyStars.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM EuroMillions_LuckyStars WHERE EuroMillions_LuckyStars.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM EuroMillions_LuckyStars WHERE EuroMillions_LuckyStars.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM EuroMillions_LuckyStars WHERE EuroMillions_LuckyStars.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM EuroMillions_LuckyStars WHERE EuroMillions_LuckyStars.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 11)  -- OZLotto 
		BEGIN
			IF @op = '='
				SELECT * FROM OZLotto WHERE OZLotto.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM OZLotto WHERE OZLotto.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM OZLotto WHERE OZLotto.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM OZLotto WHERE OZLotto.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM OZLotto WHERE OZLotto.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 12)  -- SSQ 
		BEGIN
			IF @op = '='
				SELECT * FROM SSQ WHERE SSQ.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM SSQ WHERE SSQ.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM SSQ WHERE SSQ.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM SSQ WHERE SSQ.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM SSQ WHERE SSQ.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 13)  -- SSQ_Blue 
		BEGIN
			IF @op = '='
				SELECT * FROM SSQ_Blue WHERE SSQ_Blue.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM SSQ_Blue WHERE SSQ_Blue.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM SSQ_Blue WHERE SSQ_Blue.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM SSQ_Blue WHERE SSQ_Blue.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM SSQ_Blue WHERE SSQ_Blue.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 14)  -- SevenLotto 
		BEGIN
			IF @op = '='
				SELECT * FROM SevenLotto WHERE SevenLotto.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM SevenLotto WHERE SevenLotto.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM SevenLotto WHERE SevenLotto.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM SevenLotto WHERE SevenLotto.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM SevenLotto WHERE SevenLotto.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 15)  -- SuperLotto 
		BEGIN
			IF @op = '='
				SELECT * FROM SuperLotto WHERE SuperLotto.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM SuperLotto WHERE SuperLotto.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM SuperLotto WHERE SuperLotto.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM SuperLotto WHERE SuperLotto.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM SuperLotto WHERE SuperLotto.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 16)  -- SuperLotto_Rear 
		BEGIN
			IF @op = '='
				SELECT * FROM SuperLotto_Rear WHERE SuperLotto_Rear.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM SuperLotto_Rear WHERE SuperLotto_Rear.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM SuperLotto_Rear WHERE SuperLotto_Rear.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM SuperLotto_Rear WHERE SuperLotto_Rear.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM SuperLotto_Rear WHERE SuperLotto_Rear.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 17)  -- NYSweetMillion 
		BEGIN
			IF @op = '='
				SELECT * FROM NYSweetMillion WHERE NYSweetMillion.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM NYSweetMillion WHERE NYSweetMillion.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM NYSweetMillion WHERE NYSweetMillion.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM NYSweetMillion WHERE NYSweetMillion.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM NYSweetMillion WHERE NYSweetMillion.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 18)  -- ColoradoLotto 
		BEGIN
			IF @op = '='
				SELECT * FROM ColoradoLotto WHERE ColoradoLotto.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM ColoradoLotto WHERE ColoradoLotto.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM ColoradoLotto WHERE ColoradoLotto.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM ColoradoLotto WHERE ColoradoLotto.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM ColoradoLotto WHERE ColoradoLotto.DrawNumber>@targetdrawno;
		END
	ELSE IF (@db = 19)  -- FloridaMega 
		BEGIN
			IF @op = '='
				SELECT * FROM FloridaMega WHERE FloridaMega.DrawNumber=@targetdrawno;
			ELSE IF @op = '>='
				SELECT * FROM FloridaMega WHERE FloridaMega.DrawNumber>=@targetdrawno;
			ELSE IF @op = '<='
				SELECT * FROM FloridaMega WHERE FloridaMega.DrawNumber<=@targetdrawno;
			ELSE IF @op = '<'
				SELECT * FROM FloridaMega WHERE FloridaMega.DrawNumber<@targetdrawno;
			ELSE IF @op = '>'
				SELECT * FROM FloridaMega WHERE FloridaMega.DrawNumber>@targetdrawno;
		END
		
