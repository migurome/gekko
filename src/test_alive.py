import yfinance as yf
import sys

#print sys.argv[1]
##print str(yf.Ticker(sys.argv[1]).history(period="1d"))
#print str(yf.Ticker(sys.argv[1]).history(period="2mo"))
test = yf.Ticker("AAI.AX").history(period="2mo")

print len(test)
print test
if len(test) != 0:
    print test
