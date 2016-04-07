
import re #RegEx library
#from urllib import urlopen
from Lottotry import Lottotry
from selenium.webdriver.common.by import By

class NewJerseyPick6Lotto(Lottotry):
	
	def __init__(self, tbl):
		super(NewJerseyPick6Lotto, self).__init__(tbl)
		driver = self.driver
		driver.get("https://www.njlottery.com/en-us/drawgames/jackpotgames/pick6lotto.html")
				

	def searchDrawDate(self):

		driver = self.driver
		tim = driver.find_element(By.TAG_NAME, "time")
		dat = tim.get_attribute('datetime') 

		return dat
		


	def searchDrawNumbers(self):
		numbers = []
		driver = self.driver
		odds = driver.find_element(By.CLASS_NAME, "lotto-numbers")
		nums = odds.find_elements(By.TAG_NAME, "i")
		for n in nums:
			numbers.append(n.text)
		
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
		(n1, n2, n3, n4, n5, n6) = self.searchDrawNumbers()
		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6)))
	
		

def main():
	tblName = 'NewJerseyPick6Lotto'
	lotto = NewJerseyPick6Lotto(tblName)	
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()
		
if __name__ == '__main__':
	main()
