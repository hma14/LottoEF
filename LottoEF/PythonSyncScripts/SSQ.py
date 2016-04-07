
#import re #RegEx library
#from urllib import urlopen
from Lottotry import Lottotry
from selenium.webdriver.common.by import By


class SSQ(Lottotry):
	
	def __init__(self, tbl, tbl2):
		super(SSQ, self).__init__(tbl)
		self.dbTable2 = tbl2
				
		driver = self.driver
		driver.get("http://www.zhcw.com/ssq/")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		p = driver.find_element(By.ID, "kj_num")
		cls = p.find_elements(By.CLASS_NAME, "redball_big")
		
		for c in cls:
			numbers.append(c.text)
			
		bonus = p.find_element(By.CLASS_NAME, "blueball_big")
		numbers.append(bonus.text)
			
		print numbers
		return numbers
		

	def searchDrawDate(self):
		
		driver = self.driver
		da = driver.find_element(By.ID, "kj_date")
			
	
		print da.text				
		return da.text


	def dbInsert(self):

		dn = self.dbLastDrawNumber()
		#ddate = self.convertDate()
		ddate = self.searchDrawDate()
		lastdate = self.dbLastDrawDate()

		if ddate == lastdate:
			print ddate
			print lastdate
			print 'Already updated, skip'
			return

		dn += 1
		(n1, n2, n3, n4, n5, n6, b) = self.searchDrawNumbers()
		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6)))

		self.cursor.execute("insert into " + self.dbTable2 + " VALUES(%d, '%s', %d)" % 
							(int(dn), ddate, int(b)))



def main():

	tblName = 'SSQ'
	tblName2 = 'SSQ_Blue'
	lotto = SSQ(tblName, tblName2)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)	
	lotto.updateXMLFile(tblName2)	
	lotto.driver.close()
	lotto.driver.quit()

if __name__ == '__main__':
	main()

	
