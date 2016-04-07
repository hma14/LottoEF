
import re #RegEx library
#from urllib import urlopen
from Lottotry import Lottotry
from selenium.webdriver.common.by import By
import time

class OregonMegabucks(Lottotry):
	
	def __init__(self, tbl):
		super(OregonMegabucks, self).__init__(tbl)
		driver = self.driver
		driver.get("http://www.oregonlottery.org/GameInfo/Megabucks/")

	def searchDrawDate(self):
		driver = self.driver
					
		span = driver.find_element(By.ID, "ctl00_ctl00_MainContentTop_MainContent_CurrentResults1_Results_ResultsFrom")			
		arr = span.text.split()
		da =  self.dicDate[arr[0]] + '/' + arr[1][:-1] + '/' +  arr[2]
				
		return da
		


	def searchDrawNumbers(self):
		driver = self.driver
		drawNumbers = []
		for i in range(6):
			id = "ctl00_ctl00_MainContentTop_MainContent_CurrentResults1_Results_Number0%d" % (i+1)
			span = driver.find_element(By.ID, id)
			arr = span.text.split()
			drawNumbers.append(arr[0])
		
		return drawNumbers
	
	
	
	
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
		(n1, n2, n3, n4, n5, n6) = self.searchDrawNumbers()
		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6)))
	
		

def main():
	tblName = 'OregonMegabucks'
	lotto = OregonMegabucks(tblName)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()
		
if __name__ == '__main__':
	main()
