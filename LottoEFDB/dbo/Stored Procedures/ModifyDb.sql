


CREATE PROCEDURE [dbo].[ModifyDb](@db int, @mode int, @dno int, @ddate VARCHAR(25),
						  @n1 int, @n2 int, @n3 int, @n4 int, @n5 int, @n6 int, 
						  @n7 int, @n8 int ) AS
						  
		IF @mode = 0  -- Add
			BEGIN
				IF @db = 0  -- Lottery
					BEGIN
						INSERT INTO Lottery VALUES(@dno, @ddate, @n1, @n2, @n3, @n4, @n5, @n6, @n7);
					END
				ELSE  IF @db = 1      -- LottoMax
					BEGIN
						INSERT INTO LottoMax VALUES(@dno, @ddate, @n1, @n2, @n3, @n4, @n5, @n6, @n7, @n8);					
					END
				ELSE  IF @db = 2      -- BC49
					BEGIN
						INSERT INTO BC49 VALUES(@dno, @ddate, @n1, @n2, @n3, @n4, @n5, @n6, @n7);					
					END
				ELSE  IF @db = 3      -- FloridaLotto
					BEGIN
						INSERT INTO FloridaLotto VALUES(@dno, @ddate, @n1, @n2, @n3, @n4, @n5, @n6, @n7);					
					END
				ELSE  IF @db = 4      -- MegoMillions
					BEGIN
						INSERT INTO MegaMillions VALUES(@dno, @ddate, @n1, @n2, @n3, @n4, @n5);					
					END
				ELSE  IF @db = 5      -- PowerBall
					BEGIN
						INSERT INTO PowerBall VALUES(@dno, @ddate, @n1, @n2, @n3, @n4, @n5);					
					END
				ELSE  IF @db = 6      -- NYLotto
					BEGIN
						INSERT INTO NYLotto VALUES(@dno, @ddate, @n1, @n2, @n3, @n4, @n5, @n6, @n7);					
					END
					
			END
		ELSE IF @mode = 1 -- Update
			BEGIN
				IF @db = 0 
					BEGIN 
						UPDATE Lottery SET DrawDate=@ddate, Number1=@n1, Number2=@n2, Number3=@n3, Number4=@n4,  
								Number5=@n5, Number6=@n6,Bonus=@n7 
								WHERE DrawNumber=@dno;
					END
				ELSE IF @db = 1      -- LottoMax
					BEGIN
						UPDATE LottoMax SET DrawDate=@ddate, Number1=@n1, Number2=@n2, Number3=@n3, Number4=@n4, 
								Number5=@n5, Number6=@n6, Number7=@n7, Bonus=@n8 
								WHERE DrawNumber=@dno;					
					END
				ELSE IF @db = 2      -- BC49
					BEGIN
						UPDATE BC49 SET DrawDate=@ddate, Number1=@n1, Number2=@n2, Number3=@n3, Number4=@n4, 
								Number5=@n5, Number6=@n6, Bonus=@n7 
								WHERE DrawNumber=@dno;					
					END
				ELSE IF @db = 3      -- FloridaLotto
					BEGIN
						UPDATE FloridaLotto SET DrawDate=@ddate, Number1=@n1, Number2=@n2, Number3=@n3, Number4=@n4, 
								Number5=@n5, Number6=@n6, Xtra=@n7 
								WHERE DrawNumber=@dno;					
					END
				ELSE IF @db = 4      -- MegaMillions
					BEGIN
						UPDATE MegaMillions SET DrawDate=@ddate, Number1=@n1, Number2=@n2, Number3=@n3, Number4=@n4, 
								Number5=@n5
								WHERE DrawNumber=@dno;					
					END
				ELSE IF @db = 5      -- PowerBall
					BEGIN
						UPDATE PowerBall SET DrawDate=@ddate, Number1=@n1, Number2=@n2, Number3=@n3, Number4=@n4, 
								Number5=@n5 
								WHERE DrawNumber=@dno;					
					END
				ELSE IF @db = 2      -- NYLotto
					BEGIN
						UPDATE NYLotto SET DrawDate=@ddate, Number1=@n1, Number2=@n2, Number3=@n3, Number4=@n4, 
								Number5=@n5, Number6=@n6, Bonus=@n7 
								WHERE DrawNumber=@dno;					
					END
					
			END

