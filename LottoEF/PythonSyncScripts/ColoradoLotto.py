import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry

class ColoradoLotto(Lottotry):
	
	def __init__(self, tbl):
		super(ColoradoLotto, self).__init__(tbl)


	def searchDrawNumbers(self):
		numbers = []
		fid = urlopen("http://www.coloradolottery.com/games/lotto/").read()
		
		match = re.search(r'(<div class=\"number\">)(\d+)\s*<.*>\s*(<.*>)(\d+)\s*<.*>\s*(<.*>)(\d+)\s*<.*>\s*(<.*>)(\d+)\s*<.*>\s*(<.*>)(\d+)\s*<.*>\s*(<.*>)(\d+)',
												fid)		
		if match:
			numbers.append(match.group(2))
			numbers.append(match.group(4))
			numbers.append(match.group(6))
			numbers.append(match.group(8))
			numbers.append(match.group(10))
			numbers.append(match.group(12))

			#print numbers
		return numbers

	def convertDate(self):

		dic = {"Jan":"01", "Feb":"02", "Mar":"03", "Apr":"04", "May":"05",
				 "Jun":"06", "Jul":"07", "Aug":"08", "Sep":"09", "Oct":"10",
				 "Nov":"11", "Dec":"12" }
		
		dat = self.searchDrawDate()
		datestr = dic[dat[0]] + '/' + str(dat[1]) + '/' + str(dat[2])
		return datestr


	def searchDrawDate(self):
		ddate = ''
		fid = urlopen("http://www.coloradolottery.com/games/lotto/").read()			
		match = re.search(r'(style=\"text-decoration:none;\">)(\d+\/\d+\/)(\d+)', fid)
		if match:
			ddate += match.group(2)
			ddate += '20' + match.group(3)			
		return ddate


	def dbInsert(self):

		dn = self.dbLastDrawNumber()		
		ddate = self.searchDrawDate()
		
		lastdate = self.dbLastDrawDate()
		if ddate == lastdate:
			print ddate
			print lastdate
			print 'Alread updated, skip'
			return

		dn += 1
		(n1, n2, n3, n4, n5, n6) = self.searchDrawNumbers()
		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6)))


def main():
	tblName = 'ColoradoLotto'
	lotto = ColoradoLotto(tblName)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()
	

if __name__ == '__main__':
	main()

	
