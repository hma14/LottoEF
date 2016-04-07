import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re

class NYLotto(Lottotry):

	def __init__(self, tbl):
		super(NYLotto, self).__init__(tbl)
				
		driver = self.driver
		driver.get("http://nylottery.ny.gov/wps/portal/!ut/p/c5/04_SB8K8xLLM9MSSzPy8xBz9CP0os_jggBC3kDBPE0MLC0dnA09vT0fLQDNvA0dfU30_j_zcVP1I_ShzXKoCgw30I3NS0xOTK_ULst0cAYmfjdU!/dl3/d3/L0lJSklna21BL0lKakFBRXlBQkVSQ0pBISEvNEZHZ3NvMFZ2emE5SUFnIS83X1NQVEZUVkk0MTg4QUMwSUtJQTlRNkswUVMwL2tvS2ExNjY5MDAwMDE!/?PC_7_SPTFTVI4188AC0IKIA9Q6K0QS0_WCM_CONTEXT=/wps/wcm/connect/NYSL+Content+Library/NYSL+Internet+Site/Home/Jackpot+Games/LOTTO")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		divs = driver.find_elements(By.CLASS_NAME, "WinningNumbersResultsLotto")
		for div in divs:
			numbers.append(div.text)
			
		bonus = driver.find_element(By.CLASS_NAME, "WinningNumbersMegaBallLotto")
		numbers.append(bonus.text)	

		print numbers
		return numbers
		

	def searchDrawDate(self):
		
		driver = self.driver
		dat = driver.find_element(By.CLASS_NAME, "WinningNumbersText")
		print dat.text
				
		dat = self.convertDateText(dat.text)
		return dat	
		

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
		(n1, n2, n3, n4, n5, n6, b) = self.searchDrawNumbers()
		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6), int(b)))
			


def main():
	tblName = 'NYLotto'
	lotto = NYLotto(tblName)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()

if __name__ == '__main__':
	main()

	
