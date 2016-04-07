
import re #RegEx library
#from urllib import urlopen
from Lottotry import Lottotry
from selenium.webdriver.common.by import By

class CaSuperlottoPlus(Lottotry):
	
	def __init__(self, tbl, tbl2):
		super(CaSuperlottoPlus, self).__init__(tbl)
		self.dbTable2 = tbl2
		driver = self.driver
		driver.get("http://www.calottery.com/play/draw-games/superlotto-plus")
				

	def searchDrawDate(self):

		driver = self.driver
		dat = driver.find_element(By.CLASS_NAME, "date")	
		arr = dat.text.split()
		da = self.dicDate[arr[1]] + '-' + arr[2][:-1] + '-' + arr[3]
				
		return da
		


	def searchDrawNumbers(self):
		numbers = []
		driver = self.driver
		lis = driver.find_elements(By.XPATH, "//ul[@class='winning_number_sm']/li")
		for li in lis:
			numbers.append(li.text)
		
		print numbers
		return numbers
	
	
	def dbInsert(self):

		dn = self.dbLastDrawNumber()
		ddate = self.searchDrawDate()
		lastdate = self.dbLastDrawDate()
	
 		if ddate == lastdate:
 			print ddate
 			print lastdate
 			print 'Already updated, skip'			
 			return
	
		dn += 1
		(n1, n2, n3, n4, n5, m) = self.searchDrawNumbers()
		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5)))
		self.cursor.execute("insert into " + self.dbTable2 + " VALUES(%d, '%s', %d)" % 
							(int(dn), ddate, int(m)))
	
		

def main():
	tbl = 'CaSuperlottoPlus'
	tbl2 = 'CaSuperlottoPlus_Mega'
	lotto = CaSuperlottoPlus(tbl, tbl2)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tbl)
	lotto.updateXMLFile(tbl2)
	lotto.driver.close()
	lotto.driver.quit()
		
if __name__ == '__main__':
	main()
